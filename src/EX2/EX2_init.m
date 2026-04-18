% =========================================================================
% GROUP 3 - MECHATRONICS LAB 2025/26
% EXPERIMENT 2: PENDULUM UP CONTROLLER OBSERVER 
% AUTHOR: LATIFI
% DATE: [24-12-2025]
% DESCRIPTION: Initialization script for EX2_Pend_up_Controller_Observer.slx
% =========================================================================

clear;
clc;
close all;

fprintf('%s\n', repmat('=', 1, 60));
fprintf(' EX2: PARAMETER INITIALIZATION START\n');
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

% ------------------>>>>>> CHANGE THE TYPES BELOW: <<<<<<------------------
CONTROLLER_TYPE = 'LQR'; % OPTIONS: 'PolePlacement', 'LQR', 'SMC'
OBSERVER_TYPE = 'Kalman'; % OPTIONS: 'Luenberger', 'Kalman'

% 2. Physical System and Linearized Model
params.m = 0.1528;      % Mass of the pendulum (kg)
params.M = 0.6;         % Mass of the cart (kg)
params.L = 0.42;        % Length to pendulum center of mass (m)
params.g = 9.81;        % Gravity (m/s^2)
params.I = (1/12) * params.m * params.L^2; % Pendulum moment of inertia
params.Kf_pos = 18.6;   % Motor gain
params.Kf_neg = 19.3;   % Motor gain
params.deadzone = 0.1;  % Motor deadzone
params.Fc = 1.1;        % Coulomb friction
params.b_dynamic = 27;  % Viscous friction coefficient for the cart
params.bp_dynamic = 0.001; % Viscous friction for the pendulum pivot
params.tanh_k = 1000;

% --- Linearized State-Space Model (around theta = 0, upward position) ---
M = params.M; m = params.m; L = params.L; g = params.g;
I_pivot = params.I + m*(L/2)^2;
b = params.b_dynamic;

den = I_pivot*(M+m) - (m*L/2)^2;

A = [0, 1, 0, 0;
     0, -I_pivot*b/den, -(m^2*g*(L/2)^2)/den, 0;
     0, 0, 0, 1;
     0, m*b*L/(2*den), (m*g*L/2)*(M+m)/den, 0];
     
B = [0;
     (I_pivot)/den;
     0;
     -(m*L/2)/den];
     
Kf_avg = (params.Kf_pos + params.Kf_neg)/2;
B = Kf_avg * B;

C = [1, 0, 0, 0;
     0, 0, 1, 0];
     
D = [0; 0];

% 3. State-Feedback Controller Design
fprintf('--- Designing Controller using: %s ---\n', CONTROLLER_TYPE);
K = zeros(1, 4);
c_gains = zeros(1, 4);
K_sw = 0;
poles_controller = [];
SMC_switch = 0;
sys_params = [params.M, params.m, params.L, params.I, params.b_dynamic, params.bp_dynamic, params.g, K_sw];


switch CONTROLLER_TYPE
    case 'PolePlacement'
        P_K = [-1.0, -2.0, -20.0, -45.0];
        K = place(A, B, P_K);
        poles_controller = eig(A - B*K);
        fprintf('Pole Placement successful.\n');

    case 'LQR'
        Q = diag([1/0.1^2, 1/1^2, 1/0.15^2, 1/1^2]);
        R = 1/0.5^2;
        [K, S, poles_lqr] = lqr(A, B, Q, R);
        poles_controller = poles_lqr;
        fprintf('LQR design successful.\n');

    case 'SMC'
        SMC_switch = 1;        
        K_sw = 200;
        Q_ref = diag([1/0.1^2, 1/1^2, 1/0.15^2, 1/1^2]);
        R_ref = 1/0.1^2;
        [K, ~, poles_ref] = lqr(A, B, Q_ref, R_ref);
        c_gains = K;
        poles_controller = poles_ref;
        fprintf('Note: LQR poles are calculated as a speed reference for observer design.\n');
        
    otherwise
        error('Invalid CONTROLLER_TYPE specified.');
end

disp('Controller gains K:'); disp(K);


% 4. State Observer Design
fprintf('--- Designing Observer using: %s ---\n', OBSERVER_TYPE);

switch OBSERVER_TYPE
    case 'Luenberger'
        OBSERVER_SPEED_FACTOR = 5;
        P_L = OBSERVER_SPEED_FACTOR * poles_controller;
        Lc = place(A', C', P_L)';
        poles_observer = eig(A - Lc*C);
        fprintf('Luenberger observer design successful.\n');
        
    case 'Kalman'
        Qn = eye(4) * 1.5;
        Rn = diag([1e-9, 6e-4]); % [pos_sensor_var, angle_sensor_var]
        G = eye(4); H = zeros(2,4);
        sys_for_kalman = ss(A, [B G], C, [D H]);
        [~, Lc, ~] = kalman(sys_for_kalman, Qn, Rn);
        poles_observer = eig(A - Lc*C);
        fprintf('Kalman filter design successful.\n');
        disp('Qn = ');disp(Qn)
        disp('Rn = ');disp(Rn)

    otherwise
        error('Invalid OBSERVER_TYPE specified.');
end

disp('Calculated observer gain Lc:'); disp(Lc);
fprintf('\n');

A_obs = A - Lc*C;
sys_obs_cont = ss(A_obs, [B Lc], eye(size(A)), 0);
sys_obs_disc = c2d(sys_obs_cont, Ts, 'tustin');
Ad = sys_obs_disc.A;
Bd = sys_obs_disc.B;
Cd = sys_obs_disc.C;
Dd = sys_obs_disc.D;

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