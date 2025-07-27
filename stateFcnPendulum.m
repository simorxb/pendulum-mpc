function dxdt = stateFcnPendulum(x, u, params)
% State function for pendulum dynamics model
% Inputs:
%   x: State vector = [theta(rad); dtheta(rad/s)]
%   u: Torque input command (Nm)
%   params: k, l, d, r, rho
% Output:
%   dxdt: Derivative (respect to time) of the state vector

theta = x(1);
dtheta = x(2);
tau = u;

k = params(1);
l = params(2);
d = params(3);
r = params(4);
rho = params(5);
g = 9.81;

% Calculate mass of the rod
V_rod = pi * (d/2)^2 * l;      % Volume of the rod (cylinder)
m_rod = rho * V_rod;           % Mass of the rod

% Calculate mass of the sphere
V_sphere = (4/3) * pi * r^3;   % Volume of the sphere
m_sphere = rho * V_sphere;     % Mass of the sphere

% Total mass
m = m_rod + m_sphere;

% Calculate the change in angular acceleration
ddtheta = (tau - k * dtheta - m * g * l * sin(theta)) / (m * l * l);

% Update the state derivative
dxdt = [dtheta; ddtheta];

end

