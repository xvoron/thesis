clc;clear all;close all;

run sb/import_dataensemble.m

ax1 = subplot(5,1,1);
ax2 = subplot(5,1,2);
ax3 = subplot(5,1,3);
ax4 = subplot(5,1,4);
ax5 = subplot(5,1,5);
hold(ax1, 'on');
hold(ax2, 'on');
hold(ax3, 'on');
hold(ax4, 'on');
hold(ax5, 'on');

title(ax1, 'Health data');
title(ax2, 'Fault valve1');
title(ax3, 'Fault valve2');
title(ax4, 'Fault bottom damper');
title(ax5, 'Fault upper damper');

reset(datastore);
while hasdata(datastore)
    member = read(datastore);
    switch member.Label
        case "health"
            plot(ax1, member.LeverPosition{1,1}.Time, member.LeverPosition{1,1}.Data)
        case "valve1"
            plot(ax2, member.LeverPosition{1,1}.Time, member.LeverPosition{1,1}.Data)
        case "valve2"
            plot(ax3, member.LeverPosition{1,1}.Time, member.LeverPosition{1,1}.Data)
        case "damp_small_bot"
            plot(ax4, member.LeverPosition{1,1}.Time, member.LeverPosition{1,1}.Data)
        case "damp_small_up"
            plot(ax5, member.LeverPosition{1,1}.Time, member.LeverPosition{1,1}.Data)
    end
end

