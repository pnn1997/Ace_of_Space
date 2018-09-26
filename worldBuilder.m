function worldBuilder()
%worldBuilder sets up the world global variables
%   Inputs: none
%   Outputs: none

global world  %world = [worldNum, botBoundColor, topBoundColor]
global a g obs_x obs_y maxNumObs obs_lag character charNames
worldNum = world(1);

if worldNum == 1; %Moon
    botBoundColor = [0.8 0.8 0.8]; %Grey
    topBoundColor = [0.7 0.7 0]; %Yellow
    backgroundColor = [0.3 0.3 0.3]; %Dark Grey
    world = [worldNum, botBoundColor, topBoundColor, backgroundColor];
    
    %World1 (moon) global variable values
    maxNumObs=20;        %Maximum number of obstacles at a given time
    obs_x = -1;          %The number of units obstacles move horizontally
    obs_y = 0;           %Number of units obstacles move vertically
    g = -100;            %Initialize gravity
    a = 500+abs(g);             %Initialize thruster acceleration
    obs_lag = 25;        %Number of frames between each obstacle
    
elseif worldNum == 2; %Earth
    botBoundColor = [0 0.5 1]; %Blue
    topBoundColor = [0.7 0.7 0]; %Yellow
    backgroundColor = [0.3 0.3 0.3]; %Grey
    world = [worldNum, botBoundColor, topBoundColor, backgroundColor];
    
    %World2 (Earth) global variable values
    maxNumObs=20;        %Maximum number of obstacles at a given time
    obs_x = -1;          %The number of units obstacles move horizontally
    obs_y = 0;           %Number of units obstacles move vertically
    g = -300;            %Initialize gravity
    a = 500+abs(g);             %Initialize thruster acceleration
    obs_lag = 20;        %Number of frames between each obstacle
    
elseif worldNum == 3; %Jupiter
    botBoundColor = [0.7 0 0]; %Red
    topBoundColor = [0.7 0.7 0]; %Yellow
    backgroundColor = [0.3 0.3 0.3]; %Grey
    world = [worldNum, botBoundColor, topBoundColor, backgroundColor];
    
    %World3 (Jupiter) global variable values
    maxNumObs=25;        %Maximum number of obstacles at a given time
    obs_x = -1;          %The number of units obstacles move horizontally
    obs_y = 0;           %Number of units obstacles move vertically
    g = -1000;            %Initialize gravity
    a = 500+abs(g);          %Initialize thruster acceleration
    obs_lag = 20;        %Number of frames between each obstacle
    
elseif worldNum == 4; %Black Hole
    botBoundColor = [0 0 0]; %Black
    topBoundColor = [0.7 0 0]; %Magenta
    backgroundColor = [0.3 0.3 0.3]; %Grey
    world = [worldNum, botBoundColor, topBoundColor, backgroundColor];
    
    %World4 Black Hole global variable values
    maxNumObs=20;        %Maximum number of obstacles at a given time
    obs_x = -1;          %The number of units obstacles move horizontally
    obs_y = 0;           %Number of units obstacles move vertically
    g = -10000;            %Initialize gravity
    a = 500+abs(g);             %Initialize thruster acceleration
    obs_lag = 25;        %Number of frames between each obstacle

elseif worldNum == 5; %Anti Gravity
    botBoundColor = [0.3 0 0.3]; %Black
    topBoundColor = [0 0 0]; %Magenta
    backgroundColor = [0.3 0.3 0.3]; %Grey
    world = [worldNum, botBoundColor, topBoundColor, backgroundColor];
    
    %World4 Black Hole global variable values
    maxNumObs=20;        %Maximum number of obstacles at a given time
    obs_x = -1;          %The number of units obstacles move horizontally
    obs_y = 0;           %Number of units obstacles move vertically
    g = 10000;            %Initialize gravity
    a = 500+abs(g);             %Initialize thruster acceleration
    obs_lag = 25;        %Number of frames between each obstacle
    
elseif worldNum == 6; %BMEme
    botBoundColor = [0 0.6 0]; %Green
    topBoundColor = [1 1 1]; %White
    backgroundColor = [0.3 0.3 0.3]; %Grey
    world = [worldNum, botBoundColor, topBoundColor, backgroundColor];
    
    %World5 (meme) global variable values
    maxNumObs=20;        %Maximum number of obstacles at a given time
    obs_x = -1;          %The number of units obstacles move horizontally
    obs_y = 0;           %Number of units obstacles move vertically
    g = -300;            %Initialize gravity
    a = 500+abs(g);             %Initialize thruster acceleration
    obs_lag = 25;        %Number of frames between each obstacle
    
elseif worldNum == 7; %BMEme
    botBoundColor = [0 0.4 0]; %Green
    topBoundColor = [1 1 1]; %White
    backgroundColor = [0.3 0.3 0.3]; %Grey
    world = [worldNum, botBoundColor, topBoundColor, backgroundColor];
    
    %World5 (meme) global variable values
    maxNumObs=20;        %Maximum number of obstacles at a given time
    obs_x = -1;          %The number of units obstacles move horizontally
    obs_y = 0;           %Number of units obstacles move vertically
    g = -300;            %Initialize gravity
    a = 500+abs(g);           %Initialize thruster acceleration
    obs_lag = 38;        %Number of frames between each obstacle
    character = length(charNames); %Force "Roundhouse Luke" for this level

end

end

