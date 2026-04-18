========================================================================
EXPERIMENT 2: CONTROLLER & OBSERVER - PENDULUM UPRIGHT
========================================================================
Date: [24-12-2025]
Author: [AIDIN LATIFI]
Files Required: 
  - EX2_Pend_up_Controller_Observer.slx
  - EX2_init.m

------------------------------------------------------------------------
1. SOFTWARE CONFIGURATION
------------------------------------------------------------------------
1. Open the Simulink file: "EX2_Pend_up_Controller_Observer.slx".
2. Ensure the "HARDWARE" tab is visible in the Simulink toolbar.
   * Troubleshooting: If missing, copy blocks to the "quick_start_linear_pendulum.slx" file 
     in the QuickStart folder.
3. Go to Model Settings and ensure "Automatically handle rate transition" 
   is checked.

------------------------------------------------------------------------
2. CONTROLLER SELECTION & INITIALIZATION
------------------------------------------------------------------------
1. Select Strategy: In the "EX2_init.m" file, select the desired:
   - OBSERVER_TYPE
   - CONTROLLER_TYPE
2. Run "EX2_init.m" to load parameters and apply the selection.
   * Note: If you wish to test a different controller/observer later, 
     change these variables and re-run the init file before building.

------------------------------------------------------------------------
3. EXECUTION STEPS
------------------------------------------------------------------------
1. Click "Build & Tune" in the Simulink Hardware tab.
2. Wait for compilation to finish (simulation time running).
3. Power On: Turn on hardware power to enable sensor noise.
4. Calibration: Wait for the automatic calibration sequence to finish 
   (Flag = 1).
5. Apply Offset: Double-click the "theta_offset" manual switch.
6. Positioning: Manually move the pendulum to the upright (vertical) position.
7. Activate Control: While maintaining the pendulum upright, double-click 
   the manual switch to pass control input to the hardware.
   * Result: The LQR controller will maintain the upright position.

------------------------------------------------------------------------
4. SHUTDOWN PROCEDURE
------------------------------------------------------------------------
1. Turn OFF the hardware power supply FIRST.
   * Warning: Essential to prevent cart collision with rail limits.
2. Stop the Simulink simulation.
========================================================================