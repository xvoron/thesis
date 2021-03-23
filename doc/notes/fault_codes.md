%title Fault Codes

= Codes for PM =

Fault code:
| xxx        | xx         | xx     |
|------------|------------|--------|
| experiment | where      | detail |

For fault code "where":

| health | valve 1 | valve 2 | small damp bottom | small damp upper |
|--------|---------|---------|-------------------|------------------|
| 00     | 32      | 16      | 08                | 02               |

Matlab extraction:
{{{matlab
fault_code = member.FaultCode{1,1}{1,1};
str_fault_code = string(fault_code);
fault_code_extracted = str2num(str_fault_code.extractBetween(4,5));

switch fault_code_extracted
    case 0
        disp("Heath")
    case 32
        disp("Valve1")
    case 16
        disp("Valve2")
    case 8
        disp("SmallDampBot")
    case 2
        disp("SmallDampUp")
end
}}}
