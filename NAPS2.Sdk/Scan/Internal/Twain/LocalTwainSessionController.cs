#if !MAC
using System.Reflection;
using System.Threading;
using NAPS2.Scan.Exceptions;
using NAPS2.Unmanaged;
using NTwain;
using NTwain.Data;

namespace NAPS2.Scan.Internal.Twain;

/// <summary>
/// Real implementation of ITwainSessionController that interacts with a Twain session in the current process.
/// </summary>
public class LocalTwainSessionController : ITwainSessionController
{
    public static readonly TWIdentity TwainAppId =
        TWIdentity.CreateFromAssembly(DataGroups.Image | DataGroups.Control, Assembly.GetEntryAssembly());

    static LocalTwainSessionController()
    {
#if DEBUG
        PlatformInfo.Current.Log.IsDebugEnabled = true;
#endif
    }

    private static readonly LazyRunner TwainDsmSetup = new(() =>
    {
        var twainDsmPath = NativeLibrary.FindLibraryPath("twaindsm.dll");
        PlatformCompat.System.LoadLibrary(twainDsmPath);
    });

    public Task<List<ScanDevice>> GetDeviceList(ScanOptions options)
    {
        if (options.TwainOptions.Dsm != TwainDsm.Old)
        {
            TwainDsmSetup.Run();
        }
        return Task.Run(() =>
        {
            var deviceList = InternalGetDeviceList(options);
            if (options.TwainOptions.Dsm != TwainDsm.Old && deviceList.Count == 0)
            {
                // Fall back to OldDsm in case of no devices
                // This is primarily for Citrix support, which requires using twain_32.dll for TWAIN passthrough
                deviceList = InternalGetDeviceList(options);
            }

            return deviceList;
        });
    }

    private static List<ScanDevice> InternalGetDeviceList(ScanOptions options)
    {
        PlatformInfo.Current.PreferNewDSM = options.TwainOptions.Dsm != TwainDsm.Old;
        var session = new TwainSession(TwainAppId);
        session.Open();
        try
        {
            return session.GetSources().Select(ds => new ScanDevice(ds.Name, ds.Name)).ToList();
        }
        finally
        {
            try
            {
                session.Close();
            }
            catch (Exception e)
            {
                Log.ErrorException("Error closing TWAIN session", e);
            }
        }
    }

    public async Task StartScan(ScanOptions options, ITwainEvents twainEvents, CancellationToken cancelToken)
    {
        if (options.TwainOptions.Dsm != TwainDsm.Old)
        {
            TwainDsmSetup.Run();
        }
        try
        {
            await InternalScan(options.TwainOptions.Dsm, options, cancelToken, twainEvents);
        }
        catch (DeviceNotFoundException)
        {
            if (options.TwainOptions.Dsm != TwainDsm.Old)
            {
                // Fall back to OldDsm in case of no devices
                // This is primarily for Citrix support, which requires using twain_32.dll for TWAIN passthrough
                await InternalScan(TwainDsm.Old, options, cancelToken, twainEvents);
            }
            else
            {
                throw;
            }
        }
    }

    private async Task InternalScan(TwainDsm dsm, ScanOptions options, CancellationToken cancelToken,
        ITwainEvents twainEvents)
    {
        var runner = new TwainSessionScanRunner(TwainAppId, dsm, options, cancelToken, twainEvents);
        await runner.Run();
    }
}
#endif