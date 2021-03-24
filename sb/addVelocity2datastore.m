function [] = addVelocity2datastore(datastore, runParallel)
%% addVelocity2datastore
% Description:
% 	Append velocity signal calculated from LeverPosition variable
% Content:
%	
%
% Author: Artyom Voronin
% Brno, 2021
addpath('../utils/')
h = 0.001; % Sample time

datastore.SelectedVariables = ["LeverPosition"];
datastore.DataVariables = [datastore.DataVariables; "LeverVelocity"];
reset(datastore);
tic
if runParallel
    n = numpartitions(datastore, gcp);
    parfor ct = 1:n
        subdatastore = partition(datastore, n, ct);
        while hasdata(subdatastore)
            member = read(subdatastore);
            LeverPosition = member.LeverPosition{1,1};
            LeverVelocity = LeverPosition;
            LeverVelocity.Data = [diff(LeverVelocity.Data)/h; 0];
            writeToLastMemberRead(subdatastore, 'LeverVelocity', LeverVelocity);
        end
    end
    
else  
    while hasdata(datastore)
        member = read(datastore);
        LeverPosition = member.LeverPosition{1,1};
        LeverVelocity = LeverPosition;
        LeverVelocity.Data = [diff(LeverVelocity.Data)/h; 0];
        writeToLastMemberRead(datastore, 'LeverVelocity', LeverVelocity);
        disp(string(progress(datastore)*100) + "% Done");
    end
end
disp("Add LeverVelocity - done");
toc

end
