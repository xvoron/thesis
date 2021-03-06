function data = process_member(member)
%% Processing member
% Description:
% 	Processing ensemble member and extract signals and parameters
% Content:
%	- init
%
% Author: Artyom Voronin
% Brno, 2021

% Parameters

fault_code = member.FaultCode{1,1}.Variables;

valve1 = member.ThrottleValve1{1,1}.Variables;
valve2 = member.ThrottleValve2{1,1}.Variables;

damp_small_bot = member.SmallDamper_bottom{1,1}.Variables;
damp_small_up = member.SmallDamper_upper{1,1}.Variables;

damp_large_bot = member.LargeDamper_bottom{1,1}.Variables;
damp_large_up = member.LargeDamper_upper{1,1}.Variables;

load = member.("Settings.Load"){1,1}{1,1};

temp_cylinder = member.Temp_Cylinder{1,1};
temp_ambient  = member.Temp_Ambient{1,1};

% Signals

inp_u1 = member.outValveHP{1,1};
inp_u2 = member.outValveWP{1,1};

position = member.LeverPosition{1,1};


% Velocity calculating from position signal
Ts = 0.001;
velocity = position; % copy position
velocity.Data = diff(position.Data)/Ts;
velocity.Data(end+1) = 0;

acceleration = velocity; % copy velocity
acceleration.Data = diff(velocity.Data)/Ts;
acceleration.Data(end+1) = 0;

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

data = 1
end
