# Roundify

~Description:

This is a lightweight Windows program that makes your screen's (edges) corners rounded, similar to Displaperture, but for Windows.

Roundify creates a transparent overlay around the edges of your monitor(s). The center of the screen remains visible while the corners and optional border are masked.

~Disclaimer:

The current version is designed to work with different resolutions, aspect ratios, multiple monitors, and different DPI settings.

A compiled/deployed EXE is not automatically installed into Windows. Roundify is currently a portable application, so you can place the published EXE anywhere you want.

If you want to build the project yourself you will need Windows and the .NET 10 SDK (or Visual Studio with the .NET desktop development workload).

~Usage:

Run `Roundify.exe` from the published folder.

Roundify starts in the system tray. Right-click the Roundify tray icon to:

- Enable or disable Roundify.
- Open Settings.
- Enable or disable Start with Windows.
- Exit Roundify.

In Settings you can change the corner radius, border thickness, and always-on-top behavior.

~Requirements:

For development/building:

- Windows 10 version 1809 or later, or Windows 11.
- .NET 10 SDK.
- Visual Studio with the .NET desktop development workload, or the .NET SDK command-line tools.

For the self-contained published version:

- No separate .NET runtime installation is required.

~Build / Deployment:

The repository contains scripts for building, publishing, and packaging Roundify.

**`build-win-x64.cmd`**

This performs a normal Release build for Windows x64:

`dotnet build Roundify.csproj -c Release -r win-x64 --self-contained false`

The build output is placed under:

`bin\\Release\\net10.0-windows\\win-x64\\`

The executable is normally:

`bin\\Release\\net10.0-windows\\win-x64\\Roundify.exe`

This is intended primarily for development/testing. Because it is **not self-contained**, the target PC needs the compatible .NET desktop runtime installed.

**`publish-win-x64.cmd`**

This creates the recommended portable deployment:

`dotnet publish Roundify.csproj -c Release -r win-x64 --self-contained true`

It also enables single-file publishing and several Release optimizations.

The final executable is:

`publish\\win-x64\\Roundify.exe`

This published version is self-contained, so users do **not** need to install .NET separately.

You can also publish manually with:

`dotnet publish Roundify.csproj -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:EnableCompressionInSingleFile=true -p:PublishReadyToRun=true -p:PublishTrimmed=false -p:DebugType=None -o publish\\win-x64`

~Installation:

For an easier installation, download and run `Roundify-Setup.exe` when it is
available in a project release. The installer installs Roundify for the
current Windows user under `%LOCALAPPDATA%\\Programs\\Roundify`, creates a
Start Menu shortcut, and offers an optional desktop shortcut. Administrator
privileges are not required. The installer also offers to launch Roundify when
setup finishes.

To build the installer yourself, install Inno Setup 6, then run:

`publish-win-x64.cmd`

`build-installer.cmd`

The installer is created at `publish\\Roundify-Setup.exe`.

The self-contained published app can also be used portably without running the
installer. Place the published files in a folder of your choice and run
`Roundify.exe`. The portable version does not create shortcuts or register an
uninstaller.

~Auto launch at startup:

Roundify has a **Start with Windows** option in the tray menu and Settings window.

When enabled, Roundify creates a per-user Windows startup entry at:

`HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run`

The value name is:

`Roundify`

The value points to the current `Roundify.exe` path.

This means Roundify launches automatically when the current Windows user logs in. Administrator privileges are not required for this per-user startup entry.

If you move `Roundify.exe` after enabling startup, the stored startup path can become invalid. Move the EXE first, then disable and re-enable **Start with Windows** so the registry entry is updated.

~Configuration:

Roundify stores its user configuration in:

`%LOCALAPPDATA%\\Roundify\\settings.json`

On a typical installation this is:

`C:\\Users\\<YourUserName>\\AppData\\Local\\Roundify\\settings.json`

The file contains settings such as:

- Enabled/disabled state.
- Corner radius.
- Border thickness.
- Always-on-top.
- Start with Windows.

