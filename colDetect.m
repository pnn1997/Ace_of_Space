function collision = colDetect(entity1, entity2)
%colDetect determines if the two entities have overlapping hitboxes
%   Inputs:
%   entity1 = hitbox for the first entity
%   entity2 = hitbox for the second entity
%   Output:
%   collision = returns true if a collision occurs and false otherwise
    collision = true; %Base case
    %Case where one hitbox is completely above the other
    if entity1.topBound < entity2.botBound || entity2.topBound < entity1.botBound
        collision = false;
    end
    %Case where one hitbox is to the left or right of the other
    if entity1.rightBound < entity2.leftBound || entity2.rightBound < entity1.leftBound
        collision = false;
    end

end

