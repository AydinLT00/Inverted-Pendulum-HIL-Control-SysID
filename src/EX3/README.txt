========================================================================
EXPERIMENT 2: SWING UP CONTROL STRATEGY
========================================================================
Date: [24-12-2025]
Author: [AIDIN LATIFI]
Files Required: 
  - EX2_Pend_up_Controller_Observer.slx (Swing Up Configuration)
  - EX2_init.m

----------------------------------------------------------------------
=> CRITICAL SAFETY ALERT
----------------------------------------------------------------------
** WARNING: NO STABILIZING CONTROLLER **
There is no active LQR/Stabilizing controller configured after the
swing-up phase completes.
- The user must manually turn off the power once the complete swing-up is observed.
- DO NOT LEAVE THE SYSTEM UNATTENDED DURING THIS PHASE.


------------------------------------------------------------------------
1. CONFIGURATION & INITIALIZATION
------------------------------------------------------------------------
1. Open "EX2_Pend_up_Controller_Observer.slx".
2. Check for the "HARDWARE" tab. If missing, move blocks to the "quick_start_linear_pendulum.slx"
   file as per standard troubleshooting.
3. Ensure "Automatically handle rate transition" is checked in Model Settings.
4. Run "EX2_init.m" to initialize parameters.

------------------------------------------------------------------------
2. EXECUTION & TESTING
------------------------------------------------------------------------
1. Click "Build & Tune".
2. Once compiled and running, turn ON the power supply.
3. Wait for the calibration sequence to complete (Flag = 1).
4. Double-click the "theta_offset" manual switch to apply sensor calibration.
5. Starting the Swing:
   - It is suggested to give the pendulum a slight manual "initial kick".
   - While the pendulum is swinging, double-click the manual switch 
     to activate the control input.
   - The cart will move back and forth to swing the pendulum up.

------------------------------------------------------------------------
3. CRITICAL SAFETY ALERT
------------------------------------------------------------------------
** WARNING: NO STABILIZING CONTROLLER **
There is no active LQR/Stabilizing controller configured after the 
swing-up phase completes. 
- The user must manually turn off the power once the complete swing-up is observed.
- DO NOT LEAVE THE SYSTEM UNATTENDED DURING THIS PHASE.

------------------------------------------------------------------------
4. SHUTDOWN PROCEDURE
------------------------------------------------------------------------
1. Turn OFF the hardware power supply FIRST.
   * This is critical as safety limits are inactive.
2. Stop the Simulink simulation.
========================================================================