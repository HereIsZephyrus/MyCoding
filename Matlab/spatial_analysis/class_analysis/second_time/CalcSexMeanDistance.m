function res = CalcSexMeanDistance(dis,sex)
    meanDistance = zeros(1,2);
    memberID = find(sex == "男");
    meanDistance(1) = counting_distance(dis(memberID,memberID));
    memberID = find(sex == "女");
    meanDistance(2) = counting_distance(dis(memberID,memberID));
    res = meanDistance;
end