function [] = load_fault_code_params(fault_code)
    %% Last identification 23.04
    
    global C_A_in C_A_out C_B_in C_B_out P_cr b_small_bot b_small_up
    switch fault_code
        case "1100001"
            fprintf("Healthy system behavior \n")
            C_A_in = 6.0242e-07;
            C_A_out = 5.155e-07;
            C_B_in = 1.7518e-07;
            C_B_out = 9.1476e-07;
            P_cr = 0.23894;
            b_small_bot = 2596.5;
            b_small_up = 1543.1;

        case "1103204"
            fprintf("Valve on B chamber changed value \n")
            C_A_in = 5.1391e-07;
            C_A_out = 2.4302e-07;
            C_B_in = 6.5289e-08;
            C_B_out = 8.8367e-07;
            P_cr = 0.75666;
            b_small_bot = 2596.5;
            b_small_up = 1543.1;
        case "1103203"
            fprintf("Valve on B chamber changed value \n")
            C_A_in = 6.8016e-07;
            C_A_out = 6.6809e-07;
            C_B_in = 2.966e-07;
            C_B_out = 8.0969e-07;
            P_cr = 0.8026;
            b_small_bot = 2596.5;
            b_small_up = 1543.1;
        case "1101607"
            fprintf("Valve on A chamber changed value \n")
            C_A_in = 6.5739e-07;
            C_A_out = 5.3311e-07;
            C_B_in = 2.0979e-07;
            C_B_out = 2.5924e-06;
            P_cr = 0.20501;
            b_small_bot = 2596.5;
            b_small_up = 1543.1;
        case "1101608"
            fprintf("Valve on A chamber changed value \n")
            C_A_in = 4.7064e-07;
            C_A_out = 5.2299e-07;
            C_B_in = 1.8721e-07;
            C_B_out = 3.8056e-07;
            P_cr = 0.19786;
            b_small_bot = 2596.5;
            b_small_up = 1543.1;
        case "1100220"
            fprintf("Upper small damper changed value \n")
            C_A_in = 5.6585e-07;
            C_A_out = 5.0623e-07;
            C_B_in = 2.0692e-07;
            C_B_out = 8.3411e-07;
            P_cr = 0.28049;
            b_small_bot = 2596.5;
            b_small_up = 1685.4;


        case "1100223"
            fprintf("Upper small damper changed value \n")
            C_A_in = 6.8608e-07;
            C_A_out = 5.2299e-07;
            C_B_in = 1.8721e-07;
            C_B_out = 9.8141e-07;
            P_cr = 0.20105;
            b_small_bot = 2281.3;
            b_small_up = 6760.2;
        case "1100816"
            fprintf("Bottom small damper changed value \n")
            C_A_in = 6.8608e-07;
            C_A_out = 5.2299e-07;
            C_B_in = 1.8721e-07;
            C_B_out = 9.8141e-07;
            P_cr = 0.20105;
            b_small_bot = 1682.5;
            b_small_up = 1400;

        case "1100817"
            fprintf("Bottom small damper changed value \n")
            C_A_in = 6.8608e-07;
            C_A_out = 5.2299e-07;
            C_B_in = 1.8721e-07;
            C_B_out = 9.8141e-07;
            P_cr = 0.20105;
            b_small_bot = 1082.6;
            b_small_up = 1400;            
    end
end

