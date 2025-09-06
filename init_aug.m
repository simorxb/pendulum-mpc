%% Initialize physical parameters

% Joint damping coefficient (N*m*s/rad)
k = 0.8;

% Rod length (m)
l = 1;

% Rod diameter (m)
d = 0.01;

% Ball radius (m)
r = 0.06;

% Rod and ball density (kg/m^3), assuming steel
rho = 7750;

%% Nonlinear Model Predictive Controller (NMPC) Configuration

% Number of states ([theta; theta_dot; tau_dist])
nx = 3;
% Number of outputs (theta)
ny = 1;

% Create nonlinear MPC controller object
nlobj = nlmpc(nx, ny, 'MV', 1, 'UD', 2);

% Number of model parameters (for custom state function)
nlobj.Model.NumberOfParameters = 1;
params = [k, l, d, r, rho];
createParameterBus(nlobj,'Model_Kalman/Nonlinear MPC Controller','paramsBusObject',{params});

% Controller sample time (s)
nlobj.Ts = 0.1;

% Prediction and control horizons
nlobj.PredictionHorizon = 15; % Predict 15 steps ahead
nlobj.ControlHorizon = 5;     % Optimize control moves over 5 steps

% Assign state and output functions
nlobj.Model.StateFcn = "stateFcnPendulumAug";
nlobj.Model.OutputFcn = "outputFcnPendulum";

% Input (torque) constraints
nlobj.ManipulatedVariables.Max = 100;
nlobj.ManipulatedVariables.Min = -100;

% Weights for cost function
nlobj.Weights.OutputVariables = 1;
nlobj.Weights.ManipulatedVariables = 0;
nlobj.Weights.ManipulatedVariablesRate = 0.03;

% Initial conditions for validation
x0 = [0; 0; 0];   % Initial state: [angle; angular velocity]
u0 = [3];        % Initial input: torque (N*m)
validateFcns(nlobj, x0, u0, [], {params});