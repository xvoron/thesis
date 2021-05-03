clc;clear all;close all;

run sb/import_dataensemble.m

figure
hold on
reset(datastore);
while hasdata(datastore)
    member = read(datastore);
    if member.Label == "damp_small_bot"
        pos = member.LeverPosition{1,1};
        if member.FaultCode ~= "1100818"
            plot(pos.Time, pos.Data, 'DisplayName', string(member.FaultCode))
        end
    end
end

hold off
legend show
