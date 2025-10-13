model = "Model_Kalman_Augmented";

% Define the configurations
configs = {
    struct('name', 'Noise=0', 'noise', 0);
    struct('name', 'Noise=0.001', 'noise', 0.001);
    struct('name', 'Noise=0.003', 'noise', 0.003);
    struct('name', 'Noise=0.005', 'noise', 0.005);
};

% Initialize cell array to store results
results = cell(length(configs), 1);

% Loop over each configuration
for s = 1:length(configs)
    config = configs{s};

    % Create a SimulationInput object
    simIn = Simulink.SimulationInput(model);

    % Run the simulation
    simIn = simIn.setVariable('tau_dist', 0);
    simIn = simIn.setVariable('ref_mode', 0);
    simIn = simIn.setVariable('noise', config.noise);
    simIn = simIn.setModelParameter('StopTime', '40');
    out = sim(simIn);

    % Store results
    results{s} = struct(...
    'theta', out.logsout.get('theta').Values, ...
    'ref', out.logsout.get('ref').Values, ...
    'tau', out.logsout.get('tau').Values, ...
    'dtheta', out.logsout.get('dtheta').Values, ...
    'xhat', out.logsout.get('xhat').Values);

end

%% Plot results
figure('Color', 'k');
ax1 = subplot(3,1,1);
hold on;

for s = 1:length(configs)
    plot(results{s}.theta.Time, results{s}.theta.Data*180/pi, 'LineWidth', 2, 'DisplayName', configs{s}.name);
end

stairs(results{1}.ref.Time, results{1}.ref.Data*180/pi, '--', 'LineWidth', 2, 'DisplayName', 'Reference', "Color", "r");

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

for s = 1:length(configs)
    plot(results{s}.theta.Time, results{s}.theta.Data*180/pi, 'LineWidth', 2, 'DisplayName', configs{s}.name);
end

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

for s = 1:length(configs)
    plot(results{s}.tau.Time, results{s}.tau.Data, 'LineWidth', 2, 'DisplayName', configs{s}.name);
end

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

