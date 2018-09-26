function newHBox = move(HB,x,y)
%move shifts the hitboxes x units right and y units up
%   Inputs:
%   HB = hitbox to be shifted
%   x = number of units to shift right
%   y = number of units to shift up
    newHBox = hitbox(HB.leftBound+x,HB.rightBound+x,HB.botBound+y,HB.topBound+y);
    
end