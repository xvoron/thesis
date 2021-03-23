function [] = data_plot_preprocess_compaire(member, member_preprocessed)

% Analog quantities
flow_ext = member.FlowExtrusion{1};
pressure = member.AirPressure{1};
acc_Z = member.Accelerometer_axisZ{1};
acc_Y = member.Accelerometer_axisY{1};
strain = member.StrainGauge{1};

% Microphone
mic_ambient =member.MIC_Ambient{1};

flow_ext_p = member_preprocessed.FlowExtrusion{1};
pressure_p = member_preprocessed.AirPressure{1};
acc_Z_p = member_preprocessed.Accelerometer_axisZ{1};
acc_Y_p = member_preprocessed.Accelerometer_axisY{1};
strain_p = member_preprocessed.StrainGauge{1};

% Microphone
mic_ambient_p =member.MIC_Ambient{1};

% Analog quantities
figure

subplot(3,2,1)
hold on
plot(flow_ext.Time, flow_ext.Data)
plot(flow_ext_p.Time, flow_ext_p.Data)
xlabel('t [s]')
ylabel('Q [ l/min]')
title(' Air flow extrusion')
legend('Raw', 'Filtered')
grid on
hold off

subplot(3,2,2)
hold on
plot(acc_Z.Time, acc_Z.Data)
plot(acc_Z_p.Time, acc_Z_p.Data)
xlabel('t [s]')
ylabel('a_Z [ g]')
title(' Acceleration elevator Z-axis')
legend('Raw', 'Filtered')
grid on
hold off

subplot(3,2,3)
hold on
plot(acc_Y.Time, acc_Y.Data)
plot(acc_Y_p.Time, acc_Y_p.Data)
xlabel('t [s]')
ylabel('a_Y [ g]')
title(' Acceleration elevator Y-axis')
legend('Raw', 'Filtered')
grid on
hold off

subplot(3,2,4)
hold on
plot(pressure.Time, pressure.Data)
plot(pressure_p.Time, pressure_p.Data)
xlabel('t [s]')
ylabel('p [ bar]')
title(' Air pressure')
legend('Raw', 'Filtered')
grid on
hold off

subplot(3,2,5)
hold on
plot(strain.Time, strain.Data)
plot(strain_p.Time, strain_p.Data)
xlabel('t [s]')
ylabel('p [ Pa]')
title(' Strain')
legend('Raw', 'Filtered')
grid on
hold off

subplot(3,2,6)
hold on
plot(mic_ambient.Time, mic_ambient.Data)
plot(mic_ambient_p.Time, mic_ambient_p.Data)
xlabel('t [s]')
ylabel('U [ V]')
title(' Microphone ambient noise')
legend('Raw', 'Filtered')
grid on
hold off

end
