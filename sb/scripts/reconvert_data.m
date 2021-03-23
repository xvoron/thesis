function [] = reconvert_data(path, ident)
%delete ./data_converted/*

files = dir(path);

for k = 1:(numel(files))
    data_table = load(files(k).folder + "/" + string(files(k).name)).pTable;
    for j = 1:(numel(data_table(:,1)))
        data = data_table(j,:);
        file = './data_converted/data'+string(ident)+'_'+string(k)+'_'+string(j)+'.mat';
        save(file, 'data')
    end
    clear data_table data
end
end
