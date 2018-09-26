function [x y] = getCenter(HB)
%getCenter calculates the center position of a given hitbox
%   Inputs:
%   HB = hitbox
%   Outputs:
%   x = x coordinate of the center
%   y = y coordinate of the center
    x = (HB.leftBound+HB.rightBound)/2;
    y = (HB.topBound+HB.botBound)/2;

end

