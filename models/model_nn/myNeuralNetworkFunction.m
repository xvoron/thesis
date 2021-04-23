function [y1,xf1,xf2] = myNeuralNetworkFunction(x1,x2,xi1,xi2)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Auto-generated by MATLAB, 23-Apr-2021 18:00:36.
%
% [y1,xf1,xf2] = myNeuralNetworkFunction(x1,x2,xi1,xi2) takes these arguments:
%   x1 = 1xTS matrix, input #1
%   x2 = 3xTS matrix, input #2
%   xi1 = 1x2 matrix, initial 2 delay states for input #1.
%   xi2 = 3x2 matrix, initial 2 delay states for input #2.
% and returns:
%   y1 = 3xTS matrix, output #1
%   xf1 = 1x2 matrix, final 2 delay states for input #1.
%   xf2 = 3x2 matrix, final 2 delay states for input #2.
% where TS is the number of timesteps.

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = 0;
x1_step1.gain = 2;
x1_step1.ymin = -1;

% Input 2
x2_step1.xoffset = [0;-0.595569808690427;-0.00103110761531111];
x2_step1.gain = [10.3188359063243;2.04397022129376;1100.01490678172];
x2_step1.ymin = -1;

% Layer 1
b1 = [1.8684744266380444166;0.24509333226880672396;0.16503623444722584357;-0.93639618009823899492;-1.5011508766058663245;-0.5662753758853875663;0.48577714661294751908;-0.87829489979038688485;0.81055180128628023795;-2.0171118472276519107];
IW1_1 = [0.037025358886913412038 0.26640425719841775987;0.6512651006574389223 -0.77799043737325312975;-0.10818325541364530451 0.098403694325751259186;0.84333173632489621951 -0.54591740637134200664;0.38357631135906206099 0.35831060688593446839;0.46390359909273115591 -0.31396881962276596001;-0.0053463998824161713258 0.00227249762132266395;-0.0073881765039018046023 0.0070051411462572548902;0.32958290049796212795 -0.15785101385121730333;-0.006196816460174667425 0.020849498511294521641];
IW1_2 = [-0.9848459742739873457 1.3472855190290200511 0.21450446846488227526 0.10095186197141589601 -0.3178082309197153843 0.28950631686624889172;-0.072186018990430728115 -0.97165606184592823169 0.43631775117065263458 -0.74653761417939668021 -1.1730079518156100171 0.23027514913401825325;1.0573850446321322316 0.56475288596269457297 -0.34063769573158531045 -1.0283606179471693753 -0.32497726021312162148 -0.15834537296500969528;-0.008193081835214334821 1.0576539304266743269 -0.066391509791073721747 -0.77763711582816830159 0.17209927012866399476 -0.032670638373054658454;-0.7741012768365472807 0.97258600256385074889 0.21009702764048501789 -0.75517550132621524828 0.87061850215850888901 0.06414860556899816546;-0.56139224472433035817 1.2337009569777379614 -0.10619674954545688106 0.12428164609387874762 -0.29119346627432252106 -0.0213830585086521828;0.06872117563221318004 -0.0079374490857396385463 0.0025729307098892890276 -0.4105709750581021944 -0.0023637446063557066185 -0.00063164977890258139966;-0.56073343778951123539 -0.033637800414771851232 0.01277697392820292821 -0.0082008187066702660506 0.0054107604972339524985 0.0064687905854806208861;-0.53310482558294502997 -1.0577652436201516739 0.16566242642681394681 0.20995723684247577512 0.9475332043428693618 0.12140205802471268348;-0.21671519858264146063 -3.0510046488381119545 0.22921892051417297465 -0.33889616595451177439 1.953129638165072679 0.28677341539191814057];

% Layer 2
b2 = [0.53184194905823456434;-0.097623650491094018933;1.130108045652858495];
LW2_1 = [-0.01453507700787808575 -3.6730762890347799961e-05 -0.037696116382182794091 -0.0102995534520001885 0.0047762735094112260259 -0.017273237975098120617 -2.5968253057768633241 -0.97193316899534376585 -0.037534995170382154384 0.016627768543438933846;0.38167878965411189407 -0.13393715864161659379 -0.80782199212245164865 -1.1612161350519685232 0.13480650591528989257 2.060660098838662968 -0.33042107009779320137 0.37624492660318537007 -1.1306788857446605778 -1.4235474356662793927;0.12014966582659042382 -0.38868247918673953789 -2.5158781364800164582 0.3600863804192197537 -0.20555212381133627919 -0.063741402848335459996 0.50412547855757350312 0.26772954846806684692 -0.46996797753807412201 0.47758867720948416924];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = [10.3188359063243;2.04397022129376;1100.01490678172];
y1_step1.xoffset = [0;-0.595569808690427;-0.00103110761531111];

% ===== SIMULATION ========

% Dimensions
TS = size(x1,2); % timesteps

% Input 1 Delay States
xd1 = mapminmax_apply(xi1,x1_step1);
xd1 = [xd1 zeros(1,1)];

% Input 2 Delay States
xd2 = mapminmax_apply(xi2,x2_step1);
xd2 = [xd2 zeros(3,1)];

% Allocate Outputs
y1 = zeros(3,TS);

% Time loop
for ts=1:TS
    
    % Rotating delay state position
    xdts = mod(ts+1,3)+1;
    
    % Input 1
    xd1(:,xdts) = mapminmax_apply(x1(:,ts),x1_step1);
    
    % Input 2
    xd2(:,xdts) = mapminmax_apply(x2(:,ts),x2_step1);
    
    % Layer 1
    tapdelay1 = reshape(xd1(:,mod(xdts-[1 2]-1,3)+1),2,1);
    tapdelay2 = reshape(xd2(:,mod(xdts-[1 2]-1,3)+1),6,1);
    a1 = tansig_apply(b1 + IW1_1*tapdelay1 + IW1_2*tapdelay2);
    
    % Layer 2
    a2 = b2 + LW2_1*a1;
    
    % Output 1
    y1(:,ts) = mapminmax_reverse(a2,y1_step1);
end

% Final delay states
finalxts = TS+(1: 2);
xits = finalxts(finalxts<=2);
xts = finalxts(finalxts>2)-2;
xf1 = [xi1(:,xits) x1(:,xts)];
xf2 = [xi2(:,xits) x2(:,xts)];
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
x = bsxfun(@minus,y,settings.ymin);
x = bsxfun(@rdivide,x,settings.gain);
x = bsxfun(@plus,x,settings.xoffset);
end
