
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
