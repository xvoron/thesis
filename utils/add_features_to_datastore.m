function [datastore, feauture_names] = add_features_to_datastore(datastore, features)
feature_names = [];
for feat = features.Properties.VariableNames
    for var = datastore.DataVariables
        if ~strcmp(feat{1}, var)
            datastore.DataVariables = [datastore.DataVariables; feat{1}];
            feature_names = [feature_names, feat{1}];
        end
    end
end
end

