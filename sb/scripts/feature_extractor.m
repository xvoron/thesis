function [statistic_table] = feature_extractor(member)

statistic_table = table();
for varname = member.Properties.VariableNames
    analyzed_data = data_analyzer(member.(varname{1}){1});
    calculated_table = table(analyzed_data, ...
        'VariableNames', [string(varname{1}) + "_" + "Stat"]); 
    statistic_table = [statistic_table, calculated_table];
end
end
