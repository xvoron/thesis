function table_data = data_preprocess(member)


    flow_ext = member.FlowExtrusion{1};
    flow_cont = member.FlowContraction{1};
    pressure = member.AirPressure{1};
    acc_Z = member.Accelerometer_axisZ{1};
    acc_Y = member.Accelerometer_axisY{1};
    strain = member.StrainGauge{1};

    % Microphone
    mic_ubump = member.MIC_uBumper{1};
    mic_bbump =member.MIC_bBumper{1};
    mic_ambient =member.MIC_Ambient{1};

    % % Temperature
    %temp_cylinder = member.Temp_Cylinder{1};
    %temp_ambient = member.Temp_Ambient{1};

    % Digital signals
    prox_bottom = member.ProximitySensor_bottom{1};
    prox_upper = member.ProximitySensor_upper{1};
    possition = member.LeverPosition{1};

 
    out_valve_HP = member.outValveHP{1};
    out_valve_WP = member.outValveWP{1};


    % Movmean applying to flow mic and acc signals
    flow_ext.Data       = preprocess_Flow(flow_ext.Data, seconds(flow_ext.Time));
    flow_cont.Data      = preprocess_Flow(flow_cont.Data, seconds(flow_cont.Time));
    mic_ubump.Data      = preprocess_Mic(mic_ubump.Data, seconds(mic_ubump.Time));
    mic_bbump.Data      = preprocess_Mic(mic_bbump.Data, seconds(mic_bbump.Time));
    mic_ambient.Data    = preprocess_Mic(mic_ambient.Data, seconds(mic_ambient.Time));
    acc_Z.Data          = preprocess_Acc(acc_Z.Data, seconds(acc_Z.Time));
    acc_Y.Data          = preprocess_Acc(acc_Y.Data, seconds(acc_Y.Time));
    strain.Data         = preprocess_StrainGauge(strain.Data, seconds(strain.Time));
    pressure.Data       = preprocess_AirPressure(pressure.Data, seconds(pressure.Time));

    table_data = table({flow_ext}, ...
                       {flow_cont}, ...
                       {mic_ubump}, ...
                       {mic_bbump}, ...
                       {mic_ambient}, ...
                       {acc_Z}, ...
                       {acc_Y}, ...
                       {strain}, ...
                       {pressure}, ...
                       'VariableNames', { ...
                       'FlowExtrusion', ...
                       'FlowContraction', ...
                       'MIC_uBumper', ...
                       'MIC_bBumper', ...
                       'MIC_Ambient', ...
                       'Accelerometer_axisZ', ...
                       'Accelerometer_axisY', ...
                       'StrainGauge', ...
                       'AirPressure'});
end

