% Identification 
clc;clear all;close all;

fault_code = "2200001"; % USER INPUT

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
fprintf("Fault code is %s\n", fault_code) 


% !!! Valves 2 = 1
valve2 = member.ThrottleValve1{1,1}.Variables;
valve1 = member.ThrottleValve2{1,1}.Variables;
SmallDamper_bottom = member.SmallDamper_bottom{1,1}.Variables;
SmallDamper_upper = member.SmallDamper_upper{1,1}.Variables;

LargeDamper_bottom = member.LargeDamper_bottom{1,1}.Variables;
LargeDamper_upper = member.LargeDamper_upper{1,1}.Variables;

M_L = member.("Settings.Load"){1,1}{1,1};

fprintf("Parameters: \n valve1: %d, valve2: %d \n", valve1, valve2)
fprintf("damp_small_up: %d, damp_small_bot: %d \n", SmallDamper_upper, SmallDamper_bottom)
fprintf("damp_large_up: %d, damp_large_bot: %d \n", LargeDamper_upper, LargeDamper_bottom)


[t, u1, u2, pos, vel, f_in, f_out] = extract_signals4identification(member);


function [t, i_in_u1, i_in_u2, i_out_x, i_out_dx, i_out_flow_in, i_out_flow_out] = extract_signals4identification(data)
preprocess = 0;

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
end

end

