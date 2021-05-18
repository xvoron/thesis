function [] = data_plot(member)

% Analog quantities
flow_ext = member.FlowExtrusion{1};
flow_cont = member.FlowContraction{1};
pressure = member.AirPressure{1};
acc_Z = member.AccelerometerMoving_axisZ{1};
acc_Y = member.AccelerometerMoving_axisY{1};
strain = member.StrainGauge{1};

% Microphone
mic_ubump = member.MIC_uBumper{1};
mic_bbump =member.MIC_bBumper{1};
mic_ambient =member.MIC_Ambient{1};

% % Temperature
% temp_cylinder = member.Temp_Cylinder{1};
% temp_ambient = member.Temp_Ambient{1};

% Digital signals
prox_bottom = member.ProximitySensor_bottom{1};
prox_upper = member.ProximitySensor_upper{1};
possition = member.LeverPosition{1};

out_valve_HP = member.outValveHP{1};
out_valve_WP = member.outValveWP{1};

%% Figures

f = figure;
f.Position = [10 10 1000 500];

subplot(3,1,1)
hold on
plot(flow_ext.Time, flow_ext.Data, 'LineWidth' , 3)
plot(flow_cont.Time, flow_cont.Data, 'LineWidth', 3)
xlabel('time [s]')
ylabel('flow [l/min]')
title('Air flow extrusion/contraction')
legend("extrusion", "contraction")
grid on
hold off


subplot(3,1,2)
plot(pressure.Time, pressure.Data, 'LineWidth', 2)
xlabel('time [s]')
ylabel('pressure [bar]')
title('Air pressure')
grid on

subplot(3,1,3)
plot(strain.Time, strain.Data, 'LineWidth', 2)
xlabel('time [s]')
ylabel('stain [Pa]')
title('Strain Gauge')
grid on

f = figure;
f.Position = [10 10 1000 400];


subplot(2,1,1)
plot(acc_Z.Time, acc_Z.Data, 'LineWidth', 2)
xlabel('time [s]')
ylabel('Acc_Z [ g]')
title(' Acceleration elevator Z-axis')
grid on

subplot(2,1,2)
plot(acc_Y.Time, acc_Y.Data, 'LineWidth', 2)
xlabel('time [s]')
ylabel('Acc_Y [ g]')
title('Acceleration static Y-axis')
grid on




f = figure;
f.Position = [10 10 1000 500];

subplot(3,1,1)
plot(mic_ubump.Time,  mic_ubump.Data, 'LineWidth', 2)
xlabel('time [s]')
ylabel('U [ V]')
title(' Microphone upper bumper')
grid on

subplot(3,1,2)
plot(mic_bbump.Time, mic_bbump.Data, 'LineWidth', 2)
xlabel('time [s]')
ylabel('U [ V]')
title(' Microphone bottom bumper')
grid on

subplot(3,1,3)
plot(mic_ambient.Time, mic_ambient.Data, 'LineWidth', 2)
xlabel('time [s]')
ylabel('U [ V]')
title(' Microphone ambient noise')
grid on


f = figure;
f.Position = [10 10 1000 400];

subplot(2,1,1)
plot(out_valve_WP.Time, out_valve_WP.Data,'r-', 'LineWidth', 2)
hold on
plot(out_valve_HP.Time, out_valve_HP.Data,'b--', 'LineWidth', 2)
xlabel('time [s]')
ylabel('-')
title('Valve input')
grid on
legend('Go up' , 'Go down')

subplot(2,1,2)
hold on
plot(prox_bottom.Time, 0.2*prox_bottom.Data,'b--', 'LineWidth', 2)
plot(prox_upper.Time, 0.2*prox_upper.Data,'r--', 'LineWidth', 2)
plot(possition.Time, possition.Data, 'k', 'LineWidth', 3)
xlabel('time [s]')
ylabel('displacement [m]')
title('Lever position: encoder, proximity sensors (scaled)')
legend('proximity bottom' , 'proximity top', 'displacement')
grid on
hold off

end
