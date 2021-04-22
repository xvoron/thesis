function [t, u1, u2] = input_signals(member)
    inp_u1 = member.outValveHP{1,1};
    inp_u2 = member.outValveWP{1,1};
    t = seconds(inp_u1.Time);
    u1 = inp_u1.Data;
    u2 = inp_u2.Data;
end
    