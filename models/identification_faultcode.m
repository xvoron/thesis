% Identification 
clc;clear all;close all;

fault_code = "1101607"; % USER INPUT

run ../utils/import_only_signals_datastore.m
run params.m

reset(datastore);
while hasdata(datastore)
   member = read(datastore);
   if member.FaultCode{1,1} == fault_code
      break;
   end
end

fault_code = member.FaultCode{1,1};
fprintf("Fault code is %s", fault_code) 


% !!! Valves 2 = 1
valve2 = member.ThrottleValve1{1,1}.Variables;
valve1 = member.ThrottleValve2{1,1}.Variables;
SmallDamper_bottom = member.SmallDamper_bottom{1,1}.Variables;
SmallDamper_upper = member.SmallDamper_upper{1,1}.Variables;

damp_large_bot = member.LargeDamper_bottom{1,1}.Variables;
damp_large_up = member.LargeDamper_upper{1,1}.Variables;

M_L = member.("Settings.Load"){1,1}{1,1};

fprintf("Parameters: \n valve1: %s, valve2: %s \n", valve1, valve2)
fprintf("damp_small_up: %s, damp_small_bot: %s \n", SmallDamper_upper, SmallDamper_bottom)
fprintf("damp_large_up: %s, damp_large_bot: %s \n", damp_large_up, damp_large_bot)


[f_code, t, i_in_u1, i_in_u2, i_out_x, i_out_dx, i_out_f] = extract_signals4identification(member);


function [f_code, t, i_in_u1, i_in_u2, i_out_x, i_out_dx, i_out_f] = extract_signals4identification(data)
f_code = data.FaultCode{1,1};
preprocess = 0;
valve1 = data.ThrottleValve1{1,1}.Var1;
valve2 = data.ThrottleValve2{1,1}.Var1;
i_in1 = data.outValveHP{1,1};
i_in2 = data.outValveWP{1,1};
i_in = i_in1;
i_in.Data = i_in2.Data + i_in1.Data*(-1);

if preprocess
    [i_in_u, i_in_t] = preprocess_input(i_in.Data, seconds(i_in.Time));
    i_in_u = [i_in_t, i_in_u];
else
    i_in_u1 = [seconds(i_in1.Time), i_in1.Data];
    i_in_u2 = [seconds(i_in2.Time), i_in2.Data];
    t = seconds(i_in1.Time);
end

i_out = data.LeverPosition{1,1};
if preprocess
    [i_out, i_out_t] = preprocess_position(i_out.Data, seconds(i_out.Time));
    i_out_x = [i_out_t, i_out];
    h = 0.001; % TODO
    dx = diff(i_out)/h; dx(end+1) = 0;
    i_out_dx = [i_out_t, dx];
else
    i_out_x = [seconds(i_out.Time), i_out.Data];
    i_out_t = seconds(i_out.Time);
    
    h = 0.001;
    dx = diff(i_out.Data)/h; dx(end+1) = 0;
    i_out_dx = [i_out_t, dx];
end


% Flow conversion from l/min -> m^3/s -> kg/s
% 1 l/min = 1.66667e-5 m^3/s
% 1 m^3/s = 
k = 1.66667e-5;
rho = 1.2;
i_out = data.FlowExtrusion{1,1};
if preprocess
    [i_out, i_out_t] = preprocess_flow(i_out.Data, seconds(i_out.Time));
    i_out_flow_in = [i_out_t, i_out];
else
    i_out_flow_in = [seconds(i_out.Time), i_out.Data];
end

i_out = data.FlowContraction{1,1};
if preprocess
    [i_out, i_out_t] = preprocess_flow(i_out.Data, seconds(i_out.Time));
    i_out_flow_out = [i_out_t, i_out];
else
    i_out_flow_out = [seconds(i_out.Time), i_out.Data];
    i_out_t = seconds(i_out.Time);
end
i_out_f = [i_out_t, (i_out_flow_in(:,2) - i_out_flow_out(:,2))*k*rho];

end

