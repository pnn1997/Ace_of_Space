function createObstacle(xSize,ySize)
%createObstacle adds a new obstacle to the obstacles array when there are
%not too many obstacles
%   Inputs:
%   xSize = the width of the obstacle in the x direction
%   ySize = the height of the obstacle in the y direction
%   lag = the delay between each obstacle creation
%   Outputs: none

    global L obstacles maxNumObs obs_lag frame lowerBound upperBound  %Global Variables used in function
    global imageIndex imageArray       %Determines which image goes with each obstacle

    %Checks the first element of obstacles and deletes it if it is past the
    %left limit of the plot
    if length(obstacles) > 1
        if obstacles(1).rightBound < L(1)   %Obstacle is out of bounds
            obstacles(1) = [];              %Deletes the obstacle and 
                                            %updates obstacle order
                                                    
            %Updates imageIndex to account or the shifted obstacle order
            imageIndex(1) = [];                 %Deletes the first element of the index
            imageIndex(end+1) = ...             %Adds a random picture to the
             randi([1,length(imageArray)]);     %end of queue to be shown later      
        end
    end
    
    %Adds a new obstacle only if there are no more obstacles than maxObs
    %with specified lag between each obstacle
    if length(obstacles) <= maxNumObs && mod(frame,obs_lag) == 0
        %Randomly selects the position for the top boundary of the hitbox
        t = randi([round(lowerBound(L(2))+ySize),round(upperBound(L(2)))],1,1);   %Top bound
        b = t-ySize;                        %Bottom bound
        l = L(2);                           %Left bound
        r = l+xSize;                        %Right bound
        newObs = hitbox(l,r,b,t);           %Creates the hitbox for the new obstacle
        obstacles = [obstacles newObs];     %Adds newObs to obstacles array
    end
    
end


