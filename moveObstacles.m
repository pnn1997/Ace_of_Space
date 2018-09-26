function moveObstacles(x,y)
%moveObstacles updates all the obstacles located in the obstacles array
%   Inputs:
%   x = units to move the obstacles horizontally
%   y = units to move the obstacles vertically
%   Outputs: none

    global obstacles    %Refers to the global array of obstacle hitboxes
    global collectibles %Refers to the global array of collectible hitboxes
    for i = 1:length(obstacles)
        obstacles(i)=move(obstacles(i),x,y);
    end
    for i = 1:length(collectibles)
        collectibles(i)=move(collectibles(i),x,y);
    end
end

