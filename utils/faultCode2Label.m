function label = faultCode2Label(member)

label = 0;
fault_code = member.FaultCode;
str_fault_code = string(fault_code);
fault_code_extracted = str2num(str_fault_code.extractBetween(4,5));

switch fault_code_extracted
    case 0
        label = "health";
    case 32
        label = "valve1";
    case 16
        label = "valve2";
    case 8
        label = "damp_small_bot";
    case 2
        label = "damp_small_up";
end
end
