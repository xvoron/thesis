function label = faultCode2Label_combinedFaults(member)

label = 0;
fault_code = member.FaultCode;
str_fault_code = string(fault_code);

switch str_fault_code

    case "2200001"
        label = "health";
    case "2211202"
        label = "pressure+valve1";
    case "2208003"
        label = "pressure+valve2";
    case "2207204"
        label = "pressure+damp_small_bot";
    case "2206905"
        label = "pressure+damps_large";
    case "2206606"
        label = "pressure+damp_small_up";
    case "2204807"
        label = "valve1+valve2";
    case "2204008"
        label = "valve1+damp_small_bot";
    case "2203711"
        label = "valve1+damps_large";
    case "2203412"
        label = "valve1+damp_small_up";
    case "2202413"
        label = "valve2+damp_small_bot";
    case "2202114"
        label = "valve2+damps_large";
    case "2201815"
        label = "valve2+damp_small_up";
    case "2201316"
        label = "damp_small_bot+damps_large";
    case "2201017"
        label = "damp_small_bot+damp_small_up";
    case "2200718"
        label = "damps_large+damp_small_up";
end
end



