function [] = plot_handler(health, fault, title_string)
    f = figure;
    f.Position(3:4) = [1000 500];
    hold on
    plot(health(1).data_measured{1,1}.Time, ...
        health(1).data_measured{1,1}.Data, 'k', 'LineWidth', 2, 'DisplayName', 'reference')
    plot(health(1).data_simulated{1,1}.Time, ...
        health(1).data_simulated{1,1}.Data, 'k--', 'LineWidth', 2, 'DisplayName', 'reference sim')

    plot(fault(1).data_measured{1,1}.Time, ...
        fault(1).data_measured{1,1}.Data, 'r', 'LineWidth', 2, 'DisplayName', 'fault1 measured')
    plot(fault(1).data_simulated{1,1}.Time, ...
        fault(1).data_simulated{1,1}.Data, 'r--', 'LineWidth', 2, 'DisplayName', 'fault1 simulation')

    plot(fault(2).data_measured{1,1}.Time, ...
        fault(2).data_measured{1,1}.Data, 'b', 'LineWidth', 2, 'DisplayName', 'fault2 measured')
    plot(fault(2).data_simulated{1,1}.Time, ...
        fault(2).data_simulated{1,1}.Data, 'b--', 'LineWidth', 2, 'DisplayName', 'fault2 simulation')

    hold off

    title(title_string)
    xlabel("Time (s)")
    ylabel("Displacement (m)")
    legend

end
