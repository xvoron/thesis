%clc;clear all;close all;

%run sb/import_dataensemble.m
%%
f = figure;
f.Position(3:4) = [1000 500];
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

%%
f1 = figure;
f1.Position(3:4) = [1000 500];
hax1 = axes;
f2 = figure;
f2.Position(3:4) = [1000 500];
hax2 = axes;
hax2.XScale = 'log';
hax2.YScale = 'log';
xlim(hax1, [6,10])
hold(hax1, 'on');
hold(hax2, 'on');
title(hax1, 'Flow Signal in Different Operation Conditions');
title(hax2, 'PDS of Flow Signal in Different Operation Condtions');
xlabel(hax1, "Time (s)")
ylabel(hax1, "Flow (l/min)")
xlabel(hax2, "Frequency (Hz)")
ylabel(hax2, "Spectral Data")
grid(hax1, 'on')
grid(hax2, 'on')
L1 = plot(nan, nan, 'Color', '#0072BD');
L2 = plot(nan, nan, 'Color', '#D95319');
L3 = plot(nan, nan, 'Color', '#EDB120');
L4 = plot(nan, nan, 'Color', '#7E2F8E');
L5 = plot(nan, nan, 'Color', '#4DBEEE');
legend(hax1, [L1, L2, L3, L4, L5], {'health', 'valve1','valve2', 'damp_small_bot', 'damp_small_up'}, 'Interpreter', 'none', 'AutoUpdate', 'off')
legend(hax2, [L1, L2, L3, L4, L5], {'health', 'valve1','valve2', 'damp_small_bot', 'damp_small_up'}, 'Interpreter', 'none', 'AutoUpdate', 'off')


reset(datastore);
while hasdata(datastore)
    member = read(datastore);
    switch member.Label
        case "health"
            plot(hax1, member.FlowContraction{1,1}.Time, member.FlowContraction{1,1}.Data, 'Color', '#0072BD')
            loglog(hax2, member.FlowContraction_ps{1,1}.Frequency, member.FlowContraction_ps{1,1}.SpectrumData, 'Color', '#0072BD')
        case "valve1"
            plot(hax1, member.FlowContraction{1,1}.Time, member.FlowContraction{1,1}.Data, 'Color', '#D95319')
            loglog(hax2, member.FlowContraction_ps{1,1}.Frequency, member.FlowContraction_ps{1,1}.SpectrumData, 'Color', '#D95319')
        case "valve2"
            plot(hax1, member.FlowContraction{1,1}.Time, member.FlowContraction{1,1}.Data,'Color', '#EDB120')
            loglog(hax2, member.FlowContraction_ps{1,1}.Frequency, member.FlowContraction_ps{1,1}.SpectrumData, 'Color', '#EDB120')
        case "damp_small_bot"
            plot(hax1, member.FlowContraction{1,1}.Time, member.FlowContraction{1,1}.Data, 'Color', '#7E2F8E')
            semilogx(hax2, member.FlowContraction_ps{1,1}.Frequency, member.FlowContraction_ps{1,1}.SpectrumData, 'Color', '#7E2F8E')
        case "damp_small_up"
            plot(hax1, member.FlowContraction{1,1}.Time, member.FlowContraction{1,1}.Data, 'Color', '#4DBEEE')
            loglog(hax2, member.FlowContraction_ps{1,1}.Frequency, member.FlowContraction_ps{1,1}.SpectrumData, 'Color', '#4DBEEE')
    end
    disp(string(progress(datastore)*100) + "% Done");
end

