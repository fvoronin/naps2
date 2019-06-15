using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using NAPS2.Lang.Resources;
using NAPS2.Logging;
using NAPS2.Platform;
using NAPS2.Remoting.Worker;
using NAPS2.Util;

namespace NAPS2.ImportExport.Email.Mapi
{
    public class MapiEmailProvider : IEmailProvider
    {
        private readonly IWorkerFactory workerFactory;
        private readonly IMapiWrapper mapiWrapper;
        private readonly ErrorOutput errorOutput;

        public MapiEmailProvider(IWorkerFactory workerFactory, IMapiWrapper mapiWrapper, ErrorOutput errorOutput)
        {
            this.workerFactory = workerFactory;
            this.mapiWrapper = mapiWrapper;
            this.errorOutput = errorOutput;
        }

        private bool UseWorker => Environment.Is64BitProcess && PlatformCompat.Runtime.UseWorker;

        /// <summary>
        /// Sends an email described by the given message object.
        /// </summary>
        /// <param name="message">The object describing the email message.</param>
        /// <param name="progressCallback"></param>
        /// <param name="cancelToken"></param>
        /// <returns>Returns true if the message was sent, false if the user aborted.</returns>
        public async Task<bool> SendEmail(EmailMessage message, ProgressHandler progressCallback, CancellationToken cancelToken)
        {
            return await Task.Run(() =>
            {
                MapiSendMailReturnCode returnCode;

                if (UseWorker && !mapiWrapper.CanLoadClient)
                {
                    using (var worker = workerFactory.Create())
                    {
                        returnCode = worker.Service.SendMapiEmail(message);
                    }
                }
                else
                {
                    returnCode = mapiWrapper.SendEmail(message);
                }

                // Process the result
                if (returnCode == MapiSendMailReturnCode.UserAbort)
                {
                    return false;
                }

                if (returnCode != MapiSendMailReturnCode.Success)
                {
                    Log.Error("Error sending email. MAPI error code: {0}", returnCode);
                    errorOutput.DisplayError(MiscResources.EmailError, $"MAPI returned error code: {returnCode}");
                    return false;
                }

                return true;
            });
        }
    }
}
