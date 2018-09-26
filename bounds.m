function bounds(smoothness)
%bounds updates the movable upper and lower bounds
%   Inputs:
%   smoothness = determines how often the bounds are updated, thereby
%       the smoothness of the bounds
%   Outputs: none

    %This function uses the following global variables
    global lowerBound upperBound L frame
    
    mult=2; %The size of the steps 
    gap=80; %The initial gap size between the bounds
    closerate=.005; %How fast the gap size closes
    n=L(2); %The max size of the graph

    %Deletes the first element of each bound
    lowerBound(1)=[]; upperBound(1)=[]; 
    if rem(frame,smoothness)==0
        if lowerBound(n)>=(L(4)-gap)
            lowerBound(n+1)=lowerBound(n)-mult*1;
        elseif lowerBound(n)<=0
            lowerBound(n+1)=lowerBound(n)+mult*1;
        else
            lowerBound(n+1)=lowerBound(n)+mult*(-1)^randi(2);
        end
    else
        lowerBound(n+1)=lowerBound(n);
    end
    upperBound(n+1)=lowerBound(n+1)+gap-closerate*frame;
    
end