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
BK = [0 0; nlobj.Ts/(m * l^2) 0; 0 1];

tau_cov = 5;                   % Standard deviation of input torque noise
theta_cov = 1*pi/180;          % Standard deviation of angle noise (radians)
tau_dist_dot_cov = 2;          % Standard deviation of torque disturbance derivative (Nm/s)

% Process noise covariance matrix QK (for Kalman filter)
QK = BK * diag([tau_cov, tau_dist_dot_cov]) * diag([tau_cov, tau_dist_dot_cov])' * BK';

% Initial state covariance matrix P0 (assumed zero for initialization)
P0 = zeros(3,3);