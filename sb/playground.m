
%%% Import feature table
%load('featuretable/encoder_features.mat');
%T = encoder_featrures(:, 1:5);
%P = T.Variables;
%R = T.Label;
%I = strcmp(R, 'health') | strcmp(R, 'valve1') | strcmp(R, 'valve2') | strcmp(R, "damp_small_bot") | strcmp(R, "damp_small_up");
%f = figure;
%gplotmatrix(str2double(P(I,2:end)),[],R(I))



%% Predicti:

predict = 0;
if predict
    reset(datastore);
    member = read(datastore);

    A = member.MIC_Ambient_stats{1,1}.SINAD;
    B = member.MIC_bBumper_ps_spec_1{1,1}.BandPower;
    C = member.MIC_bBumper_ps_spec_1{1,1}.PeakFreq1;
    D = member.MIC_bBumper_stats{1,1}.Mean;
    E = member.MIC_uBumper_ps_spec_1{1,1}.PeakAmp5;
    T = [A;B;C;D;E];
    variables = {'MIC_Ambient_stats/SINAD', ...
                 'MIC_bBumper_ps_spec_1/BandPower', ...
                 'MIC_bBumper_ps_spec_1/PeakFreq1', ...
                 'MIC_bBumper_stats/Mean', ...
                 'MIC_uBumper_ps_spec_1/PeakAmp5'};

    tab = table(A,B,C,D,E, 'VariableNames', variables)

end
