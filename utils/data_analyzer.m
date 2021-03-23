function [statistics] = data_analyzer(data)
time = data.Time;
data = data.Data;
dt = time(end)/length(seconds(time));

d_mean = mean(data);

d_median = median(data);

d_rms = rms(data);

d_var = var(data);

d_max = max(data);

d_peak2peak = peak2peak(data);

d_skewness = skewness(data);

d_kurtosis = kurtosis(data);

d_crest_factor = peak2rms(data);

d_mad = mad(data);

d_cumsum = cumsum(data);

d_range_cumsum = max(d_cumsum) - min(d_cumsum);

% Not working
d_corr_dim = correlationDimension(data);

d_approx_entrop = approximateEntropy(data);

d_lyap_exp = lyapunovExponent(data, 1/seconds(dt));


names = {...
    'Mean', ...
    'Median', ...
    'RMS', ...
    'Var', ...
    'Max', ...
    'Peak2Peak', ...
    'Skewness', ...
    'Kurtosis', ...
    'CrestFactor', ...
    'MAD', ...
    'RangeCumSum', ...
    'CorrelationDimension', ...
    'ApproxEntropy', ...
    'LyapExponent'};

statistics = table(...
    d_mean, ... 
    d_median, ...
    d_rms, ...
    d_var, ...
    d_max, ...
    d_peak2peak, ...
    d_skewness, ...
    d_kurtosis, ...
    d_crest_factor, ...
    d_mad, ...
    d_range_cumsum, ...
    d_corr_dim, ...
    d_approx_entrop, ...
    d_lyap_exp, ...
    'VariableNames', names);
end
