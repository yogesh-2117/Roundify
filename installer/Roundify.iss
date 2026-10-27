#define AppName "Roundify"
#define AppExeName "Roundify.exe"
#define AppVersion GetVersionNumbersString("..\publish\win-x64\Roundify.exe")

[Setup]
AppId={{8982129D-1C17-4A28-AEF1-F82F1EAE375C}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher=Roundify
DefaultDirName={localappdata}\Programs\Roundify
DefaultGroupName=Roundify
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputDir=..\publish
OutputBaseFilename=Roundify-Setup
SetupIconFile=..\Assets\roundify.ico
UninstallDisplayIcon={app}\Roundify.exe
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
CloseApplications=yes
RestartApplications=no

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"

[Files]
Source: "..\publish\win-x64\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Roundify"; Filename: "{app}\{#AppExeName}"
Name: "{autodesktop}\Roundify"; Filename: "{app}\{#AppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExeName}"; Description: "Launch Roundify"; Flags: postinstall nowait skipifsilent

[Code]
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usUninstall then
    RegDeleteValue(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\CurrentVersion\Run', 'Roundify');
end;
