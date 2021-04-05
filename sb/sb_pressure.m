

addpath('../utils/');
addpath('./utils/');
addpath('../utils/preprocessing/');

path2data_converted = '../data/data11/*.mat';
loc_files = fullfile(path2data_converted);
ext_files = ".mat";

% Create and configure Ensemble datastore
datastore = fileEnsembleDatastore(loc_files, ext_files);

datastore.ReadFcn = @readData;

datastore.DataVariables = ["AirPressure"; ...
                           "AirPressure_preproces"; ...
                           ];

datastore.ConditionVariables = ["FaultCode"; ...
                                "Label"; ...
                                "ThrottleValve1"; ...
                                "ThrottleValve2"; ...
                                "SmallDamper_upper"; ...
                                "LargeDamper_upper"; ...
                                "SmallDamper_bottom"; ...
                                "LargeDamper_bottom";
                                "Settings.Load"];

datastore.IndependentVariables = ["Temp_Cylinder"; ...
                                  "Temp_Ambient"; ...
                                  ];

datastore.SelectedVariables = ["Label"; ...
                               "AirPressure"; ...
                               "AirPressure_preproces"; ...
                               ];


datastore.WriteToMemberFcn = @writeData;
clear loc_files ext_files path2data_converted
disp("Datastore import - done");

%% 3. Preprocess Data
preprocessFlag = false;
runParallel = false;

if preprocessFlag
    tic
    datastore.DataVariables = [datastore.DataVariables; "AirPressure_preproces"];
    datastore.SelectedVariables = ["AirPressure"];
    reset(datastore);
    if runParallel
        n = numpartitions(datastore, gcp);
        parfor ct = 1:n
            subdatastore = partition(datastore, n, ct);
            while hasdata(subdatastore)
                member = read(subdatastore);
                air = member.AirPressure;
                air.Data = preprocess_AirPressure(air.Data, seconds(air.Time));
                add_data = table({air}, 'VariableNames', {'AirPressure_preproces'});
                writeToLastMemberRead(subdatastore, add_data);
            end
        end
    else          
        while hasdata(datastore)
            member = read(datastore);
            air = member.AirPressure{1,1};
            air.Data = preprocess_AirPressure(air.Data, seconds(air.Time));
            add_data = table({air}, 'VariableNames', {'AirPressure_preproces'});
            writeToLastMemberRead(datastore, add_data);
            disp(string(progress(datastore)*100) + "% Done");
        end
    end
    disp("Preprocessing - done");
    toc
else
    disp("Signals have been preprocessed before"); 
end
