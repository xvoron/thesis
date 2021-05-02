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

% Analog quantities
figure

subplot(3,2,1)
plot(flow_ext.Time, flow_ext.Data)
xlabel('t [s]')
ylabel('Q [ l/min]')
title(' Air flow extrusion')
grid on

subplot(3,2,2)
plot(flow_cont.Time, flow_cont.Data)
xlabel('t [s]')
ylabel('Q [ l/min]')
title(' Air flow contraction')
grid on

subplot(3,2,3)
plot(acc_Z.Time, acc_Z.Data)
xlabel('t [s]')
ylabel('a_Z [ g]')
title(' Acceleration elevator Z-axis')
grid on

subplot(3,2,4)
plot(acc_Y.Time, acc_Y.Data)
xlabel('t [s]')
ylabel('a_Y [ g]')
title(' Acceleration static Y-axis')
grid on

subplot(3,2,5)
plot(pressure.Time, pressure.Data)
xlabel('t [s]')
ylabel('p [ bar]')
title(' Air pressure')
grid on

subplot(3,2,6)
plot(strain.Time, strain.Data)
xlabel('t [s]')
ylabel('p [ Pa]')
title(' Strain')
grid on

% Microphone
figure

subplot(3,1,1)
plot(mic_ubump.Time,  mic_ubump.Data)
xlabel('t [s]')
ylabel('U [ V]')
title(' Microphone upper bumper')
grid on

subplot(3,1,2)
plot(mic_bbump.Time, mic_bbump.Data)
xlabel('t [s]')
ylabel('U [ V]')
title(' Microphone bottom bumper')
grid on

subplot(3,1,3)
plot(mic_ambient.Time, mic_ambient.Data)
xlabel('t [s]')
ylabel('U [ V]')
title(' Microphone ambient noise')
grid on

% Digital signals
figure
% //ps
subplot(3,1,1)
plot(out_valve_WP.Time, out_valve_WP.Data,'r-')
hold on
plot(out_valve_HP.Time, out_valve_HP.Data,'b--')
xlabel('t [s]')
ylabel('-')
title('Valve input')
grid on
legend('Go up' , 'Go down')
% \\ps

subplot(3,1,2)
plot(prox_bottom.Time, prox_bottom.Data,'b')
hold on
plot(prox_upper.Time, prox_upper.Data,'r')
xlabel('t [s]')
ylabel('-')
title(' Lever position')
grid on
legend('Bottom' , 'Top')

subplot(3,1,3)
plot(possition.Time, possition.Data)
xlabel('t [s]')
ylabel('d [m]')
title(' Lever position- encoder')
grid on

end
