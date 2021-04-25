function [] = plot_position_by_fault_type(complete_members)
    health = [];
    valve1 = [];
    valve2 = [];
    damp_up = [];
    damp_bot = [];

    for i = 1:length(complete_members)
        fault_code = complete_members(i).fault_code;

        switch fault_code
            case "1100001"
                health = complete_members(i);
            case "1103204"
                valve1 = [valve1; complete_members(i)];
            case "1103203"
                valve1 = [valve1; complete_members(i)];
            case "1101607"
                valve2 = [valve2; complete_members(i)];
            case "1101608"
                valve2 = [valve2; complete_members(i)];
            case "1100220"
                damp_up = [damp_up; complete_members(i)];
            case "1100223"
                damp_up = [damp_up; complete_members(i)];
            case "1100816"
                damp_bot = [damp_bot; complete_members(i)];
            case "1100817"
                damp_bot = [damp_bot; complete_members(i)];
        end

    end
    plot_handler(health, valve1, "Valve1 fault type") 
    plot_handler(health, valve2, "Valve2 fault type") 
    plot_handler(health, damp_up, "Upper damper fault type") 
    plot_handler(health, damp_bot, "Bottom damper fault type") 
end



