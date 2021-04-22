function data = simulate_model(member)
    fault_code = member.FaultCode{1,1};
    load_fault_code_params(fault_code);
    simOut = sim("model_equation_simply_valves.slx");
    
    position_sim_eq = get(simOut.logsout, "LeverPosition").Values;
    velocity_sim_eq = get(simOut.logsout, "LeverVelocity").Values;
    prox_bot_sim_eq = get(simOut.logsout, "ProximitySensor_bottom").Values;
    prox_up_sim_eq  = get(simOut.logsout, "ProximitySensor_upper").Values;
    flow_ex_sim_eq  = get(simOut.logsout, "FlowExtrusion").Values;
    flow_con_sim_eq = get(simOut.logsout, "FlowContraction").Values;
    data = {position_sim_eq, velocity_sim_eq, flow_ex_sim_eq, flow_con_sim_eq, prox_bot_sim_eq, prox_up_sim_eq};
end