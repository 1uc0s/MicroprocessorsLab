# Running the Simulator and Viewing Data

This guide explains how to run your PIC18F87K22 program in the MPLAB X Simulator and view all relevant data.

## Prerequisites

- **MPLAB X IDE** installed (version 5.50 or later recommended)
- **XC8 Compiler** (for PIC18)
- **PIC18F-K_DFP** device pack (version 1.14.301 as configured)

## Method 1: Using MPLAB X IDE (Recommended)

### Step 1: Open the Project

1. Launch **MPLAB X IDE**
2. Go to `File` → `Open Project...`
3. Navigate to your project directory: `/Users/lucasertugrul/LocalRepos/Year 3 Physics/MicroprocessorsLab`
4. Select the project folder and click `Open Project`

### Step 2: Select the Simulator

1. In the toolbar, click the **Device/Project Configuration** dropdown
2. Select **Simulator** as your tool (it should already be configured)
3. Verify the device is set to **PIC18F87K22**

### Step 3: Build the Project

1. Right-click on the project in the Projects window
2. Select `Build` (or press `F11`)
3. Ensure the build completes successfully
4. The output `.elf` file should be at: `out/Simple1/default.elf`

### Step 4: Run the Simulator

1. Click the **Debug** button (green play icon with bug) or press `F6`
   - This will start the simulator and begin debugging
2. Alternatively, click **Run** (green play icon) or press `Shift+F6` to run without debugging

### Step 5: View Data in Simulator

Once the simulator is running, you can view data using these windows:

#### A. Watch Window (Variables and Registers)
- Go to `Window` → `Debugging` → `Watch`
- Add variables to watch:
  - `waveValue` (address 0x08)
  - `direction` (address 0x09)
  - `PORTJ` (output port)
  - `PORTD` (input port)
  - `PORTC`, `PORTE`, `PORTF`, `PORTG`

#### B. Variables Window
- Go to `Window` → `Debugging` → `Variables`
- Shows all local and global variables automatically

#### C. Memory Window
- Go to `Window` → `Debugging` → `Memory`
- View memory locations:
  - **File Registers**: Shows RAM (0x000-0xFFF)
  - **Program Memory**: Shows flash memory with your code
  - **EEPROM**: Shows EEPROM data

#### D. SFR (Special Function Registers) Window
- Go to `Window` → `Debugging` → `SFR Memory`
- Monitor all peripheral registers:
  - **PORTA-PORTJ**: I/O ports
  - **TRISA-TRISJ**: Port direction registers
  - **STATUS**: Status register (Z flag, etc.)
  - **TMR0-TMR3**: Timer registers
  - And many more...

#### E. I/O View
- Go to `Window` → `Debugging` → `I/O View`
- Visual representation of I/O ports
- You can click pins to toggle them (for PORTD input simulation)

#### F. Logic Analyzer
- Go to `Window` → `Debugging` → `Logic Analyzer`
- Add signals:
  - `PORTJ` (all 8 bits) - to see your triangle wave output
  - `PORTD` - to see input changes
- Useful for visualizing the waveform over time

#### G. Stopwatch Window
- Go to `Window` → `Debugging` → `Stopwatch`
- Measure execution time of your code sections
- Useful for verifying delay timing

#### H. Trace Window
- Go to `Window` → `Debugging` → `Trace`
- View instruction execution history
- Enable via: `Window` → `Debugging` → `Trace Control`

### Step 6: Control Execution

- **Step Over** (`F8`): Execute one line, stepping over function calls
- **Step Into** (`F7`): Execute one instruction, stepping into functions
- **Step Out** (`Ctrl+F7`): Execute until current function returns
- **Run** (`F5`): Continue execution
- **Pause** (`Ctrl+F8`): Pause execution
- **Reset** (`Ctrl+Shift+F5`): Reset the simulator

### Step 7: Set Breakpoints

1. Click in the left margin next to a line of code (or press `Ctrl+F8`)
2. Red dot appears = breakpoint set
3. Program will pause when it reaches the breakpoint
4. Useful breakpoints for your code:
   - Line 36 (`start:` label) - beginning of main program
   - Line 42 (`loop:` label) - main loop
   - Line 52 (`increment:` label) - when incrementing
   - Line 60 (`decrement:` label) - when decrementing

## Method 2: Using Command Line (Advanced)

If you prefer command line or automation:

### Using MPLAB X IPE (Command Line)

```bash
# Navigate to project directory
cd "/Users/lucasertugrul/LocalRepos/Year 3 Physics/MicroprocessorsLab"

# Run simulator (requires MPLAB X command line tools)
# Note: Full command-line simulator access is limited
```

### Using MPLAB X Headless Mode

MPLAB X supports headless debugging but requires configuration files.

## Viewing Your Specific Program Data

For your triangle wave generator program, monitor:

### Key Variables:
- **waveValue** (0x08): Current waveform value (0-255)
- **direction** (0x09): 0 = increment, 1 = decrement
- **0x20-0x22**: Delay counter variables

### Key Registers:
- **PORTJ** (0xF81): Output port (DAC input - triangle wave output)
- **PORTD** (0xF83): Input port (delay control)
- **TRISJ** (0xF93): Port J direction (should be 0x00 = all outputs)
- **TRISD** (0xF95): Port D direction (should be 0xFF = all inputs)
- **STATUS** (0xFD8): Status register (Z flag for comparisons)

### Memory Locations:
- **0x08**: `waveValue` variable
- **0x09**: `direction` variable
- **0x20**: Delay counter high byte
- **0x21**: Delay counter low byte
- **0x22**: Delay repeat counter

## Tips for Effective Debugging

1. **Set breakpoints at key points**: 
   - At `loop:` to see each iteration
   - At `change_dir_inc` and `change_dir_dec` to catch direction changes

2. **Watch PORTJ in Logic Analyzer**:
   - Add all 8 bits of PORTJ
   - Run for a few cycles
   - You should see a triangle wave pattern

3. **Monitor PORTD**:
   - Use I/O View to change PORTD value
   - This controls your delay loop (0x22 variable)

4. **Use Step Over for delays**:
   - The `bigdelay` function has many iterations
   - Step over it (`F8`) rather than stepping through it

5. **Check program flow**:
   - Use the Trace window to verify the program is executing correctly
   - Ensure it's looping between increment and decrement

## Troubleshooting

- **Simulator won't start**: Check that Simulator is selected in the tool dropdown
- **No data visible**: Make sure the simulator is running (click Debug or Run)
- **Variables not showing**: Ensure the program is paused at a breakpoint or stopped
- **Build errors**: Check that all source files are included in the project

## Additional Resources

- MPLAB X IDE Help: `Help` → `Help Contents`
- PIC18F87K22 Data Sheet: For register descriptions
- MPLAB X Simulator User's Guide: Available in MPLAB X documentation





