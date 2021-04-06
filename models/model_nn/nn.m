%%
run params3

sim("model.slx")
%%
t = ans.data.time;
x = ans.data.signals.values(:,2:end);
u = ans.data.signals.values(:,1);
%%
t = t';
X = u';
T = x';
%%
[X, ~] = tonndata(X, 1, 0);
[T, ~] = tonndata(T, 1, 0);
%%
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
