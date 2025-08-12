%% Initialize Kalman Filter parameters

% We assume the covariance of the state is introduced by variance on the
% input

% Compute volume and mass of the rod (modeled as a cylinder)
V_rod = pi * (d/2)^2 * l;      % Rod volume (m^3)
m_rod = rho * V_rod;           % Rod mass (kg)

% Compute volume and mass of the sphere
V_sphere = (4/3) * pi * r^3;   % Sphere volume (m^3)
m_sphere = rho * V_sphere;     % Sphere mass (kg)

% Total mass of the pendulum
m = m_rod + m_sphere;

% Input matrix B of the linearized system (for state-space model)
BK = [0; nlobj.Ts/(m * l^2)];

tau_cov = 50;                   % Standard deviation of input torque noise
theta_cov = 1*pi/180;          % Standard deviation of angle noise (radians)

% Process noise covariance matrix QK (for Kalman filter)
QK = BK * tau_cov^2 * BK';

% Initial state covariance matrix P0 (assumed zero for initialization)
P0 = zeros(2,2);