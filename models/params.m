%%                                     _                
% _ __   __ _ _ __ __ _ _ __ ___   ___| |_ ___ _ __ ___ 
%| '_ \ / _` | '__/ _` | '_ ` _ \ / _ \ __/ _ \ '__/ __|
%| |_) | (_| | | | (_| | | | | | |  __/ ||  __/ |  \__ \
%| .__/ \__,_|_|  \__,_|_| |_| |_|\___|\__\___|_|  |___/
%|_|                                                    
%
% Parameters for Matlab/Simulink models.
%
% TODO:
%   * [ ] Parameters to estimate/identify
%   * [ ] Parameters measured
%   * [ ] Parameters constant/calculated
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
T       = 281.7;        % [K]      [e] Air temperature
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
V_0A    = S_A*0.015;        % [m^3] [ ] Dead volume for chamber A
V_0B    = S_B*0.015;        % [m^3] [ ] Dead volume for chamber B
L       = 0.2;              % [m]   [ ] Piston length
F_L     = 0;                % [N]   [ ] Load force

% Port connections:
% 8mm diameter port connections
d_port      = 8e-3;            % [m]   [ ] Port diameter
cs_A        = pi*d_port^2/4;   % [m^2] [ ] Cross section at port A
cs_B        = pi*d_port^2/4;   % [m^2] [ ] Cross section at port B

% 1.1.2 Solenoid Valve

% TODO: All this parameters are identification or can be calculated or
% measured ?

Kv_max_main = 0.89095;  % [-]   [ ] Flow coefficient at maximum
Kv_min_main = 1e-6;     % [-]   [ ] Flow coefficient at leakage

C_f = 0.5;              % [-]   [ ] Discharge coefficient
d_v = 6e-3;             % [m]   [c] Nominal diameter orifice diameter
A_v = pi*d_v^2/4;       % [m^2] [ ] Nominal Bore
% A_v = 7.917e-6;       % [m^2] [ ] Maximum cross section 
port_cs = 0.01;         % [m^2] [ ] Ports cross section
d_G18 = 6e-3;
cs_G18 = pi*(d_G18)^2/4;% [m^2] [ ] G-1/8 Port cross section

B_lam = 0.9999;         % [-]   [ ] Laminar flow pressure ratio

% Valve offsets between ports (represented as Dead zone
H_P2A = 0;         % [m^2] [ ] Valve opening fraction offset P->A
H_B2T = 0;         % [m^2] [ ] Valve opening fraction offset B->T
H_P2B = 0;         % [m^2] [ ] Valve opening fraction offset P->B
H_A2T = 0;         % [m^2] [ ] Valve opening fraction offset A->T

% Valve coefficients for subsonic and sonic mode
C_1 = sqrt(gamma/R*(2/(gamma+1))^((gamma+1)/(gamma-1)));
C_2 = sqrt((2*gamma)/(R*(gamma-1)));
% [-] Critical pressure ratio
P_cr  = (2/(gamma+1))^(gamma/(gamma-1));

% Equation model valves coefficients:
% This coefficients represents equation:
% C_x_x = C_f*A_v 
% where C_f is Discharge coefficient and A_v orifice area

C_A_in  = 1.16991103240854e-06;  % [m^2] [e] Valve A side input coefficient
C_A_out = 8.56405949772472e-07;  % [m^2] [e] Valve A side output coefficient
C_B_in  = 2.29610139973006e-07;  % [m^2] [e] Valve B side input coefficient
C_B_out = 9.48518952870443e-07;  % [m^2] [e] Valve B side output coefficient

spool_dynamic = 0.0129687892258071;
spool_valve_time_delay = 0.030215112821256;

% 1.1.3 Control valves
valve1 = 4;
valve2 = 6;

valve1_gain = 5e-3;
valve2_gain = 5e-3;

Kv_max_cntr = 0.89095;  % [-]   [ ] Flow coefficient at maximum
Kv_min_cntr = 1e-6;     % [-]   [ ] Flow coefficient at leakage

conv_SI     = 1.666667e-5;       % [-]      [c] Convert [l/min]->[m^3/s]
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

% 1.1.4 Tubes, Pipes
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
    F_sf = 0;
    F_df = 0;
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
L_max   = L;      % [m]       [ ] Hard stop upper bound
L_min   = 0;      % [m]       [ ] Hard stop upper bound
K_hs    = 1e7;    % [kg/s^2]  [ ] Hard stop spring
B_hs    = 1e2;    % [kg/s^2]  [ ] Hard stop damping
K_ks    = 1e5;    % [kg/s^2]  [ ] Hard stop spring
B_ks    = 1e5;    % [kg/s^2]  [ ] Hard stop damping

gp      = 0.19382; % [m] [ ] Hard stop length from ref point to side
gn      = 0;       % [m] [ ] Hard stop length from ref point to side

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
b_max   = 0.18;    % [m]
b_min   = 0.02;    % [m]
b1      = 100;     % [kg/s]
b2      = 100;     % [kg/s]   
k1      = 1500;    % [kg/s^2]
k2      = 1500;    % [kg/s^2]   
K       = 1500;    % [kg/s^2]

% Endstop Buffers from 0017.pdf datasheet:
spring_rate     = 327;          % [N/mm] [ ] Spring rate 
spring_rate_SI  = 327/9.81*1e3; % [kg/m] [ ] Spring rate in SI
spring_range    = 7.5e-3;       % [m]    [ ] Spring range
endstop_length  = 30e-3;        % [m]    [ ] Endstop length

% Shock Absorbs 
% Small dampers 

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

x0      = 0;                    % [m]   [ ] Initial displacement
V_A0    = V_0A + S_A*x0;        % [m^3] [ ] Initial volume chamber A
V_B0    = V_0B + S_B*(L-x0);    % [m^3] [ ] Initial volume chamber B
m_A0    = V_A0 * rho;           % [kg]  [ ] Initial mass in chamber A
m_B0    = V_B0 * rho;           % [kg]  [ ] Initial mass in chamber B
T_A0    = T;                    % [K]   [ ] Initial temperature in chamber A
T_B0    = T;                    % [K]   [ ] Initial temperature in chamber A 
p_A0    = m_A0*R*T_A0/V_A0;     % [Pa]  [ ] Initial pressure in chamber A
p_B0    = m_B0*R*T_B0/V_B0;     % [Pa]  [ ] Initial pressure in chamber A
p_A0    = P_0;
p_B0    = P_s;



%% 2. SimScape parameters
% Thermal mass:
%
B_simscape = 100;    % [N/(m/s)] [ ] Damping coeficient

% Pressure chamber
% Everything about pressure chamber has _s index
%V_s     = 0.001;     % [m^3] [ ] Storage chamber volume
%S_s     = 0.01;      % [m^2] [ ] Cross section area at port on storage chamber


F_sf = 100;
F_df = 100;
F_load = 1;


%% 3. Parameters to identification
Beta1 = 0.0001;
Beta2 = 0.0001;



%% 4. Sensors
% 4.0 Sample time for sensors
Freq = 1e3;     % [Hz] [c] Frequency
Ts   = 1/Freq;  % [Hz] [c] Sample time


% 4.1 Flow Sensor:
% 8035301 SFTE-10U-Q4-V-0.3M8D
U_f_max     = 10;                % [m^3]    [c] Maximum Voltage output
dm_max      = 10;                % [l/min]  [c] Maximum Volume Flow
conv_SI     = 1.666667e-5;       % [-]      [c] Convert [l/min]->[m^3/s]
dm_max_SI   = dm_max*conv_SI;    % [m^3/s]  [c] Maximum Flow in SI
flow_enable = 1;                 % [-]      [f] Flag enable/disable

% Noise parameter:
flow_noise_var = 1e-10;

% Sensor constants for Matlab function:
flow_C_ratio = dm_max/U_f_max;
flow_C = flow_enable/flow_C_ratio/conv_SI;


% 4.2 Proximity sensors:
prox_up_band     = 0.1925;       % [-] [m] Upper position
prox_bot_band    = 4e-4;         % [-] [m] Bottom position


% 4.3 Accelerometer sensors
acc_enable = 1;
acc_C = -1/g;
acc_noise_var = 1e-1;

% 4.4 Strain Gauge
sg_enable = 1;
Us = 10; % V
F_max = 2e3; % N
sg_C = Us/F_max; % 
sg_noise_var = 1e-1;

%% Estimated parameters:
b_small = 5184.3;
% beta = 0.407;
k_small = 219.12;
% valve1_gain = 0.0051;
% valve2_gain = 0.021385;

% 
%   %Kv_max_cntr = 0.80345
% %     Kv_max_main = 3.6725
%     b_small = 7484.4;
%     beta = 0.13225;
%     k_small = 392.67;
%     valve1_gain = 0.0067732;
%     valve2_gain = 0.021263;
%     H_A2T = 0.048426;
%     H_B2T = 0.052814;
%     H_P2A = 0.05734;
%     H_P2B = 0.053854;
%     cs_G18 = 4.8851e-05;


%test
%
%% Input signals for simulation:
member = load('../data/data11/data11_1_1.mat');
inp_u1 = member.data.outValveHP{1,1};
inp_u2 = member.data.outValveWP{1,1};
t = seconds(inp_u1.Time);
u1 = inp_u1.Data;
u2 = inp_u2.Data;
% TODO



C_B_in = 5.422e-07;
C_B_out = 1.6346e-06;
C_A_in = 6.6254e-07;
C_A_out = 5.1408e-07;
b_small_bot = 2056.2;
b_small_up = 1350.3;
spool_dynamic = 0.012096;
spool_valve_time_delay = 0.020455;

d_v = 6e-3;             % [m]   [c] Nominal diameter orifice diameter
A_v = pi*d_v^2/4;       % [m^2] [ ] Nominal Bore
% A_v = 7.917e-6;       % [m^2] [ ] Maximum cross section 

Kv_max_main = 0.269388; 
C_adj_in = 0.1969696;
C_adj_out = 0.371212;
C_B_in  = Kv_max_main*A_v;
C_B_out = Kv_max_main*A_v;
C_A_in  = Kv_max_main*A_v;
C_A_out = Kv_max_main*A_v;


C_adj_in = 0.164370373676547;
C_adj_out = 0.0892545896672297;
spool_dynamic = 0.0211675780438368;
spool_valve_time_delay = 0.0169649581718457;
b_small_bot = 1400;
b_small_up = 1417.14082244839;

cycle = 0;
