model = "Model_Kalman_Augmented";

% Create a SimulationInput object
simIn = Simulink.SimulationInput(model);

% Run the simulation
simIn = simIn.setVariable('tau_dist', 0);
simIn = simIn.setVariable('ref_mode', 1);
simIn = simIn.setVariable('noise', 0);
simIn = simIn.setModelParameter('StopTime', '40');
out = sim(simIn);

% Retrieve variables
ref_log   = out.logsout.get('ref').Values;
tau_log   = out.logsout.get('tau').Values;
theta_log = out.logsout.get('theta').Values;
dtheta_log = out.logsout.get('dtheta').Values;
xhat_log = out.logsout.get('xhat').Values;

%% Plot results
figure('Color', 'k');
ax1 = subplot(3,1,1);
hold on;
plot(theta_log.Time, theta_log.Data*180/pi, 'LineWidth', 2, 'DisplayName', "Measured", "Color", "g");
stairs(xhat_log.Time, xhat_log.Data(:,1)*180/pi, 'LineWidth', 2, 'DisplayName', 'Kalman Filter', "Color", "m");
stairs(ref_log.Time, ref_log.Data*180/pi, '--', 'LineWidth', 2, 'DisplayName', 'Reference', "Color", "r");
legend('TextColor', 'w', 'Color', 'k', 'EdgeColor', ...
    [0.5 0.5 0.5], 'LineWidth', 1, 'FontSize', 10);
hold off;
grid on;
legend('Location', 'best');
ylabel('Angle (deg)');
title('Angular Position');
ax1.Color = 'k';
ax1.GridColor = 'w';
ax1.GridAlpha = 0.3;
ax1.XColor = 'w';
ax1.YColor = 'w';

ax2 = subplot(3,1,2);
hold on;
plot(dtheta_log.Time, dtheta_log.Data*180/pi, 'LineWidth', 2, 'DisplayName', "Measured", "Color", "g");
stairs(xhat_log.Time, xhat_log.Data(:,2)*180/pi, 'LineWidth', 2, 'DisplayName', 'Kalman Filter', "Color", "m");
legend('TextColor', 'w', 'Color', 'k', 'EdgeColor', ...
    [0.5 0.5 0.5], 'LineWidth', 1, 'FontSize', 10);
hold off;
grid on;
ylabel('Angular Speed (deg/s)');
title('Angular Speed');
ax2.Color = 'k';
ax2.GridColor = 'w';
ax2.GridAlpha = 0.3;
ax2.XColor = 'w';
ax2.YColor = 'w';

ax3 = subplot(3,1,3);
hold on;
stairs(tau_log.Time, tau_log.Data, 'LineWidth', 2, 'DisplayName', "Torque", "Color", "g");
stairs(xhat_log.Time, xhat_log.Data(:,3), 'LineWidth', 2, 'DisplayName', 'Torque Disturbance (Kalman Filter)', "Color", "m");
legend('TextColor', 'w', 'Color', 'k', 'EdgeColor', ...
    [0.5 0.5 0.5], 'LineWidth', 1, 'FontSize', 10);
hold off;
grid on;
ylabel('Torque (N*m)');
xlabel('Time (s)');
title('Input Torque');
ax3.Color = 'k';
ax3.GridColor = 'w';
ax3.GridAlpha = 0.3;
ax3.XColor = 'w';
ax3.YColor = 'w';

