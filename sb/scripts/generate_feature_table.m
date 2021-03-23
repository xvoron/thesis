function [feature_table] = generate_feature_table(datastore, selected_features)
variables = datastore.SelectedVariable;
member_num = datastore.NumMembers;
reset(datasore);
%feature_table = table('Size', [member_num, variables*numel(selected_features)]);
for var = datastore.SelectedVariable
    
end
end

