classdef hitbox
    %hitbox class
    %   Defines the boundaries associated with the hitbox class
    
    properties
        %Defines the left, right, top, and bottom boundaries. The corners
        %and center of the hitbox can easily be found given these four
        %properties
        leftBound %left boundary
        rightBound %right boundary
        botBound %bottom boundary
        topBound %top boundary
    end
    
    methods
        %Constructor to easily create a hitbox
        function obj=hitbox(l,r,b,t)
        %Constructor method for the Hitbox class
        %   Inputs:
        %   l = left bound of the hitbox
        %   r = right bound of the hitbox
        %   t = top bound of the hitbox
        %   b = bottom bound of the hitbox
        %   Outputs:
        %   obj = the corresponding hitbox object created with the given
        %       properties
            obj.leftBound = l;
            obj.rightBound = r;
            obj.topBound = t;
            obj.botBound = b;
        end  
    end
end

