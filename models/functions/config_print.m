function [] = config_print(member)
    global SmallDamper_upper SmallDamper_bottom
    fault_code = member.FaultCode{1,1};
    valve2 = member.ThrottleValve1{1,1}.Variables; % Reversed in models
    valve1 = member.ThrottleValve2{1,1}.Variables;
    SmallDamper_bottom = member.SmallDamper_bottom{1,1}.Variables;
    SmallDamper_upper = member.SmallDamper_upper{1,1}.Variables;
    LargeDamper_bottom = member.LargeDamper_bottom{1,1}.Variables;
    LargeDamper_upper = member.LargeDamper_upper{1,1}.Variables;
    M_L = member.("Settings.Load"){1,1}{1,1};
    fprintf("Fault_code: %s \n", fault_code)
    fprintf("Parameters: \nvalve1: %d, valve2: %d \n", valve1, valve2)
    fprintf("damp_small_up: %d, damp_small_bot: %d \n", SmallDamper_upper, SmallDamper_bottom)
    fprintf("damp_large_up: %d, damp_large_bot: %d \n", LargeDamper_upper, LargeDamper_bottom)
end
