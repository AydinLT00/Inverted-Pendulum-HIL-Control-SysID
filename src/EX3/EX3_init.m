% =========================================================================
% GROUP 3 - MECHATRONICS LAB 2025/26
% EXPERIMENT 3: PENDULUM SWINGUP 
% AUTHOR: LATIFI
% DATE: [24-12-2025]
% DESCRIPTION: Initialization script for EX3_SwingUp.slx
% =========================================================================
clear
clc
close all

fprintf('%s\n', repmat('=', 1, 60));
fprintf(' EX3: PARAMETER INITIALIZATION START\n');
fprintf('%s\n', repmat('=', 1, 60));

CPU_frequency = 90e6; %(Hz)
PWM_frequency = 15e3; %(Hz)
PWM_CounterPeriod = CPU_frequency/PWM_frequency/2; %(PWM timer counts)
fsw = PWM_frequency;
Ts = 1e-4;
fw = 400; % encoder sampling frequency
Tw = 1/fw; % encoder sampling time
Distance = 0.653; %[m]
Encoder_Counts = 5238; % number of encoder counts for Distance 65.3cm
K_e = Distance / Encoder_Counts;  % = 1.246e-4 meters/count
CALIBRATION_TIME = 50; % in sec

fprintf('[DONE]\n');
fprintf('%s\n', repmat('-', 1, 60));
fprintf('INITIALIZATION COMPLETE.\n');
fprintf('%s\n', repmat('-', 1, 60));
fprintf('NEXT STEPS:\n');
fprintf('1. Open Simulink file: EX1_PID_pendulum_down.slx\n');
fprintf('2. Ensure HARDWARE tab is present.\n');
fprintf('3. Click "Build & Tune".\n');
fprintf('4. Wait for time to appear at bottom, THEN turn on Power Supply.\n');
fprintf('5. Please Refer to README.TXT for more detail.\n');
fprintf('%s\n', repmat('=', 1, 60));