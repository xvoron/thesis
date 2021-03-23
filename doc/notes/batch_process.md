%title Batch-process data from all ensemble members

For processing all data we can use following code:
{{{matlab
reset(ensemble)
while hasdata(ensemble)
    data = read(ensemble);
    acc_data = data.acc{1};
    sr = data.sr;
    [pdata, fpdata] = pspectrum(acc_data, sr);
    writeToLastMemberRead(ensemble, 'freq', fpdata, 'spect', pdata)
end
}}}

But better to use parallel computing toolbox.
