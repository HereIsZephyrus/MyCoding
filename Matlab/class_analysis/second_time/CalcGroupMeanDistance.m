function res = CalcGroupMeanDistance(dis,group)
    groupNum = 26;
    count = 0;
    meanDistance = [];
    for i = 1 : groupNum
        memberID = find(group == i);
        if (length(memberID) < 2 )
            continue;
        end
        count = count  + 1;
        meanDistance(count) = counting_distance(dis(memberID,memberID));
    end
    clear count i
    res = meanDistance;
end