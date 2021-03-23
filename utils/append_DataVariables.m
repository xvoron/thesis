function [var_names] = append_DataVariables(variables)
var_names = [];
for var = variables
    var_names = [var_names, var + "_stats"];
end

