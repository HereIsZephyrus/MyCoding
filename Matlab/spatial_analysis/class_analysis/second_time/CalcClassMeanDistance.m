function res = CalcClassMeanDistance(dis,class)
    meanDistance = zeros(1,3);
    memberID = find(class == "114221");
    meanDistance(1) = counting_distance(dis(memberID,memberID));
    memberID = find(class == "114222");
    meanDistance(2) = counting_distance(dis(memberID,memberID));
    memberID = [find(class == "220221");find(class == "220222")];
    meanDistance(3) = counting_distance(dis(memberID,memberID));
    res = meanDistance;
end