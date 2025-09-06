function xk1 = stateFcnPendulumKalmanAug(xk, input)
% stateFcnPendulumKalman: Discrete-time state update for the pendulum system using Euler integration.
%
% Inputs:
%   xk     - Current state vector [theta (rad); dtheta (rad/s); torque
%   disturbance (Nm)]
%   input  - Vector containing:
%              input(1:2): u    - Input torque (Nm), Torque Disturbance
%              Derivative (Nm/s)
%              input(3): Ts   - Sample time (s)
%              input(4:8): params - Physical parameters [k, l, d, r, rho]
%
% Output:
%   xk1    - Next state vector [theta (rad); dtheta (rad/s)]

u = input(1:2);
Ts = input(3);
params = input(4:8);

dxdt = stateFcnPendulumAug(xk, u, params);
xk1 = xk + dxdt*Ts;

end

