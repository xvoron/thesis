function writeData(filename, data_write)
data_write = struct2table(data_write, 'AsArray', 1);
data = load(filename).data;

for i = data_write.Properties.VariableNames
    for j = data.Properties.VariableNames
        if strcmp(i,j)
            data = removevars(data, j);
        end
    end
end

data = [data, data_write];
save(filename, 'data');
end