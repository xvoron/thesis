%%                                     _                
% _ __   __ _ _ __ __ _ _ __ ___   ___| |_ ___ _ __ ___ 
%| '_ \ / _` | '__/ _` | '_ ` _ \ / _ \ __/ _ \ '__/ __|
%| |_) | (_| | | | (_| | | | | | |  __/ ||  __/ |  \__ \
%| .__/ \__,_|_|  \__,_|_| |_| |_|\___|\__\___|_|  |___/
%|_|                                                    
%
% Parameters for Matlab/Simulink models.
%
% Table of content:
%   1. Equation model parameters:
%       1.0 Gas parameters
%       1.1 General mechanic and geometric parameters:
%           1.1.0 General mechanic
%           1.1.1 Cylinder, piston
%           1.1.2 Solenoid valve
%           1.1.3 Control valves
%           1.1.4 Tubes, pipes (Not implemented yet)
%       1.2 Friction, Viscous force
%           1.2.0 Friction force easy 
%           1.2.1 Friction force complex
%           1.2.2 Only viscous force
%       1.3 Hard stop
%       1.4 Initial conditions
%   2. SimScape parameters
%   3. Parameters to identify
%   4. Sensors:
%       4.1 Flow Sensor
%
%   5. Input signals
%
% Parameters style sheet:
%   name    = value     % [units] [i/m/c/s] Description
%       where  e - identified or estimated
%              m - measured
%              c - calculated or constant
%              s - simulation variable
%
% Author: Artyom Voronin
% Date: 2021, Brno

%% 1. Equation models parameters
% 1.0 Gas parameters
rho     = 1.2;          % [kg/m^3] [c] Density of air
mu      = 1.825e-5;     % [kg/m-s] [c] Dynamic air viscosity
R       = 287.1;        % [J/kg/K] [c] Ideal gas constant
gamma   = 1.4;          % [-]      [c] Specific heat ratio
T       = 281.7;        % [K]      [c] Air temperature
P_s     = 6e5;          % [Pa]     [c] Supply pressure
P_0     = 101325;       % [Pa]     [c] Reference (atmospheric) pressure
c       = 343;          % [m/s]    [c] Sound speed

%% 1.1 General mechanic and geometric parameters
% 1.1.0 General mechanic parameters
g       = 9.81;         % [m/s^2]  [c] Gravity acceleration 

% 1.1.1 Cylinder, piston
M       = 6.7798462575453;  % [kg]  [e] Piston mass
M_L     = 6.25;             % [kg]  [s] Load mass
d_A     = 0.02;             % [m]   [c] Piston diameter from A side
d_S     = 0.008;            % [m]   [c] Stroke diameter
S_A     = (pi*d_A^2)/4;     % [m^2] [c] Chamber A cross-section
S_B     = S_A-(pi*d_S^2)/4; % [m^2] [c] Chamber B cross-section
S_0     = S_A-S_B;          % [m^2] [c] Road cross-section
V_0A    = S_A*0.015;        % [m^3] [c] Dead volume for chamber A
V_0B    = S_B*0.015;        % [m^3] [c] Dead volume for chamber B
L       = 0.2;              % [m]   [c] Piston length

% Port connections:
% 8mm diameter port connections
d_port      = 8e-3;            % [m]   [c] Port diameter
cs_A        = pi*d_port^2/4;   % [m^2] [c] Cross section at port A
cs_B        = pi*d_port^2/4;   % [m^2] [c] Cross section at port B

% 1.1.2 Solenoid Valve
% Kv coefficient calculated from data sheet from Nominal Flow, but in this
% work, not used. Valve coefficient was estimated from data.

Kv_max_main = 0.89095;  % [l/min]   [c] Flow coefficient at maximum
Kv_min_main = 1e-6;     % [l/min]   [c] Flow coefficient at leakage

C_f = 0.5;              % [-]   [-] Discharge coefficient
d_v = 6e-3;             % [m]   [c] Nominal diameter orifice diameter
A_v = pi*d_v^2/4;       % [m^2] [c] Nominal Bore
port_cs = 0.01;         % [m^2] [c] Ports cross section
d_G18 = 6e-3;
cs_G18 = pi*(d_G18)^2/4;% [m^2] [c] G-1/8 Port cross section

B_lam = 0.9999;         % [-]   [-] Laminar flow pressure ratio

% Valve offsets between ports (represented as Dead Zone for Simscape model
% parametrization. But not used in Equation model.
H_P2A = 0;         % [m^2] [ ] Valve opening fraction offset P->A
H_B2T = 0;         % [m^2] [ ] Valve opening fraction offset B->T
H_P2B = 0;         % [m^2] [ ] Valve opening fraction offset P->B
H_A2T = 0;         % [m^2] [ ] Valve opening fraction offset A->T

% Valve coefficients for subsonic and sonic mode
C_1 = sqrt(gamma/R*(2/(gamma+1))^((gamma+1)/(gamma-1)));
C_2 = sqrt((2*gamma)/(R*(gamma-1)));
% [-] Critical pressure ratio
P_cr  = (2/(gamma+1))^(gamma/(gamma-1));


% Estimated parameters in *First Principle Model* valves coefficients:
% This coefficients used as combination of C_f and A_v:
% C_x_x = C_f*A_v 
% where C_f is Discharge coefficient and A_v maximum orifice area

Kv_max_main = 0.269388; 
C_B_in  = Kv_max_main*A_v;
C_B_out = Kv_max_main*A_v;
C_A_in  = Kv_max_main*A_v;
C_A_out = Kv_max_main*A_v;

C_A_in = 6.0242e-07;  % [m^2] [e] Valve A side input coefficient
C_A_out = 5.155e-07;  % [m^2] [e] Valve A side output coefficient
C_B_in = 1.7518e-07;  % [m^2] [e] Valve B side input coefficient
C_B_out = 9.1476e-07; % [m^2] [e] Valve B side output coefficient


% Spool dynamic, represents transfer function and time delay coefficients
% of spool movement and orifice area opening. For simplification 1 dof
% model were used
%spool_dynamic = 0.0129;             % [-] [e]
%spool_valve_time_delay = 0.0302;    % [-] [e]
spool_dynamic = 0.02116;
spool_valve_time_delay = 0.01;

% 1.1.3 Control valves
% Control valves contain adjustment scale [0-10] that represent valve
% opening in one direction. This adjustment needs to be estimated from
% data, that contain pressure, flow, and adjustment number signals.

valve1 = 4;
valve2 = 6;

valve1_gain = 5e-3;
valve2_gain = 5e-3;

conv_SI     = 1.666667e-5;      % [-] [c] Convert [l/min]->[m^3/s]
lookup_q_l  = [130 80 50 35 20 15 10 5 3 2 0.5];
lookup_q_n  = lookup_q_l/130;

lookup_n    = 0:1:10;
lookup_q    = lookup_q_l*conv_SI*rho;

lookup_qn_Kv = flip([0.25 0.1728 0.11232 0.06912 0.0432 0.02592 0.02027808 0.0135216 ...
 0.0094608 0.00675648 0.00405216]);

% polynomial model 3
p = polyfit(lookup_n, lookup_q_n, 4);
p4 = p(1);
p3 = p(2);
p2 = p(3);
p1 = p(4);
p0 = p(5);

C_adj_in = 0.234651093725739;
C_adj_out = 0.0916820948391511;

% 1.1.4 Tubes, Pipes
% Tubes and pipes transfer dynamic was neglected at this work.
laminar_flow = 1;       % [bool] [ ] Laminar flow (1)/ Turbulent flow (0)
L_t          = 1;       % [m]    [ ] Tube length
D            = 0.0005;  % [m]    [ ] Tube diameter
pipe_cs      = 0.01;    % [m^2]  [ ] Tube cross section
pipe_hyd_D   = 0.1;     % [m]    [ ] Tube hydraulic diameter

if laminar_flow
    R_t = 32*mu/D^2;    % [?]    [ ] Tube resistance 
else
    R_t = 0;
end

% 1.2 Friction, Viscous force
% Friction force can be modeled by different ways:
friction_mode = 0;
% 1.2.0 Friction force easy
% F_f = F_sf            if dx = 0
% F_f = F_df*sign(dx)   if dx != 0
%
% where F_sf - static friction
%       F_df - dynamic friction

if friction_mode == 0
    F_c = 0;
    F_df = 0;
    F_sf = 0;
end

% 1.2.1 Friction given more complex equation:
%      / beta*dx+[f_c+(f_sf-f_c)*e^{-(dx/v_s)^delta}]sign(dx) if dx<=v_e
% F_f =|
%      \ f_df*dx                                              if dx>v_e

if friction_mode == 1
    beta  = 100;    % [ ] [ ] Viscous friction coefficient
    f_c   = 1;      % [ ] [ ] Coulomb friction
    f_sf  = 1;      % [ ] [ ] Static friction
    f_df  = 1;      % [ ] [ ] Dynamic friction
    v_s   = .1;     % [ ] [ ] Stribeck velocity
    v_e   = 1;      % [ ] [ ] Critical velocity
    delta = .5;     % [ ] [ ] Arbitrary index
end

% 1.2.2 Only viscous force
% Viscous force represented as constant parameter beta
% Parameter estimated results show that viscous force is neglected 
beta = 0;       % [kg/s^2] [e] Viscous friction coefficient
% Resistant force F_rf = F_df*sign(dx) + beta*dx

% 1.3 Hard stop
gp      = 0.19382;% [m]       [ ] Hard stop length from ref point to side
gn      = 0;      % [m]       [ ] Hard stop length from ref point to side
K_hs    = 1e7;    % [kg/s^2]  [ ] Hard stop spring
B_hs    = 1e2;    % [kg/s^2]  [ ] Hard stop damping

% Pneumatic parameters
Smax    = 7.917e-6;     % [m^2]    Maximum cross section 
Seq     = 7.917e-6;     % [m^2]    Equivalent cross section 
Cd      = 1; %Seq/Smax; % [-]      Contraction coefficient

%   [-]   Critical flow coefficient
psi_max = (2/(gamma+1))^(1/(gamma-1))*sqrt(gamma/(gamma+1));
%   [-]   Critical pressure ratio

% Hydraulic/Pneumatic parameters
Rv      = 1;       % []    [ ] Compressibility
V       = 0.01;    % [m^3] [ ] Volume
Ek      = 10;      % []    [ ] Compressibility factor
f_tr    = 0.07;    %  ?    [ ] Friction between piston and cylinder
tr_hs =  0.1;

% 2. Mechanical system parameters

%% 2.1 Endstop Buffers from 0017.pdf datasheet:
spring_rate     = 327;          % [N/mm] [ ] Spring rate 
spring_rate_SI  = 327/9.81*1e3; % [kg/m] [ ] Spring rate in SI
spring_range    = 7.5e-3;       % [m]    [ ] Spring range
endstop_length  = 30e-3;        % [m]    [ ] Endstop length

% Shock Absorbs - Small dampers 

b_small_bot = 1400;        % [kg/s] [e] Damping coefficient
b_small_up  = 1400;        % [kg/s] [e] Damping coefficient
k_small_bot = 0;           % [kg/m] [e] Spring coefficient
k_small_up  = 0;           % [kg/m] [e] Spring coefficient

damp_small_gain_up = 4;
damp_small_gain_bot = 4;

SmallDamper_bottom = 6;
SmallDamper_upper  = 4;

LargeDamper_bottom = 0;
LargeDamper_upper  = 0;

b_large_bot = 1400;        % [kg/s] [e] Damping coefficient
b_large_up  = 1400;        % [kg/s] [e] Damping coefficient

bot_damp_start = 0.01054;   % [m] [e] Lower damper starting point
up_damp_start  =  0.18123;  % [m] [e] Upper damper starting point


% Initial Conditions
x0      = 0;                    % [m]   [m] Initial displacement
V_A0    = V_0A + S_A*x0;        % [m^3] [-] Initial volume chamber A
V_B0    = V_0B + S_B*(L-x0);    % [m^3] [-] Initial volume chamber B
m_A0    = V_A0 * rho;           % [kg]  [-] Initial mass in chamber A
m_B0    = V_B0 * rho;           % [kg]  [-] Initial mass in chamber B
T_A0    = T;                    % [K]   [c] Initial temperature in chamber A
T_B0    = T;                    % [K]   [c] Initial temperature in chamber A 
p_A0    = m_A0*R*T_A0/V_A0;     % [Pa]  [c] Initial pressure in chamber A
p_B0    = m_B0*R*T_B0/V_B0;     % [Pa]  [c] Initial pressure in chamber A
p_A0    = P_0;                  % [Pa]  [-] Simplification
p_B0    = P_s;                  % [Pa]  [-] Simplification


%% 2. SimScape parameters
B_simscape = 100;    % [N/(m/s)] [ ] Damping coeficient

%% 4. Sensors
% 4.0 Sample time for sensors
Freq = 1e3;     % [Hz] [c] Frequency
Ts   = 1/Freq;  % [Hz] [c] Sample time

% 4.1 Flow Sensor:
% 8035301 SFTE-10U-Q4-V-0.3M8D
U_f_max         = 10;                % [V]      [c] Maximum Voltage output
dm_max          = 10;                % [l/min]  [c] Maximum Volume Flow
conv_SI         = 1.666667e-5;       % [-]      [c] Convert [l/min]->[m^3/s]
dm_max_SI       = dm_max*conv_SI;    % [m^3/s]  [c] Maximum Flow in SI
flow_enable     = 1;                 % [-]      [f] Flag enable/disable
flow_offset     = 0;                 % [l/min]  [c] Flow offset (sensor fault)
flow_offset_ex  = 0;                 % [l/min]  [c] Flow offset (sensor fault)
flow_offset_con = 0;                 % [l/min]  [c] Flow offset (sensor fault)

% Noise parameter:
flow_noise_var      = 1e-6;           % [-] [e] Noise variance of flow sensors
flow_noise_var_con  = 1e-6;           % [-] [e] Noise variance of flow sensors
flow_noise_var_ex   = 1e-6;           % [-] [e] Noise variance of flow sensors

% Sensor constants for Matlab function:
flow_C_ratio = dm_max/U_f_max;
flow_C = flow_enable/flow_C_ratio/conv_SI;

% 4.2 Proximity sensors (digital sensor):
prox_up_band     = 0.1925;       % [-] [m] Upper position
prox_bot_band    = 4e-4;         % [-] [m] Bottom position

% 4.3 Accelerometer sensors
acc_enable = 1;         % [-]       [f] Flag enable/disable
acc_C = -1/g;           % [s^2/m]   [c] Acc coefficient
acc_noise_var = 1e-1;   % [-]       [e] Noise variance

% 4.4 Strain Gauge
sg_enable = 1;         % [-]   [f] Flag enable/disable
Us = 10;               % [V]   [c] Source voltage
F_max = 2e3;           % [N]   [c] Maximum Force
sg_C = Us/F_max; %     % [-]   [c] Strain gauge coefficient
sg_noise_var = 1e-1;   % [-]   [e] Noise variance of strain gauge sensor

% 4.3 Encoder Digital sensor
% Require large Fs from simulation for working
resolution = 7.8125e-6;             % [m]   [c] Sensor resolution
counter_bits = 32;                  % [bit] [c] Maximum counter bits
threshold = 2^(counter_bits - 1);   % [-]   [c] Maximum counter value

%% 5.0 Faults simulation
% 5.1 Air leak from B chamber
P_cr_ref = P_cr;
air_leak = 0;
C_leak = 1e-15;

%% Input signals for simulation
%
member = load('../data/data11/data11_1_1.mat');
inp_u1 = member.data.outValveHP{1,1};
inp_u2 = member.data.outValveWP{1,1};
t = seconds(inp_u1.Time);   % [s] Time vector
u1 = inp_u1.Data;           % Input signal
u2 = inp_u2.Data;           % Input signal

cycle = 0;
id = 0;
%% Loading Different estimated modes depends on fault codes

fault_code = "1100001"
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

    case "1103204" % 1103204 skrt1 = 6
        fprintf("Valve on B chamber changed value \n")
        C_A_in = 5.1391e-07;
        C_A_out = 2.4302e-07;
        C_B_in = 6.5289e-08;
        C_B_out = 8.8367e-07;
        P_cr = 0.75666;
        b_small_bot = 2596.5;
        b_small_up = 1543.1;

    case "1103203" % 1104203 skrt1 = 2
        fprintf("Valve on B chamber changed value \n")
        C_A_in = 6.8016e-07;
        C_A_out = 6.6809e-07;
        C_B_in = 2.966e-07;
        C_B_out = 8.0969e-07;
        P_cr = 0.8026;
        b_small_bot = 2596.5;
        b_small_up = 1543.1;

    case "1101607" % 1101607 skrt2 = 0;
        fprintf("Valve on A chamber changed value \n")
        C_A_in = 6.5739e-07;
        C_A_out = 5.3311e-07;
        C_B_in = 2.0979e-07;
        C_B_out = 2.5924e-06;
        P_cr = 0.20501;
        b_small_bot = 2596.5;
        b_small_up = 1543.1;

    case "1101608" % 1101608 skrt2 = 6;
        fprintf("Valve on A chamber changed value \n")
        C_A_in = 4.7064e-07;
        C_A_out = 5.2299e-07;
        C_B_in = 1.8721e-07;
        C_B_out = 3.8056e-07;
        P_cr = 0.19786;
        b_small_bot = 2596.5;
        b_small_up = 1543.1;

    case "1100220" % 1100220 damp_small_up = 2
        fprintf("Upper small damper changed value \n")
        C_A_in = 5.6585e-07;
        C_A_out = 5.0623e-07;
        C_B_in = 2.0692e-07;
        C_B_out = 8.3411e-07;
        P_cr = 0.28049;
        b_small_bot = 2596.5;
        b_small_up = 1685.4;

    case "1100223" % 1100223 damp_small_up = 6
        fprintf("Upper small damper changed value \n")
        C_A_in = 6.8608e-07;
        C_A_out = 5.2299e-07;
        C_B_in = 1.8721e-07;
        C_B_out = 9.8141e-07;
        P_cr = 0.20105;
        b_small_bot = 2281.3;
        b_small_up = 6760.2;

    case "1100816" % 1100816 damp_small_bot = 5
        fprintf("Bottom small damper changed value \n")
        C_A_in = 6.8608e-07;
        C_A_out = 5.2299e-07;
        C_B_in = 1.8721e-07;
        C_B_out = 9.8141e-07;
        P_cr = 0.20105;
        b_small_bot = 1682.5;
        b_small_up = 1543.1;

    case "1100817" % 1100817 damp_small_bot = 7
        fprintf("Bottom small damper changed value \n")
        C_A_in = 6.8608e-07;
        C_A_out = 5.2299e-07;
        C_B_in = 1.8721e-07;
        C_B_out = 9.8141e-07;
        P_cr = 0.20105;
        b_small_bot = 1082.6;
        b_small_up = 1543.1;
end
