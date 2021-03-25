function [f_code, t, i_in_u1, i_in_u2, i_out_x, i_out_dx, i_out_f] = extract_signals4identification(data)


f_code = data.data.FaultCode{1,1};
preprocess = 0;
valve1 = data.data.ThrottleValve1{1,1}.Var1;
valve2 = data.data.ThrottleValve2{1,1}.Var1;
i_in1 = data.data.outValveHP{1,1};
i_in2 = data.data.outValveWP{1,1};
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

i_out = data.data.LeverPosition{1,1};
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
i_out = data.data.FlowExtrusion{1,1};
if preprocess
    [i_out, i_out_t] = preprocess_flow(i_out.Data, seconds(i_out.Time));
    i_out_flow_in = [i_out_t, i_out];
else
    i_out_flow_in = [seconds(i_out.Time), i_out.Data];
end

i_out = data.data.FlowContraction{1,1};
if preprocess
    [i_out, i_out_t] = preprocess_flow(i_out.Data, seconds(i_out.Time));
    i_out_flow_out = [i_out_t, i_out];
else
    i_out_flow_out = [seconds(i_out.Time), i_out.Data];
    i_out_t = seconds(i_out.Time);
end
i_out_f = [i_out_t, (i_out_flow_in(:,2) - i_out_flow_out(:,2))*k*rho];

end

