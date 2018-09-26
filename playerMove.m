function [newPlayer,newV] = playerMove(player,v)
%copterMove returns the new position of the copter hitbox given the key
%input (up or down) and a gravitational constant g
%   Inputs:
%   player = hitbox of the player
%   v = current velocity of the player
%   key = input key from user
%   Outputs:
%   newPlayer = new hitbox position for the player
%   newV = new velocity after the key press

    global t    %Time delay set for whole game 
    global g a  %Acceleration from gravity and thruster acceleration
    global key  %Returns the current key pressed
    
    %Declares constants for which key has what value and distance each move
    %takes you as well as the acceleration associated using the thrusters
    upKey='w';downKey='s';maxV=70;
    
    %Sets dy and newV based on kinematic equation
    dy = v*t+0.5*g*t^2;
    newV = v+g*t;
    
    %Checks which key was pressed
    if isequal(upKey,key) %Up was pressed and cancels all downward velocity
        dy = dy+0.5*a*t^2;
        newV = newV+a*t;
    elseif isequal(downKey,key) %Down was pressed and adds downward velocity and distance
        dy = dy-0.5*a*t^2;
        newV = newV-a*t;
    end
    
    if newV > maxV
        newV = maxV;
    elseif newV < -maxV
        newV = -maxV;
    end
        
    %The hitbox moves up by dy units
    newPlayer = move(player, 0,dy);
    
end

