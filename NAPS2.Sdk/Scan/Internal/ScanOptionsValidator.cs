﻿using NAPS2.Serialization;

namespace NAPS2.Scan.Internal;

// TODO: Add tests for this and/or scanperformer
public class ScanOptionsValidator
{
    public ScanOptions ValidateAll(ScanOptions options, ScanningContext scanningContext, bool requireDevice)
    {
        // Easy deep copy. Ideally we'd do this in a more efficient way.
        options = options.ToXml().FromXml<ScanOptions>();

        options.Driver = ValidateDriver(options);
        if (options.Driver == Driver.Sane)
        {
            options.UseNativeUI = false;
        }

        if (requireDevice)
        {
            if (string.IsNullOrEmpty(options.Device?.ID))
            {
                throw new ArgumentException("ScanOptions.Device.ID must be specified");
            }
        }

        if (options.PageSize == null)
        {
            options.PageSize = PageSize.Letter;
        }
        if (options.Dpi == 0)
        {
            options.Dpi = 100;
        }
        if (options.Dpi < 0)
        {
            throw new ArgumentException("Invalid value for ScanOptions.Dpi.");
        }
        if (options.Brightness != options.Brightness.Clamp(-1000, 1000))
        {
            throw new ArgumentException("Invalid value for ScanOptions.Brightness.");
        }
        if (options.Contrast != options.Contrast.Clamp(-1000, 1000))
        {
            throw new ArgumentException("Invalid value for ScanOptions.Contrast.");
        }
        if (options.ScaleRatio == 0)
        {
            options.ScaleRatio = 1;
        }
        if (options.ScaleRatio < 0)
        {
            throw new ArgumentException("Invalid value for ScanOptions.ScaleRatio.");
        }

        if (!string.IsNullOrEmpty(options.OcrParams.LanguageCode) && scanningContext.OcrEngine == null)
        {
            throw new ArgumentException("OCR is enabled but no OCR engine is set on ScanningContext.");
        }

        if (string.IsNullOrEmpty(options.NetworkOptions.Ip) != (options.NetworkOptions.Port == null))
        {
            throw new ArgumentException("NetworkOptions.Ip and .Port must both be either set or unset.");
        }

        // TODO: Do we need to validate the presence of a device?
        // TODO: Probably more things as well.

        return options;
    }

    public Driver ValidateDriver(ScanOptions options)
    {
        if (options.Driver == Driver.Default)
        {
            return GetSystemDefaultDriver();
        }
        // TODO: Throw NotSupportedException if the platform doesn't match the driver
        return options.Driver;
    }

    private Driver GetSystemDefaultDriver()
    {
        switch (Environment.OSVersion.Platform)
        {
            case PlatformID.Win32NT:
                return Driver.Wia;
            case PlatformID.Unix:
                return Driver.Sane;
            case PlatformID.MacOSX:
                return Driver.Twain;
            default:
                throw new InvalidOperationException("Unsupported operating system.");
        }
    }
}