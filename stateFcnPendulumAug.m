function dxdt = stateFcnPendulumAug(x, u, params)
% stateFcnPendulum: Computes the time derivative of the pendulum state.
% 
% Inputs:
%   x      - State vector [theta (rad); dtheta (rad/s); torque disturbance
%   (Nm)]
%   u      - [Input torque (Nm), Torque Disturbance Derivative (Nm/s)]
%   params - Vector of physical parameters [k, l, d, r, rho]
%
% Output:
%   dxdt   - Time derivative of the state vector [dtheta; ddtheta]

theta = x(1);      % Angular position (rad)
dtheta = x(2);     % Angular velocity (rad/s)
tau_dist = x(3);   % Torque Disturbance (Nm)

tau = u(1);        % Applied torque (Nm)

k = params(1);     % Damping coefficient
l = params(2);     % Length of the rod (m)
d = params(3);     % Diameter of the rod (m)
r = params(4);     % Radius of the sphere (m)
rho = params(5);   % Density (kg/m^3)
g = 9.81;          % Acceleration due to gravity (m/s^2)

% Compute volume and mass of the rod (modeled as a cylinder)
V_rod = pi * (d/2)^2 * l;      % Rod volume (m^3)
m_rod = rho * V_rod;           % Rod mass (kg)

% Compute volume and mass of the sphere
V_sphere = (4/3) * pi * r^3;   % Sphere volume (m^3)
m_sphere = rho * V_sphere;     % Sphere mass (kg)

% Total mass of the pendulum
m = m_rod + m_sphere;

% Compute angular acceleration (ddtheta)
ddtheta = (tau + tau_dist - k * dtheta - m * g * l * sin(theta)) / (m * l^2);

% Assemble state derivative vector
dxdt = [dtheta; ddtheta; u(2)];

end

