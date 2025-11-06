# Running the MPLAB Simulator (Without External IDE)

## Quick Options

### Option 1: Launch MPLAB X IDE from Terminal (Recommended)

Since you have the project configured, you can launch MPLAB X directly:

**Easy way - Use the launch script:**
```bash
cd "/Users/lucasertugrul/LocalRepos/Year 3 Physics/MicroprocessorsLab"
./launch-mplab.sh
```

**Direct command:**
```bash
# Navigate to your project
cd "/Users/lucasertugrul/LocalRepos/Year 3 Physics/MicroprocessorsLab"

# Launch MPLAB X IDE (use full path with version)
open -a "/Applications/microchip/mplabx/v6.25/MPLAB X IDE v6.25.app" .
```

**Or create an alias (add to ~/.zshrc):**
```bash
alias mplab='open -a "/Applications/microchip/mplabx/v6.25/MPLAB X IDE v6.25.app"'
# Then use: mplab .
```

Then in MPLAB X:
1. Build: `F11` or right-click project → Build
2. Debug: `F6` to start simulator with debugging
3. View data: See `SIMULATOR_GUIDE.md` for all windows

### Option 2: Use MPLAB X Command Line (Limited)

MPLAB X has limited command-line support for the simulator. The simulator GUI is the primary interface.

### Option 3: VS Code Integration (If MPLAB Extension Available)

If you have the MPLAB X extension installed in VS Code:
1. Look for MPLAB X commands in the Command Palette (`Cmd+Shift+P`)
2. Search for "MPLAB" commands
3. Use "MPLAB: Debug" or "MPLAB: Run" if available

## Disable .NET Warnings

The .NET Core SDK warning is harmless - it's from VS Code extensions trying to detect .NET projects. I've updated your settings to suppress these warnings.

**To disable .NET extensions completely:**
1. Open VS Code Extensions (`Cmd+Shift+X`)
2. Search for "C#" or ".NET"
3. Disable or uninstall:
   - C# (ms-dotnettools.csharp)
   - .NET Core Tools
   - OmniSharp

The warnings should now be gone after restarting VS Code.

## Build Your Project

You can build from VS Code using CMake:

1. **Using CMake Tools extension:**
   - Press `Cmd+Shift+P`
   - Type "CMake: Build"
   - Select your build target

2. **Using Terminal:**
   ```bash
   cd "/Users/lucasertugrul/LocalRepos/Year 3 Physics/MicroprocessorsLab"
   cmake --build _build/Simple1/default
   ```

The output `.elf` file will be at: `out/Simple1/default.elf`

## View Build Output

After building, you can:
- View the `.hex` file: `out/Simple1/default.hex`
- View symbols: `out/Simple1/default.sym`
- View listing: Check `_build/Simple1/default/` for object files

## Note

The MPLAB Simulator is a GUI application - there's no pure command-line way to run it with full debugging capabilities. You need MPLAB X IDE to:
- Set breakpoints visually
- View watch windows
- Use Logic Analyzer
- Monitor registers in real-time
- Step through code

The simulator is designed to be used through MPLAB X IDE's interface.

