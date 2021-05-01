function [datastore] = sb_flow(datastore, flag)
    if flag == "init"
        datastore.DataVariables = [
                                    "FlowContraction"; ...
                                    "FlowExtrusion"; ...
                                   ];
                               
        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];


        datastore.SelectedVariables = ["Label"; ...
                                        "FlowContraction"; ...
                                        "FlowExtrusion"; ...
                                        ];
        
    elseif flag == "signals"
        datastore.DataVariables = [
                                    "FlowContraction"; ...
                                    "FlowContraction_ps"; ...
                                    "FlowExtrusion"; ...
                                    "FlowExtrusion_ps"; ...
                                   ];
                               
        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];


        datastore.SelectedVariables = ["Label"; ...
                                        "FlowContraction"; ...
                                        "FlowContraction_ps"; ...
                                        "FlowExtrusion"; ...
                                        "FlowExtrusion_ps"; ...
                                        ];

    elseif flag == "features"
        datastore.DataVariables = [
                                    "FlowContraction_stats"; ...
                                    "FlowExtrusion_stats"; ...
                                    "FlowContraction_ps_spec"; ...
                                    "FlowExtrusion_ps_spec"; ...
                                   ];

        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];


        datastore.SelectedVariables = ["Label"; ...
                                        "FlowContraction_ps_spec"; ...
                                        "FlowContraction_stats"; ...
                                        "FlowExtrusion_stats"; ...
                                        "FlowExtrusion_ps_spec"; ...
                                        ];

    elseif flag == "featuretable"
        featuretable = load('flow_features.mat');
        datastore = featuretable;

    elseif flag == "both"
        datastore.DataVariables = [
                                    "FlowContraction"; ...
                                    "FlowContraction_ps"; ...
                                    "FlowContraction_ps_spec"; ...
                                    "FlowContraction_stats"; ...
                                    "FlowExtrusion"; ...
                                    "FlowExtrusion_stats"; ...
                                    "FlowExtrusion_ps"; ...
                                    "FlowExtrusion_ps_spec"; ...
                                   ];

        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];

        datastore.SelectedVariables = ["Label"; ...
                                        "FlowContraction"; ...
                                        "FlowContraction_ps"; ...
                                        "FlowContraction_ps_spec"; ...
                                        "FlowContraction_stats"; ...
                                        "FlowExtrusion"; ...
                                        "FlowExtrusion_stats"; ...
                                        "FlowExtrusion_ps"; ...
                                        "FlowExtrusion_ps_spec"; ...
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
