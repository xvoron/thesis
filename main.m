%                 _       
% _ __ ___   __ _(_)_ __  
%| '_ ` _ \ / _` | | '_ \ 
%| | | | | | (_| | | | | |
%|_| |_| |_|\__,_|_|_| |_|
%                         
%
clc;clear all;close all;

run sb/import_dataensemble.m
run models/params.m


fault_code = "1101609";
reset(datastore);
while hasdata(datastore)
   member = read(datastore);
   if member.FaultCode{1,1} == fault_code
      break;
   end
end

fault_code = member.FaultCode{1,1};

valve2 = member.ThrottleValve1{1,1}.Variables;
valve1 = member.ThrottleValve2{1,1}.Variables;

SmallDamper_bottom = member.SmallDamper_bottom{1,1}.Variables;
SmallDamper_upper = member.SmallDamper_upper{1,1}.Variables;

damp_large_bot = member.LargeDamper_bottom{1,1}.Variables;
damp_large_up = member.LargeDamper_upper{1,1}.Variables;

M_L = member.("Settings.Load"){1,1}{1,1};

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
Ts = 0.001;
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

%% Simulation
simOut = sim("models/model_equation.slx");

position_sim = get(simOut.logsout, "LeverPosition").Values;
velocity_sim = get(simOut.logsout, "LeverVelocity").Values;
prox_up_sim = get(simOut.logsout, "ProximitySensor_upper").Values;
prox_bot_sim = get(simOut.logsout, "ProximitySensor_bottom").Values;
prox_up_sim = get(simOut.logsout, "ProximitySensor_upper").Values;

flow_ex_sim = get(simOut.logsout, "FlowExtrusion").Values;
flow_con_sim = get(simOut.logsout, "FlowContraction").Values;

figure
hold on
plot(position.Time, position.Data)
plot(position_sim.Time, position_sim.Data)
legend
hold off

figure
hold on
plot(prox_up.Time, prox_up.Data)
plot(prox_up_sim.Time, prox_up_sim.Data)
legend
hold off


figure
hold on
plot(prox_bot.Time,     prox_bot.Data)
plot(prox_bot_sim.Time, prox_bot_sim.Data)
legend
hold off

figure
hold on
plot(velocity.Time,     velocity.Data)
plot(velocity_sim.Time, velocity_sim.Data)
legend
hold off

figure
hold on
plot(flow_ex.Time,     flow_ex.Data)
plot(flow_ex_sim.Time, flow_ex_sim.Data)
legend
hold off

figure
hold on
plot(flow_con.Time,     flow_con.Data)
plot(flow_con_sim.Time, flow_con_sim.Data)
legend
hold off
