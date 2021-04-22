function [members] = extract_members(fault_codes, datastore)
% Extract signals from dataensemble
    members = [];
    for fault_code=fault_codes
        reset(datastore)
        while hasdata(datastore)
            member = read(datastore);
            if member.FaultCode{1,1} == fault_code
                members = [members, {member}];
                break;
            end
        end
    end
end