%title Using Simulink to Generate Fault Data

= Contents =
    - [[#Useful|Useful]]
    - [[#Fault-Healthy data|Fault-Healthy data]]
    - [[#Source|Source]]

= Useful =
{{{matlab
mdl = 'model_name'
open_system([mdl, '/Component']) % Component is the subsystem of model
}}}

= Fault-Healthy data =
Code example to generate input data to simulate fault and healthy data.

{{{matlab
toothFaultArray = -2:2/10:0; % Tooth fault gain values
sensorDriftArray = -1:0.5:1; % Sensor drift offset values
shaftWearArray = [0 -1];       % Variants available for drive shaft conditions

% Create an n-dimensional array with combinations of all values
[toothFaultValues,sensorDriftValues,shaftWearValues] = ...
    ndgrid(toothFaultArray,sensorDriftArray,shaftWearArray);

for ct = numel(toothFaultValues):-1:1
    % Create a Simulink.SimulationInput for each combination of values
    siminput = Simulink.SimulationInput(mdl);
    
    % Modify model parameters
    siminput = setVariable(siminput,'ToothFaultGain',toothFaultValues(ct));
    siminput = setVariable(siminput,'SDrift',sensorDriftValues(ct));
    siminput = setVariable(siminput,'ShaftWear',shaftWearValues(ct));
    
    % Collect the simulation input in an array
    gridSimulationInput(ct) = siminput;
end

% Save generated data
mkdir Data
location = fullfile(pwd, 'Data');
[status, E] = generateSimulationEnsemble(gridSimulationInput, location)

% Import previus simulated ensemble
ensemble = simulationEnsembleDatastore(location)
% saw variables:
ensemble.DataVariables
ensemble.SelectedVariables

% data from ensemble for processing
ensemble.SelectedVariables = ["Varibles of interest"];
data = read(ensemble);
variable = data.Varible{1};
plot(variable.Time, variable.Data)
title('Data ploting')

}}}

Or you can create a combinations of faults.

= Source = 
[[https://www.mathworks.com/help/predmaint/ug/Use-Simulink-to-Generate-Fault-Data.html]]
