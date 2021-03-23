function [fft_freq, fft_val, fft_phase] = pm_fft(signal)
    time = seconds(signal.Time);
    val = signal.Data;
    fs = length(time)/time(end);
    y = fft(val);
    y = abs(y);
    fft_val = y(1:length(y)/2+1);
    fft_phase = phase(y);
    fft_phase = fft_phase(1:length(fft_phase)/2+1);
    fft_freq = linspace(0, fs/2, length(fft_val));
end

