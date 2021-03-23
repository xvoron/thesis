function [data] = resample_data(data, dt, time_start, time_end)
t = time_start:dt:time_end;
names = fieldnames(data);
for i = 1:numel(fieldnames(data))
    data.(string(names{i})) = resample(data.(string(names{i})), t);
end
