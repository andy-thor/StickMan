; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "StickMan"
#define MyAppVersion "0.3.1"
#define MyAppURL "https://andy-thor.github.io/StickMan"
#define MyAppExeName "stickman"
#define MsysInstaller "msys2-x86_64-20190524.exe"
#define ScriptPreBuild "download-msys.bat"
#define BuildInstaller "build-install.bat"
#define RequirementsWin "requirements-win.txt"
#define DescApp "A little toon that moves on your desktop"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{C865FCC9-4782-4A19-B407-8996F839E63C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Remove the following line to run in administrative install mode (install for all users.)
; PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=commandline
OutputBaseFilename=stickman
SetupIconFile=data\icons\stickman.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "stickman"; DestDir: "{app}"; Flags: ignoreversion
Source: "src-win\run.cmd"; DestDir: "{app}"; Flags: ignoreversion
Source: "src-win\run.vbs"; DestDir: "{app}"; Flags: ignoreversion
Source: "src-win\{#ScriptPreBuild}"; Flags: dontcopy
Source: "src-win\{#BuildInstaller}"; Flags: dontcopy
Source: "src-win\requirements-win.txt"; Flags: dontcopy noencryption
Source: "src\*"; DestDir: "{app}\src"
Source: "data\*"; DestDir: "{app}\data"
Source: "data\icons\*"; DestDir: "{app}\data\icons"
Source: "data\images\*"; DestDir: "{app}\data\images"

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\run.vbs"; Comment: {#DescApp}; Tasks: desktopicon; IconFilename: {app}\data\icons\stickman.ico;
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\run.vbs"; Comment: {#DescApp}; Tasks: desktopicon; IconFilename: {app}\data\icons\stickman.ico;
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\run.vbs"; Comment: {#DescApp}; IconFilename: {app}\data\icons\stickman.ico;

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  Path: string;
  TempDir: string;
  Sentence: string;
  ResultCode: Integer;
  Installation: boolean;
begin
  Installation := True;
  if (CurStep = ssInstall) then
  begin
    WizardForm.ProgressGauge.Style := npbstMarquee;
    WizardForm.StatusLabel.Caption := 'Download MSYS2. This may take a few minutes...';
    // Download MSYS2
    ExtractTemporaryFile(ExpandConstant('{#ScriptPreBuild}'));
    Path := ExpandConstant('{tmp}\{#ScriptPreBuild}');
    if not Exec('cmd.exe', '/c "' + Path + '"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
    begin
      MsgBox('Download of MSYS2 failed.', mbError, MB_OK);
      Installation := False;
    end
    else begin
      // Installation
      WizardForm.StatusLabel.Caption := 'Install MSYS2. This may take a few minutes...';
      Path := ExpandConstant('{tmp}\{#MsysInstaller}');
      TempDir := ExtractFileDir(ExtractFileDir(Path));
      Sentence := AddQuotes(ExpandConstant(TempDir + '\{#MsysInstaller}'));
      if not Exec(Sentence, '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
      begin
        MsgBox('Installation of MSYS2 failed.', mbError, MB_OK);
        Installation := False;
      end;
    end;
    
    if Installation then
    begin
      WizardForm.StatusLabel.Caption := 'Setting up MSYS2 environment. This may take some time ...';
      ExtractTemporaryFile(ExpandConstant('{#BuildInstaller}')); 
      ExtractTemporaryFile('{#RequirementsWin}');
      Path := ExpandConstant('{tmp}\{#BuildInstaller}');
      Exec('cmd.exe', '/c "' + Path + ' first-update"', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
      Exec('cmd', '/c ' + Path , '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
      if ResultCode <> 0 then
      begin
        WizardForm.StatusLabel.Caption := 'Configuration of MSYS2 failed.';
        Installation := False;
        if ResultCode = 2 then
        begin
          MsgBox('The MSYS2 installation path could not be located. Make sure the directory is installed in C:\msys64',
                  mbError, MB_OK);
        end
        else if ResultCode = 3 then
        begin
          MsgBox('There was an error trying to open a file that does not exist.',
                  mbError, MB_OK);
        end
        else if ResultCode = 4 then
        begin
          MsgBox('MSYS2 shell is not installed.', mbCriticalError, MB_OK);
        end
        else begin
          MsgBox('Unexpected error.', mbError, MB_OK);
        end;  
      end;
    end;

    WizardForm.ProgressGauge.Style := npbstNormal;
    WizardForm.StatusLabel.Caption := '';
    if not Installation then
    begin
      MsgBox('There was a problem. Please try again.', mbCriticalError, MB_OK);
    end
    else begin
      MsgBox('The installation process is almost complete. Just wait a moment until the ' + 
             'installation of the remaining files is complete...', mbInformation, MB_OK);
    end;
  end;
end;