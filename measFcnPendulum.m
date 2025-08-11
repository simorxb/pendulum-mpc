function y = measFcnPendulum(x)
% measFcnPendulum Output function for the pendulum system.
%   y = measFcnPendulum(x) returns the measured output y for the
%   given state vector x.
%
%   Input:
%       x - State vector:
%           x(1): theta (pendulum angle in radians)
%           x(2): dtheta (angular velocity in radians/sec)
%
%   Output:
%       y - Measured output (pendulum angle theta in radians)

y = x(1);

end

