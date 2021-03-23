clc
clear all
close all

data1 = load('2020_11_27_11_17_faultCode_999_10x.mat').pTable;

outValveWP = data1.outValveWP{1,1}.Data;
LevelPosition = data1.LeverPosition{1,1}.Data;
FlowExtrusion = data1.FlowExtrusion{1,1}.Data;

u = outValveWP;
t = [LevelPosition, FlowExtrusion];

u = u';
t = t';

outValveWP_verif = data1.outValveWP{2,1}.Data;
LevelPosition_verif = data1.LeverPosition{2,1}.Data;
FlowExtrusion_verif = data1.FlowExtrusion{2,1}.Data;
u_verif = outValveWP_verif;
t_verif = [LevelPosition_verif, FlowExtrusion_verif];

u_verif = u_verif';
t_verif = t_verif';
%DisplayData(data1)

%%
X = u';
T = t';

[X, ~] = tonndata(X, 1, 0);
[T, ~] = tonndata(T, 1, 0);

X = tonndata(u_verif,false,false);
T = tonndata(t_verif,false,false);

%y_pos = zeros(1, length(y));
%y_flow = zeros(1, length(y));
%j = 1;
%for i = y
%    y_pos(j) = i{1,1}(1);
%    y_flow(j) = i{1,1}(2);
%    j = j + 1;
%end


net = narxnet();
[Xs, Xi, Ai, Ts] = preparets(net, X, {}, T);
net = train(net, Xs, Ts, Xi, Ai);
view(net);
Yopen = net(Xs, Xi, Ai);

net = closeloop(net);
view(net);
[Xs, Xi, Ai, Ts] = preparets(net, X, {}, T);
net = train(net, Xs, Ts, Xi, Ai);
Yclosed = net(Xs, Xi, Ai);

%Plot output with predicted output
%--------------------------------------------------------------------------
T=cell2mat(T);
Yopen=cell2mat(Yopen);
Yclosed=cell2mat(Yclosed);
figure;
t = t(3:end);
T = T(3:end);
plot(t,T,'b-',t,Yopen,'r--',t,Yclosed,'k-.'); xlabel('Time (sec)');  ylabel('DSP1');
legend('Actual','Predicted (openloop)','Predicted (closedloop)');


