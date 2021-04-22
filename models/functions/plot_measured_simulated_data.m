function [] = plot_measured_simulated_data(measured, simulated)
    figure
    subplot(3,2,1)
    hold on
    plot(measured{1,1}.Time, measured{1,1}.Data)
    plot(simulated{1,1}.Time, simulated{1,1}.Data)
    hold off
    title("Position")
    xlabel("Time (s)")
    ylabel("Position (m)")
    legend("Measured", "Simulated")
    
    subplot(3,2,2)
    hold on
    plot(measured{1,2}.Time, measured{1,2}.Data)
    plot(simulated{1,2}.Time, simulated{1,2}.Data)
    hold off
    title("Velocity")
    xlabel("Time (s)")
    ylabel("Velocity (m/s)")
    legend("Measured", "Simulated")
    
    subplot(3,2,3)
    hold on
    plot(measured{1,3}.Time, measured{1,3}.Data)
    plot(simulated{1,3}.Time, simulated{1,3}.Data)
    hold off
    title("Flow Extrusion")
    xlabel("Time (s)")
    ylabel("Flow (l/min)")
    legend("Measured", "Simulated")
    
    subplot(3,2,4)
    hold on
    plot(measured{1,4}.Time, measured{1,4}.Data)
    plot(simulated{1,4}.Time, simulated{1,4}.Data)
    hold off
    title("Flow Contraction")
    xlabel("Time (s)")
    ylabel("Flow (l/min)")
    legend("Measured", "Simulated")
  
    subplot(3,2,5)
    hold on
    plot(measured{1,5}.Time, measured{1,5}.Data)
    plot(simulated{1,5}.Time, simulated{1,5}.Data)
    hold off
    title("Proximiti sensor bottom")
    xlabel("Time (s)")
    ylabel("Value (-)")
    legend("Measured", "Simulated")
    
    subplot(3,2,6)
    hold on
    plot(measured{1,6}.Time, measured{1,6}.Data)
    plot(simulated{1,6}.Time, simulated{1,6}.Data)
    hold off
    title("Proximiti sensor upper")
    xlabel("Time (s)")
    ylabel("Value (-)")
    legend("Measured", "Simulated")

end