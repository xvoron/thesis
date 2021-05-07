
for j = 1:100

C_leak_values = linspace(1e-5, 1+(9-1)*rand*1e-3, (100+100*rand));
C_leak_values = C_leak_values.^2 + rand*C_leak_values.^3;

hold on
for i = 1:numel(C_leak_values)
    C_leak_values(i) = C_leak_values(i) + rand*0.1*C_leak_values(i);   
end
plot(C_leak_values)
numel(C_leak_values)
max(C_leak_values)
end


% pos = regexp(train_data.Properties.VariableNames, 'LeverPosition_stats\/[a-zA-z]*');
% var = ~cellfun('isempty', pos);
% pos_rul_features = train_data(:,["Time" "Id" train_data.Properties.VariableNames(var)])
% 
% f_max = max(pos_rul_features.("LeverPosition_stats/RMS"))
% f_min = min(pos_rul_features.("LeverPosition_stats/RMS"))
% k = (f_max - f_min)
% k = 2/k
% id0 = pos_rul_features(pos_rul_features.Id==0,["Time", "LeverPosition_stats/RMS"])