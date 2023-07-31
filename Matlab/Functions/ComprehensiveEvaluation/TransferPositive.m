function posed=TransferPositive(vec,type)
    % TransferPositive: Transfer the positive values of a vector to a new vector
    arguments 
        vec (:,1) double
        type (1,1) string {mustBeMember(type,["abs","opp","mid"])} = "abs"
     end
    switch type
        case "abs"
            posed=100/vec;
        case "opp"
            posed=1-vec;
        case "mid"
            posed=1/(vec-mid(vec));
    end
end