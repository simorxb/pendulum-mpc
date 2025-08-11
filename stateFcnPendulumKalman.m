function xk1 = stateFcnPendulumKalman(xk, input)
% stateFcnPendulumKalman: Discrete-time state update for the pendulum system using Euler integration.
%
% Inputs:
%   xk     - Current state vector [theta (rad); dtheta (rad/s)]
%   input  - Vector containing:
%              input(1): u    - Input torque (Nm)
%              input(2): Ts   - Sample time (s)
%              input(3:7): params - Physical parameters [k, l, d, r, rho]
%
% Output:
%   xk1    - Next state vector [theta (rad); dtheta (rad/s)]

u = input(1);
Ts = input(2);
params = input(3:7);

dxdt = stateFcnPendulum(xk, u, params);
xk1 = xk + dxdt*Ts;

end

