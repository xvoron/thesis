function data = extract_signals_from_member(member)
    Ts = 0.001;
    position = member.LeverPosition{1,1};
    
    % Velocity calculating from position signal
    velocity = position; % copy position
    velocity.Data = [diff(position.Data)/Ts; 0];
    
    acceleration = velocity; % copy velocity
    acceleration.Data = [diff(velocity.Data)/Ts; 0];

    prox_bot = member.ProximitySensor_bottom{1,1};
    prox_up = member.ProximitySensor_upper{1,1};
    acc_mov_y = member.AccelerometerMoving_axisY{1,1};
    acc_mov_z = member.AccelerometerMoving_axisZ{1,1};
    acc_stat_y = member.AccelerometerStatic_axisY{1,1};
    acc_stat_z = member.AccelerometerStatic_axisZ{1,1};
    flow_ex = member.FlowExtrusion{1,1};
    flow_con = member.FlowContraction{1,1};
    strain_gauge = member.StrainGauge{1,1};
    
    data = {position, velocity, flow_ex, flow_con, prox_bot, prox_up};
end