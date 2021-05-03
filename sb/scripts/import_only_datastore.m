function datastore = import_only_datastore(path2data)

    disp("Start importing")

    addpath('../utils/');
    addpath('../utils/preprocessing/');

    loc_files = fullfile(path2data);
    ext_files = ".mat";

    % Create and configure Ensemble datastore
    datastore = fileEnsembleDatastore(loc_files, ext_files);

    datastore.ReadFcn = @readData;
    datastore.WriteToMemberFcn = @writeData;

    disp("Datastore import - done");

end
