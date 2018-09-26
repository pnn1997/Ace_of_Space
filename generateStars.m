function [x y] = generateStars(n)
%generateStars creates n stars with random x and y coordinates between the
%limits set by L
%   Inputs:
%   n = the number of stars to be generated
%   x = vector containing the x coordinates for all the stars
%   y = vector containing the y coordinates for all the stars
    global L %Declares global variable L containing the limits of the graph
    %Creates horizontal vectors of length n with random elements between
    %the limits set by L for the x and y coordinates
    x = randi([L(1),L(2)],1,n); 
    y = randi([L(3),L(4)],1,n);
end

