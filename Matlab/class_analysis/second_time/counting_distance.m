function res = counting_distance(matrix)
    res = 0;
    n = length(matrix);
    for i = 1 : n
        for j = 1: i
            res = res + matrix(i,j);
        end
    end
    res = res / sqrt(n);
end