function data_table = readData(filename,variables)
data_table = table();
mfile = load(filename).data; % Allows partial loading
for ct=1:numel(variables)
    val = mfile.(variables{ct});
    if numel(val) > 1
        val = {val};
    elseif variables{ct} == "FaultCode"
        val = string(val{1,1}.Variables);
    end
    data_table.(variables{ct}) = val;
end
end