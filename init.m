%% Init params

% Joint damping coefficient
k = 0.8;

% Rod length
l = 1;

% Rod diameter
d = 0.01;

% Ball radius
r = 0.06;

% Rod and ball density (kg/m^3) - Steel
rho = 7750;

%% Nonlinear Model Predictive Controller Configuration

% State dimension
nx = 2;
% Output dimension (theta)
ny = 1;
% Input dimension (torque command)
nu = 1;

% Create nonlinear MPC controller object
nlobj = nlmpc(nx,ny,nu);

nlobj.Model.NumberOfParameters = 1;
params = [k, l, d, r, rho];

% Controller sample time (seconds)
nlobj.Ts = 0.1;

% Controller horizons
nlobj.PredictionHorizon = 15; % Look ahead 10 steps
nlobj.ControlHorizon = 5;    % Optimize control for 2 steps

% Set model
nlobj.Model.StateFcn = "stateFcnPendulum";
nlobj.Model.OutputFcn = "outputFcnPendulum";

% Input constraints based on physical limits
nlobj.ManipulatedVariables.Max = 100;
nlobj.ManipulatedVariables.Min = -100;

% Cost function weights
nlobj.Weights.OutputVariables = 1;
nlobj.Weights.ManipulatedVariables = 0;
nlobj.Weights.ManipulatedVariablesRate = 0.05;

% Initial conditions for model validation
x0 = [0; 0];
u0 = 3;   % Initial force (N)
validateFcns(nlobj, x0, u0, [], {params});