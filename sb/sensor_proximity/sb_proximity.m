function [datastore] = sb_proximity(datastore, flag)
    if flag == "init"
        datastore.DataVariables = [
                                    "ProximitySensor_bottom"; ...
                                    "ProximitySensor_upper"; ...
                                   ];

        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];

        datastore.SelectedVariables = ["Label"; ...
                                       "ProximitySensor_bottom"; ...
                                       "ProximitySensor_upper"; ...
                                        ];

    elseif flag == "signals"
        datastore.DataVariables = [
                                    "ProximitySensor_bottom"; ...
                                    "ProximitySensor_upper"; ...
                                   ];

        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];

        datastore.SelectedVariables = ["Label"; ...
                                       "ProximitySensor_bottom"; ...
                                       "ProximitySensor_upper"; ...
                                        ];

    elseif flag == "features"
        datastore.DataVariables = [
                                    "ProximitySensor_bottom_stats"; ...
                                    "ProximitySensor_upper_stats"; ...
                                   ];

        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];

        datastore.SelectedVariables = ["Label"; ...
                                       "ProximitySensor_bottom_stats"; ...
                                       "ProximitySensor_upper_stats"; ...
                                        ];

    elseif flag == "featuretable"
        featuretable = load('proximity_features.mat');
        datastore = featuretable;

    elseif flag == "both"
        datastore.DataVariables = [
                                    "ProximitySensor_bottom"; ...
                                    "ProximitySensor_upper"; ...
                                    "ProximitySensor_bottom_stats"; ...
                                    "ProximitySensor_upper_stats"; ...
                                   ];

        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];

        datastore.SelectedVariables = ["Label"; ...
                                       "ProximitySensor_bottom"; ...
                                       "ProximitySensor_upper"; ...
                                       "ProximitySensor_bottom_stats"; ...
                                       "ProximitySensor_upper_stats"; ...
                                        ];

    else
        disp("Add parameter flag = signals, features, both, featuretable \n return datastore, but if featuretable is set return will be featuretable");
    end
    datastore.IndependentVariables = [
                                    "ThrottleValve1"; ...
                                    "ThrottleValve2"; ...
                                    "SmallDamper_upper"; ...
                                    "LargeDamper_upper"; ...
                                    "SmallDamper_bottom"; ...
                                    "LargeDamper_bottom";
                                    "Settings.Load"];

end