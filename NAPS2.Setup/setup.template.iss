; !defs

[Setup]
AppName=NAPS2 - Not Another PDF Scanner
AppVerName=NAPS2 {#AppVersion}
AppPublisher=Ben Olden-Cooligan
AppPublisherURL=https://www.naps2.com
AppSupportURL=https://www.naps2.com/support.html
AppUpdatesURL=https://www.naps2.com/download.html
DefaultDirName={commonpf}\NAPS2
DefaultGroupName=NAPS2
OutputDir=../publish/{#AppVersion}
OutputBaseFilename=naps2-{#AppVersion}-{#AppPlatform}       
Compression=lzma2/ultra
LZMAUseSeparateProcess=yes
SolidCompression=yes
; !arch

LicenseFile=..\..\LICENSE
UninstallDisplayIcon={app}\NAPS2.exe

[Run]
Filename: "{app}\NAPS2.exe"; Flags: nowait postinstall

; Only NAPS2-translated languages are included (to avoid misleading users)
[Languages]
Name: "english";              MessagesFile: "compiler:Default.isl"
Name: "Afrikaans";            MessagesFile: "..\..\NAPS2.Setup\inno-lang\Afrikaans.isl";
Name: "Albanian";             MessagesFile: "..\..\NAPS2.Setup\inno-lang\Albanian.isl";
Name: "Arabic";               MessagesFile: "..\..\NAPS2.Setup\inno-lang\Arabic.isl";
; Name: "Bengali";              MessagesFile: "..\..\NAPS2.Setup\inno-lang\Bengali.isl";
Name: "BrazilianPortuguese";  MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\BrazilianPortuguese.isl"; 
Name: "Bulgarian";            MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Bulgarian.isl"; 
Name: "Catalan";              MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Catalan.isl";
Name: "ChineseSimplified";    MessagesFile: "..\..\NAPS2.Setup\inno-lang\ChineseSimplified.isl";
Name: "ChineseTraditional";   MessagesFile: "..\..\NAPS2.Setup\inno-lang\ChineseTraditional.isl";
Name: "Croatian";             MessagesFile: "..\..\NAPS2.Setup\inno-lang\Croatian.isl";
Name: "Czech";                MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Czech.isl";
Name: "Danish";               MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Danish.isl"; 
Name: "Dutch";                MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Dutch.isl"; 
Name: "Estonian";             MessagesFile: "..\..\NAPS2.Setup\inno-lang\Estonian.isl";
Name: "Farsi";                MessagesFile: "..\..\NAPS2.Setup\inno-lang\Farsi.isl";
Name: "Finnish";              MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Finnish.isl";
Name: "French";               MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\French.isl";
Name: "German";               MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\German.isl";
Name: "Greek";                MessagesFile: "..\..\NAPS2.Setup\inno-lang\Greek.isl";
Name: "Hebrew";               MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Hebrew.isl";
; Name: "Hindi";                MessagesFile: "..\..\NAPS2.Setup\inno-lang\Hindi.isl";
Name: "Hungarian";            MessagesFile: "..\..\NAPS2.Setup\inno-lang\Hungarian.isl";
; Name: "Indonesian";           MessagesFile: "..\..\NAPS2.Setup\inno-lang\Indonesian.isl";
Name: "Italian";              MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Italian.isl";
Name: "Japanese";             MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Japanese.isl";
Name: "Korean";               MessagesFile: "..\..\NAPS2.Setup\inno-lang\Korean.isl";
Name: "Latvian";              MessagesFile: "..\..\NAPS2.Setup\inno-lang\Latvian.isl";
Name: "Lithuanian";           MessagesFile: "..\..\NAPS2.Setup\inno-lang\Lithuanian.isl";
Name: "Norwegian";            MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Norwegian.isl";
Name: "NorwegianNynorsk";     MessagesFile: "..\..\NAPS2.Setup\inno-lang\NorwegianNynorsk.isl";
Name: "Polish";               MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Polish.isl";
Name: "Portuguese";           MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Portuguese.isl";
Name: "Romanian";             MessagesFile: "..\..\NAPS2.Setup\inno-lang\Romanian.isl";
Name: "Russian";              MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Russian.isl";
Name: "SerbianCyrillic";      MessagesFile: "..\..\NAPS2.Setup\inno-lang\SerbianCyrillic.isl";
Name: "SerbianLatin";         MessagesFile: "..\..\NAPS2.Setup\inno-lang\SerbianLatin.isl";
Name: "Sinhala";              MessagesFile: "..\..\NAPS2.Setup\inno-lang\Sinhala.isl";
Name: "Slovak";               MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Slovak.isl"; 
Name: "Slovenian";            MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Slovenian.isl"; 
Name: "Spanish";              MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Spanish.isl";
Name: "Swedish";              MessagesFile: "..\..\NAPS2.Setup\inno-lang\Swedish.isl";
; Name: "Thai";                 MessagesFile: "..\..\NAPS2.Setup\inno-lang\Thai.isl";
Name: "Turkish";              MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Turkish.isl"; 
Name: "Ukrainian";            MessagesFile: "C:\Program Files (x86)\Inno Setup 6\Languages\Ukrainian.isl";
; Name: "Urdu";                 MessagesFile: "..\..\NAPS2.Setup\inno-lang\Urdu.isl";
Name: "Vietnamese";           MessagesFile: "..\..\NAPS2.Setup\inno-lang\Vietnamese.isl";

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]                              
; !files

; Delete files from old locations in case of upgrade
[InstallDelete]     
Type: files; Name: "{app}\*.exe"
Type: files; Name: "{app}\*.exe.config"
Type: filesandordirs; Name: "{app}\lib"
; !clean32

[Icons]
Name: "{group}\NAPS2"; Filename: "{app}\NAPS2.exe"
Name: "{commondesktop}\NAPS2"; Filename: "{app}\NAPS2.exe"; Tasks: desktopicon

[Registry]
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers\WIA_{{1c3a7177-f3a7-439e-be47-e304a185f932}"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers\WIA_{{1c3a7177-f3a7-439e-be47-e304a185f932}"; ValueType: string; ValueName: "Action"; ValueData: "Scan with NAPS2"
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers\WIA_{{1c3a7177-f3a7-439e-be47-e304a185f932}"; ValueType: string; ValueName: "CLSID"; ValueData: "WIACLSID"
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers\WIA_{{1c3a7177-f3a7-439e-be47-e304a185f932}"; ValueType: string; ValueName: "DefaultIcon"; ValueData: "sti.dll,0"
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers\WIA_{{1c3a7177-f3a7-439e-be47-e304a185f932}"; ValueType: string; ValueName: "InitCmdLine"; ValueData: "/WiaCmd;{app}\NAPS2.exe /StiDevice:%1 /StiEvent:%2;"
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers\WIA_{{1c3a7177-f3a7-439e-be47-e304a185f932}"; ValueType: string; ValueName: "Provider"; ValueData: "NAPS2"

Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\StillImage\Registered Applications"; Flags:uninsdeletevalue; ValueType: string; ValueName: "NAPS2"; ValueData: "{app}\NAPS2.exe"

Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\StillImage\Events\STIProxyEvent\{{1c3a7177-f3a7-439e-be47-e304a185f932}"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\StillImage\Events\STIProxyEvent\{{1c3a7177-f3a7-439e-be47-e304a185f932}"; ValueType: string; ValueName: "Cmdline"; ValueData: "{app}\NAPS2.exe /StiDevice:%1 /StiEvent:%2"
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\StillImage\Events\STIProxyEvent\{{1c3a7177-f3a7-439e-be47-e304a185f932}"; ValueType: string; ValueName: "Desc"; ValueData: "Scan with NAPS2"
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\StillImage\Events\STIProxyEvent\{{1c3a7177-f3a7-439e-be47-e304a185f932}"; ValueType: string; ValueName: "Icon"; ValueData: "{app}\NAPS2.exe,0"
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\StillImage\Events\STIProxyEvent\{{1c3a7177-f3a7-439e-be47-e304a185f932}"; ValueType: string; ValueName: "Name"; ValueData: "NAPS2"

