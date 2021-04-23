clc;clear all;close all;
addpath('../utils/');
addpath('../');
%run params.m;
data1 = load('data/data11_1_1.mat');


[f_code1,t,i_in_u1_1,i_in_u1_2,i_out_x1,i_out_dx1,i_out_f1]=extract_signals4identification(data1);

u1 = i_in_u1_1(:,2);
u2 = i_in_u1_2(:,2);

i_u = u2 - u1;
x = i_out_x1(:,2);
clear data1
Ts = 1e-3;

data_x = iddata(x, i_u, Ts);

figure
plot(data_x)


%%
opt = oeOptions('Focus','simulation');
LinearModel = oe(data_x,[3 2 2],opt);
compare(data_x, LinearModel)
getpvec(LinearModel)
NonlinearModel = nlhw(data_x, LinearModel, [], 'saturation');
compare(data_x, NonlinearModel)

polydata(NonlinearModel.LinearModel)
getpvec(NonlinearModel.LinearModel)
getcov(NonlinearModel.LinearModel)

%% 
dx = i_out_dx1(:,2);
data_dx = iddata(dx, i_u, Ts);

figure
plot(data_dx)

opt = oeOptions('Focus','simulation');
LinearModel = oe(data_dx,[3 2 2],opt);
compare(data_dx, LinearModel)

NonlinearModel = nlhw(data_dx, LinearModel, [], 'saturation');
compare(data_dx, NonlinearModel)


%%
na = 1;
nb = 2;
nk = 1;

Estimator = recursiveARX([na nb nk]);
Estimator.EstimationMethod = 'NormalizedGradient';
Estimator.AdaptationGain = .9;
Output = data_x.OutputData; 
Input = data_x.InputData; 
t = data_x.SamplingInstants;
N = length(t);

%% Initialize plot
Colors = {'r','g','b'};
ax = gca;
cla(ax)
for k = 3:-1:1
   h(k) = animatedline('Color',Colors{k}); % lines for a, b1 and b2 parameters
end
h(4) =  animatedline('Marker','.','Color',[0 0 0]); % line for L
legend({'a','b1','b2','Deviation'},'location','southeast')
title('ARX Recursive Parameter Estimation')
xlabel('Time (seconds)')
ylabel('Parameter value')
ax.XLim = [t(1),t(end)];
ax.YLim = [-2, 2];
grid on
box on

%% Now perform recursive estimation and show results 
n0 = 6;
L = NaN(N,nk);
B_old = NaN(1,3);

for ct = 1:N
   [A,B] = step(Estimator,Output(ct),Input(ct)); 
   if ct>n0
      L(ct) = norm(B-B_old);
      B_old = B;
   end
   addpoints(h(1),t(ct),A(2))
   addpoints(h(2),t(ct),B(2))
   addpoints(h(3),t(ct),B(3))
   addpoints(h(4),t(ct),L(ct))
end

%%
oldInput = 0;
for i = 1:numel(Input)
    H = [Input(i) oldInput];
    [A,B, EstimatedOutput] = step(Estimator,Output(i),Input(i));
    estimatedOut(i)= EstimatedOutput;
    oldInput = Input(i);
end

numSample = 1:numel(Input);
plot(numSample, Output,'b',numSample, estimatedOut,'r--');
legend('Measured Output','Estimated Output');