The configuration is created automatically when Roundify saves settings for the first time.

~How to remove Roundify:

If you installed Roundify with `Roundify-Setup.exe`, uninstall it from Windows
**Settings > Apps > Installed apps** or from the Roundify entry in the Start
Menu. The uninstaller removes the app and its startup entry, but keeps your
settings under `%LOCALAPPDATA%\\Roundify` so they are available if you reinstall.

To remove those settings too, delete `%LOCALAPPDATA%\\Roundify` after
uninstalling.

If you are using the portable version:

1. Exit Roundify from the system tray.
2. Disable **Start with Windows** before deleting the executable.
3. Delete the folder containing `Roundify.exe`.
4. Optionally delete `%LOCALAPPDATA%\\Roundify` to remove your settings.

If you already deleted the portable EXE and forgot to disable startup, remove
the startup entry with PowerShell:

`Remove-ItemProperty -Path "HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Run" -Name "Roundify" -ErrorAction SilentlyContinue`

Or remove the `Roundify` value manually from:

`HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run`

~Performance:

Roundify is designed to use very little CPU while idle.

The overlay does not continuously poll the desktop with a timer. Overlay windows are updated when settings change and when Windows reports a display configuration change.

The application also uses a single-instance mutex, per-monitor overlay windows, and WPF geometry rather than a continuously animated bitmap.

Actual CPU and memory usage will vary depending on Windows version, number of monitors, DPI settings, and whether the Settings window is open.

~Features:

Implemented:

- Application icon.
- Run invisibly in the background.
- System tray controls.
- Low-CPU event-driven overlay updates.
- Adjustable corner radius.
- Adjustable border thickness.
- Start with Windows.
- JSON configuration file.
- Multiple monitor support.
- More screen resolutions and aspect ratios.
- Per-monitor DPI scaling.
- Optional always-on-top overlay.
- Single-instance protection.
- Self-contained Windows x64 publishing.

Features to be added:

- Custom border color.
- Border transparency/opacity.
- Per-application exclusions.
- Better fullscreen/game handling.
- Custom overlay profiles.
- Global hotkeys.
- More advanced Settings UI.
- Automatic updates.
- Additional performance tuning.

~Remarks:

Please, if you can help develop my project or have any ideas, open an Issue ticket or make a Pull Request with a detailed description of your code, what you changed, why you changed it, and how it was tested.

Please keep the project lightweight and avoid unnecessary dependencies.

The project intentionally does **not** run as a Windows Service. The overlay has to run in the user's interactive desktop session, so **Start with Windows** launches the normal Roundify tray application when the user logs in.

~Project files:

- `Roundify.sln` - Visual Studio solution.
- `Roundify.csproj` - Main WPF project.
- `build-win-x64.cmd` - Normal Release x64 build.
- `publish-win-x64.cmd` - Self-contained single-file Windows x64 deployment.
- `build-installer.cmd` - Packages the published app using Inno Setup 6.
- `installer\\Roundify.iss` - Inno Setup installer definition.
- `check-dotnet.cmd` - Diagnostic helper for checking the installed .NET SDK/workload environment.
- `global.json` - Pins the project to SDK 10.0.401 with latest-patch roll-forward.
- `%LOCALAPPDATA%\\Roundify\\settings.json` - User configuration created at runtime.

~Troubleshooting:

If you see errors such as:

`MSB4276: The default SDK resolver failed to resolve SDK "Microsoft.NET.SDK.WorkloadAutoImportPropsLocator"`

or:

`MSB6011: Invalid parameters passed to the Microsoft.NET.Build.Tasks.RunCsWinRTGenerator task`

run:

`check-dotnet.cmd`

If the workload resolver directory is missing, repair the .NET SDK/workload installation before building.

Roundify itself does not require WinUI, Windows App SDK, or CsWinRT packages.

The project uses `global.json` so Visual Studio and the command line use the intended .NET SDK rather than silently selecting a different SDK.
