% Comparison models with real data
%
clc;clear all;close all;
% Load data and parameters
run sb/import_dataensemble.m
run models/params.m

Ts = 0.001;

%% Chose fault code for simulation
fault_code = "1103204";
number_in_fault_code_set = 19;
reset(datastore);
i = 1;

while hasdata(datastore)
   member = read(datastore);
   if member.FaultCode{1,1} == fault_code
      if i == number_in_fault_code_set
            break;
        else
            i = i+1;
            continue
        end
   end
end


fault_code = member.FaultCode{1,1};
valve2 = member.ThrottleValve1{1,1}.Variables; % Reversed in models
valve1 = member.ThrottleValve2{1,1}.Variables;
SmallDamper_bottom = member.SmallDamper_bottom{1,1}.Variables;
SmallDamper_upper = member.SmallDamper_upper{1,1}.Variables;

LargeDamper_bottom = member.LargeDamper_bottom{1,1}.Variables;
LargeDamper_upper = member.LargeDamper_upper{1,1}.Variables;

M_L = member.("Settings.Load"){1,1}{1,1};
disp(fault_code)
fprintf("Parameters: \n valve1: %d, valve2: %d \n", valve1, valve2)
fprintf("damp_small_up: %d, damp_small_bot: %d \n", SmallDamper_upper, SmallDamper_bottom)
fprintf("damp_large_up: %d, damp_large_bot: %d \n", LargeDamper_upper, LargeDamper_bottom)
%temp_cylinder = member.Temp_Cylinder{1,1};
%temp_ambient  = member.Temp_Ambient{1,1};

% Signals

inp_u1 = member.outValveHP{1,1};
inp_u2 = member.outValveWP{1,1};
t = seconds(inp_u1.Time);
u1 = inp_u1.Data;
u2 = inp_u2.Data;

position = member.LeverPosition{1,1};

% Velocity calculating from position signal
velocity = position; % copy position
velocity.Data = [diff(position.Data)/Ts; 0];

acceleration = velocity; % copy velocity
acceleration.Data = [diff(velocity.Data)/Ts; 0];

mic_up = member.MIC_uBumper{1,1};
mic_bot = member.MIC_bBumper{1,1};
mic_amb = member.MIC_Ambient{1,1};
prox_bot = member.ProximitySensor_bottom{1,1};
prox_up = member.ProximitySensor_upper{1,1};
acc_mov_y = member.AccelerometerMoving_axisY{1,1};
acc_mov_z = member.AccelerometerMoving_axisZ{1,1};
acc_stat_y = member.AccelerometerStatic_axisY{1,1};
acc_stat_z = member.AccelerometerStatic_axisZ{1,1};
flow_ex = member.FlowExtrusion{1,1};
flow_con = member.FlowContraction{1,1};

pressure = member.AirPressure{1,1};

strain_gauge = member.StrainGauge{1,1};

%% Simulation Equation model
simOut = sim("models/model_equation_simply_valves.slx");

position_sim_eq = get(simOut.logsout, "LeverPosition").Values;
velocity_sim_eq = get(simOut.logsout, "LeverVelocity").Values;
prox_up_sim_eq  = get(simOut.logsout, "ProximitySensor_upper").Values;
prox_bot_sim_eq = get(simOut.logsout, "ProximitySensor_bottom").Values;
prox_up_sim_eq  = get(simOut.logsout, "ProximitySensor_upper").Values;
flow_ex_sim_eq  = get(simOut.logsout, "FlowExtrusion").Values;
flow_con_sim_eq = get(simOut.logsout, "FlowContraction").Values;

%% Simulation Equation model
% simOut = sim("models/model_simscape.slx");
% 
% position_sim_ss = get(simOut.logsout, "LeverPosition").Values;
% velocity_sim_ss = get(simOut.logsout, "LeverVelocity").Values;
% prox_up_sim_ss  = get(simOut.logsout, "ProximitySensor_upper").Values;
% prox_bot_sim_ss = get(simOut.logsout, "ProximitySensor_bottom").Values;
% prox_up_sim_ss  = get(simOut.logsout, "ProximitySensor_upper").Values;
% flow_ex_sim_ss  = get(simOut.logsout, "FlowExtrusion").Values;
% flow_con_sim_ss = get(simOut.logsout, "FlowContraction").Values;

%% Delite last sample
%position_sim_eq = delsample(position_sim_eq, 'Index', length(position_sim_eq));

figure
hold on
plot(position.Time, position.Data)
plot(position_sim_eq.Time, position_sim_eq.Data)
% plot(position_sim_ss.Time, position_sim_ss.Data)
legend("Measurement", "Equation Model", "Simscape Model")
title("Positon")
hold off

figure
hold on
plot(velocity.Time,     velocity.Data)
plot(velocity_sim_eq.Time, velocity_sim_eq.Data)
% plot(velocity_sim_ss.Time, velocity_sim_ss.Data)
legend("Measurement", "Equation Model", "Simscape Model")
title("Velocity")
hold off

figure
hold on
plot(prox_up.Time, prox_up.Data)
plot(prox_up_sim_eq.Time, prox_up_sim_eq.Data)
% plot(prox_up_sim_ss.Time, prox_up_sim_ss.Data)
legend("Measurement", "Equation Model", "Simscape Model")
title("Proximity sensor bottom")
hold off


figure
hold on
plot(prox_bot.Time, prox_bot.Data)
plot(prox_bot_sim_eq.Time, prox_bot_sim_eq.Data)
% plot(prox_bot_sim_ss.Time, prox_bot_sim_ss.Data)
legend("Measurement", "Equation Model", "Simscape Model")
title("Proximity sensor upper")
hold off


figure
hold on
plot(flow_ex.Time,     flow_ex.Data)
plot(flow_ex_sim_eq.Time, flow_ex_sim_eq.Data)
% plot(flow_ex_sim_ss.Time, flow_ex_sim_ss.Data)
legend("Measurement", "Equation Model", "Simscape Model")
title("Flow Extrusion")
hold off

figure
hold on
plot(flow_con.Time,     flow_con.Data)
plot(flow_con_sim_eq.Time, flow_con_sim_eq.Data)
% plot(flow_con_sim_ss.Time, flow_con_sim_ss.Data)
legend("Measurement", "Equation Model", "Simscape Model")
title("Flow Contraction")
hold off
