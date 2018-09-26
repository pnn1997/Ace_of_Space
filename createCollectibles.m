function createCollectibles(xSize,ySize)
%createCollectibles adds a new collectible to the collectibles array when there are
%not too many collectibles
%   Inputs:
%   xSize = the width of the collectible in the x direction
%   ySize = the height of the collectible in the y direction
%   lag = the delay between each collectible creation
%   Outputs: none

    global L collectibles obs_lag frame lowerBound upperBound  %Global Variables used in function
    global imageIndexCollect imageArrayCollect       %Determines which image goes with each obstacle

    %Checks the first element of collectibles and deletes it if it is past the
    %left limit of the plot
    if length(collectibles) > 1
        if collectibles(1).rightBound < L(1)   %Obstacle is out of bounds
            collectibles(1) = [];              %Deletes the collectible and 
                                            %updates collectible order                 
            %Updates imageIndex to account or the shifted collectible order
            imageIndexCollect(1) = [];                 %Deletes the first element of the index
            imageIndexCollect(end+1) = ...             %Adds a random picture to the
             randi([1,length(imageArrayCollect)]);     %end of queue to be shown later      
        end
    end
    
    %Adds a new obstacle only if there are no more collectibles than maxObs
    %with specified lag between each obstacle
    if length(collectibles) <= 3 && mod(frame,obs_lag*2) == floor(obs_lag/2)
        %Randomly selects the position for the top boundary of the hitbox
        t = randi([round(lowerBound(L(2))+ySize),round(upperBound(L(2)))],1,1);   %Top bound
        b = t-ySize;                        %Bottom bound
        l = L(2);                           %Left bound set at far right boundary
        r = l+xSize;                        %Right bound
        newCol = hitbox(l,r,b,t);           %Creates the hitbox for the new collectible
        collectibles = [collectibles newCol];     %Adds newCol to collectibles array
    end
    
end

