%title Data Ensembles for Condition Monitoring and Predictive Maintenance
:data4pm:dataset:

= Contents =
    - [[#Intro|Intro]]
    - [[#Data Ensembles|Data Ensembles]]
        - [[#Data Ensembles#Ensemble Variables|Ensemble Variables]]
        - [[#Data Ensembles#Reading measured data|Reading measured data]]
        - [[#Data Ensembles#Commands|Commands]]



= Intro =
PM Toolbox provides tool *ensemble datastores* for creating, labeling and
managing data.

Requirements data types:
1. Normal system operation
2. The system operating in fault condition
3. Lifetime record of system operation (run-to-failure data)

Can be generated using Simulink.

= Data Ensembles = 
Data are stored in ensemble datasets, that's look like this:

| ID | Vibration | Tachometer | Age   |
|----|-----------|------------|-------|
| 01 | [ts data] | [ts data]  | 9.500 |

Failure data can be generated from Simulink models by:
1. Changing parameters
2. Injecting signal faults to sensors (offset, noise, disturbance)
3. Vary system dynamics

For different failure source we can create a new row
| ID | Vibration | Tachometer | Age   | Sensor Drift |
|----|-----------|------------|-------|--------------|
| 01 | [ts data] | [ts data]  | 9.500 | 0.1          |

== Ensemble Variables ==

There are different type of data that can be stored:
1. Data variables (normal time-series data, or some statistical features)
2. Independent variables (some parameters that identify your system)
3. Condition variables (fault state)

== Reading measured data ==

{{{matlab
% For reading from data 
datastore = fileEnsembleDatastore(location, extention)
}}}

== Ensemble properties ==
- ReadSize: how many members at one read command


== Commands ==
{{{matlab
generateSimulationEnsemble  % help to generate dataset

%% object, that manage data generated from a simulink using 
% generateSimulinkEnsemble
simulationEnsembleDatastore 

%% object, that manage any other ensemble data stored on disk
fileEnsembleDatastore

data = read(ensemble);  % read some data from ensemble object

% write data to last readed variable
newdata= table(data2write, 'VariableNames', {'Variable Name'})
writeToLastMemberRead(ensemble, newdata)

%% usefull commands for PM Toolbox
hasdata         % Determine if datastore has unreaded data (while hasdata())
reset           % reset to 1st data member
tall            % create a long table
progress        % how many members are readed (in %)
partition       % partition for parallel computing
numpartitions   % number of datastore partition


%% Read and write functions
ensemble.ReadFnc = @readfunc
ensemble.WriteToMemberFnc = @write2


}}}


= Source =
[[https://www.mathworks.com/help/predmaint/ug/data-ensembles-for-condition-monitoring-and-predictive-maintenance.html]]
