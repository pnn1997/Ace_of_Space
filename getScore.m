function score = getScore()
%getScore returns the current score given the current frame
%   Inputs: none
%   Outputs:
%   score = the player's current score
    
    global frame %Global variables used in this function
    global bonusPoints
    
    %Calculates the score
    score = bonusPoints + frame-1;
end

