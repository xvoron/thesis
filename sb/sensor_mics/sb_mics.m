function [datastore] = sb_mics(datastore, flag)
    if flag == "init"
        datastore.DataVariables = [
                                   "MIC_uBumper"; ... 
                                   "MIC_bBumper"; ...
                                   "MIC_Ambient"; ... 
                                   ];

        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];


        datastore.SelectedVariables = ["Label"; ...
                                       "MIC_uBumper"; ... 
                                       "MIC_bBumper"; ...
                                       "MIC_Ambient"; ... 
                                        ];

    elseif flag == "signals"
        datastore.DataVariables = [
                                   "MIC_uBumper"; ... 
                                   "MIC_bBumper"; ...
                                   "MIC_Ambient"; ... 
                                   "MIC_uBumper_ps"; ... 
                                   "MIC_bBumper_ps"; ...
                                   "MIC_Ambient_ps"; ...
                                   ];

        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];


        datastore.SelectedVariables = ["Label"; ...
                                       "MIC_uBumper"; ... 
                                       "MIC_bBumper"; ...
                                       "MIC_Ambient"; ... 
                                       "MIC_uBumper_ps"; ... 
                                       "MIC_bBumper_ps"; ...
                                       "MIC_Ambient_ps"; ...
                                        ];

    elseif flag == "features"
        datastore.DataVariables = [
                                   "MIC_uBumper_stats"; ... 
                                   "MIC_bBumper_stats"; ...
                                   "MIC_Ambient_stats"; ...
                                   "MIC_uBumper_ps_spec"; ... 
                                   "MIC_bBumper_ps_spec"; ... 
                                   "MIC_Ambient_ps_spec"; ...
                                   ];

        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];

        datastore.SelectedVariables = ["Label"; ...
                                       "MIC_uBumper_stats"; ... 
                                       "MIC_bBumper_stats"; ...
                                       "MIC_Ambient_stats"; ...
                                       "MIC_uBumper_ps_spec"; ... 
                                       "MIC_bBumper_ps_spec"; ... 
                                       "MIC_Ambient_ps_spec"; ...
                                        ];

    elseif flag == "featuretable"
        featuretable = load('encoder_features.mat');
        datastore = featuretable;

    elseif flag == "both"
        datastore.DataVariables = ["MIC_uBumper"; ... 
                                   "MIC_bBumper"; ...
                                   "MIC_Ambient"; ... 
                                   "MIC_uBumper_stats"; ... 
                                   "MIC_bBumper_stats"; ...
                                   "MIC_Ambient_stats"; ...
                                   "MIC_uBumper_ps"; ... 
                                   "MIC_bBumper_ps"; ...
                                   "MIC_Ambient_ps"; ...
                                   "MIC_uBumper_ps_spec"; ... 
                                   "MIC_bBumper_ps_spec"; ... 
                                   "MIC_Ambient_ps_spec"; ...
                                   ];

        datastore.ConditionVariables = ["FaultCode"; ...
                                        "Label"; ...
                                        ];

        datastore.SelectedVariables = ["Label"; ...
                                       "MIC_uBumper"; ... 
                                       "MIC_bBumper"; ...
                                       "MIC_Ambient"; ... 
                                       "MIC_uBumper_stats"; ... 
                                       "MIC_bBumper_stats"; ...
                                       "MIC_Ambient_stats"; ...
                                       "MIC_uBumper_ps"; ... 
                                       "MIC_bBumper_ps"; ...
                                       "MIC_Ambient_ps"; ...
                                       "MIC_uBumper_ps_spec"; ... 
                                       "MIC_bBumper_ps_spec"; ... 
                                       "MIC_Ambient_ps_spec"; ...
                                        ];

    else
        disp("Add parameter flag = init, signals, features, both, featuretable \n return datastore, but if featuretable is set return will be featuretable");
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
