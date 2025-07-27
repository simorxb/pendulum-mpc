function y = outputFcnPendulum(x, ~, ~)
%OUTPUTFCNPENDULUM Output function for the pendulum system.
%   y = OUTPUTFCNPENDULUM(x, ~, ~) returns the output variable y for the
%   given state vector x.
%
%   Input:
%       x - State vector where:
%           x(1): theta (pendulum angle in radians)
%           x(2): dtheta (angular velocity in radians/sec)
%
%   Output:
%       y - Output variable (pendulum angle theta in radians)

y = x(1);

end

