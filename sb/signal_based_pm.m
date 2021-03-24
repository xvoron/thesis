%% Signal Based
% The first thing to do is to create a dataset and to evaluate condition indicators.

run import_dataensemble.m
%% 
% The dataset contain different signals from sensors:

tall(datastore)
reset(datastore)
health_data=0;valve1_data=0;valve2_data=0;dampup_data=0;dampbot_data=0;
while hasdata(datastore)
    member = read(datastore);
    switch member.Label
        case "health"
            health_data = health_data + 1;
        case "valve1"
            valve1_data = valve1_data + 1;
        case "valve2"
            valve2_data = valve2_data + 1;
        case "damp_small_bot"
            dampbot_data = dampbot_data + 1;
        case "damp_small_up"
            dampup_data = dampup_data + 1;
           
    end
end

fprintf("health = %d, valve1 = %d, valve2 = %d, damper_small_ up = %d, damper_small_bot = %d\n", ...
health_data, valve1_data, valve2_data, dampup_data, dampbot_data)

