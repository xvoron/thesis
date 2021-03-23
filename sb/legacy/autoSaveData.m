function autoSaveData(pTable)
   FaultCode = string(pTable.FaultCode{1});
   NumOfCycles = string(size(pTable,1));
   filename = string(strcat('Data\',datestr(now,'yyyy_mm_dd_HH_MM'),'_faultCode_',FaultCode,'_',NumOfCycles,'x','.mat'));
   
   save(filename,'pTable')
   
end

