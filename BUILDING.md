# Building and publishing

## Visual Studio

Open `Roundify.sln`.

Select `Release` and `x64`, then **Build > Build Solution**.

## Command line

From the project folder:

```powershell
dotnet restore
dotnet build .\Roundify.csproj -c Release -r win-x64
```

## Self-contained single-file EXE

```powershell
.\publish-win-x64.cmd
```

Output:

```text
publish\win-x64\Roundify.exe
```

## Installer

Install Inno Setup 6 from [jrsoftware.org](https://jrsoftware.org/isinfo.php).
Then publish Roundify and compile the installer:

```powershell
.\publish-win-x64.cmd
.\build-installer.cmd
```

The installer is created at:

```text
publish\Roundify-Setup.exe
```

The installer is per-user and does not require administrator privileges. It
adds a Start Menu shortcut, offers an optional desktop shortcut, and provides
an uninstaller through Windows' installed-apps list. Uninstalling removes
Roundify's startup entry but keeps user settings under `%LOCALAPPDATA%` so they
are available if the app is installed again.

## Debugging

When debugging from Visual Studio, the app starts directly to the tray. Double-click the tray icon (or right-click it and choose Settings) to open the settings window.
