========================================================================
EXPERIMENT 1: PID CONTROL - PENDULUM DOWN POSITION
========================================================================
Date: [24-12-2025]
Author: [AIDIN LATIFI]
Files Required: 
  - EX1_PID_pendulum_down.slx
  - EX1_init.m

------------------------------------------------------------------------
1. SOFTWARE CONFIGURATION & INITIALIZATION
------------------------------------------------------------------------
1. Open the Simulink file: "EX1_PID_pendulum_down.slx".
2. Ensure the "HARDWARE" tab is visible in the Simulink toolbar.
   * Troubleshooting: If the Hardware tab is missing, copy and paste the 
     entire block diagram into the "quick_start_linear_pendulum.slx" Simulink file located 
     in the QuickStart folder on Desktop.
3. Verify Settings:
   - Go to Modeling > Model Settings (Properties).
   - Ensure "Automatically handle rate transition for data transfer" is checked.
4. Run the initialization script:
   - Open and run "EX1_init.m" in MATLAB to load required parameters.

------------------------------------------------------------------------
2. HARDWARE BUILD & CALIBRATION
------------------------------------------------------------------------
1. Click "Build & Tune" in the Simulink Hardware tab.
2. Wait for the compilation to complete. The simulation is active when 
   the simulation time begins incrementing at the bottom of the window.
3. Power On: Turn on the hardware power supply.
   * Note: This introduces actual sensor noise required for calibration.
4. Automatic Calibration: 
   - The system will perform an auto-calibration on the theta sensor 
     for the duration defined by 'CALIBRATION_TIME'.
   - Wait until the calibration flag switches to '1'.

------------------------------------------------------------------------
3. EXECUTION
------------------------------------------------------------------------
1. Apply Offset: Double-click the manual switch labeled "theta_offset" 
   to apply the calculated calibration value to the sensor readings.
2. Activate Control: Double-click the manual switch for control input 
   to pass the signal to the hardware.
   * Result: The pendulum is now being actively controlled.

------------------------------------------------------------------------
4. SHUTDOWN PROCEDURE (CRITICAL SAFETY)
------------------------------------------------------------------------
1. Turn OFF the hardware power supply FIRST.
   * Warning: Do this before stopping the simulation to prevent the 
     cart from hitting the rail ends (safety limits are inactive 
     during software stop).
2. Stop the Simulink simulation.
========================================================================