function [x y] = drawHitbox(HB)
%drawHitbox returns the vector of x and y coordinates of the corners of the
%hitbox to be passed onto the plot
%   Inputs:
%   HB = hitbox to be drawn
%   Outputs:
%   x = vector of x coordinates
%   y = vector of y coordinates
    x = [HB.leftBound,HB.leftBound,HB.rightBound,HB.rightBound,HB.leftBound];
    y = [HB.botBound,HB.topBound,HB.topBound,HB.botBound,HB.botBound];
end

