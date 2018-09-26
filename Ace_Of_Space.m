% =======================================================================
% ACE OF SPACE                                            FUNCTION MAIN
% ------------------------------------------------------------------------
% A "helicopter" type game using asteroids as obstacles
% ========================================================================

%Clean Environment
clear; clc;     %Clear the command windows and reset variables
close all;      %Close all figure windows
format shortG;  %Use compact number display
format compact; %Use compact spacing display

%Setup Global Variables
global t g a
global frame           %Frame counter
global L
global playAgain
global x1 y1     %Setup Player Variables
global currentFigure xStars yStars
global obstacles maxNumObs obs_x obs_y obs_lag    %Vars associated with obstacle creation
global lowerBound upperBound botLim topLim xGrid rxGrid %Global variables associated with the bounds
global world character %Global variables resulting from the menu
global imageArrayChar alphaArrayChar %Structures containing character images, don't want to add parameters to fcns 
global imageArray alphaArray imageIndex %Vars corresponding to image plotting
global height   %Stores the height statistics 
global displayFails
global bonusPoints
global getPositionStat  %Boolean determining whether or not to get position information
global cheat            %Keeps track whether or not the destroy obstacles cheat is active
global worldNames charNames
global imageArrayCollect alphaArrayCollect imageIndexCollect collectibles %Vars associated with collectibles
    cheat = false;

%Globals iniitalized so we can clear at the end of this loop
t = 1/60;          %Setup time delay t to 0.05 seconds
L = [0 100 0 100]; %Setup figure limits to 10x10 square
getPositionStat = false;

%Default global variable values
maxNumObs=20;        %Maximum number of obstacles at a given time
obs_x = -10;         %The number of units obstacles move horizontally
obs_y = 10;          %Number of units obstacles move vertically
g = -100;            %Initialize gravity
a = 600;             %Initialize thruster acceleration
obs_lag = 20;        %Number of frames between each obstacle
world(1) = 1;        %Default world set to moon
character = 1;       %Default character to spaceship
displayFails = 0;
bonusPoints = 0;
worldNames = {'Moon','Earth','Jupiter','Black Hole','Anti Gravity','BMEme','BMeme Enhanced'};
charNames = {'Yellow Spaceship','Red Spaceship','Grey Spaceship',...
    'Eruptive Erika','Electric Erin','Kap''n Kate','Chen the Destroyer',...
    'Roundhouse Luke'};

%Default Local Variables
return2Menu = false;

%User Menu for Customization
playAgain=~menu();
worldBuilder();

%Setup Background Environment
currentFigure = figure('Color',world(8:10),...  %Set Figure Color
            'KeyPressFcn', @game_KeyDown,...    %Sets KeyPressFcn to custom function
            'KeyReleaseFcn', @game_KeyUp);      %Sets KeyReleaseFcn to custom function

%Sets up audio files
[y,Fs] = audioread('Sounds/BackgroundMusic.mp3');                  %Background music
musicPlayer = audioplayer(y,Fs);                        %Audioplayer for background music
[yExplosion,FsExplosion] = audioread('Sounds/explosion.wav');  %Explosion sound effect

while playAgain      %Begin Line for Play Again Loop
    
if return2Menu
    close all;
    quitGame=menu();
    if quitGame
       break; 
    end
    worldBuilder();
    currentFigure=figure('Color',world(8:10),...   %Set Figure Color to Black
        'KeyPressFcn', @game_KeyDown,...        %Sets KeyPressFcn to custom function
        'KeyReleaseFcn', @game_KeyUp);          %Sets KeyReleaseFcn to custom function 
end

if world(1) == 6 || world(1)==7
    set(currentFigure,'Color',world(8:10),...       %Set Figure Color to Black
        'KeyPressFcn', @game_KeyDown,...        %Sets KeyPressFcn to custom function
        'KeyReleaseFcn', @game_KeyUp);          %Sets KeyReleaseFcn to custom function
    Ayymon();
    set(currentFigure,'Color',world(8:10),...       %Set Figure Color to Black
        'KeyPressFcn', @game_KeyDown,...        %Sets KeyPressFcn to custom function
        'KeyReleaseFcn', @game_KeyUp);          %Sets KeyReleaseFcn to custom function 
end

imgFolderName = 'Characters';
[imageArrayChar,alphaArrayChar] = getSprites(imgFolderName);

if world(1) == 6
    imgFolderName = 'Pixelated';
else
    imgFolderName = 'Asteroids';
end
 
[imageArray,alphaArray] = getSprites(imgFolderName); 
imageIndex = randi([1,length(imageArray)],1,maxNumObs+1);  %Creates image indexes for all

if world(1) == 7
    [imageArrayCollect,alphaArrayCollect] = getSprites('Pixelated');
    imageIndexCollect = randi([1,length(imageArrayCollect)],1,maxNumObs+1);  %Creates image indexes for all
end

%Setup Local Variables
v = 0;               %Initialize velocity v to 0
score = 0;           %Initialize Score to 0
play(musicPlayer);   %Begins playing music

%Setup global variables
lowerBound=(L(3)+10)*ones(1,L(2)+1);     %Creates the intial lowerBound
upperBound=(L(4)-10)*ones(1,L(2)+1);     %Creates initial upperBound
botLim=L(3)*zeros(1,L(2)+1);        %Creates initial botLim
topLim=L(4)*ones(1,L(2)+1);         %Creates initial topLim
xGrid=0:100;                        %Creates intial xGrid 
rxGrid=fliplr(xGrid);               %Creates reverse of xGrid for fill purposes
frame = 0;                          %Initialize the frame counter to 0
bonusPoints = 0;                    %Initializes bonusPoints to 0
height = []; %Resets heights vector

%Create Area for Character
playerLoc = 20;      %The X Coordinate of Character Center
playerHeight = 40;   %Start Height of Character Area Center
if character(1)==1 || character(1)==2 || character(1)==3 
    playerWidth = 4;        %Width of the Character's Area
    playerLength = 2;       %Length of the Character's Area
else
    playerWidth = 2;        %Width of the Character's Area
    playerLength = 4;       %Length of the Character's Area
end

pLeft = playerLoc-playerWidth;   %Left Bound of Character Area
pRight = playerLoc+playerWidth;  %Right Bound of Character Area
pBot = playerHeight-playerLength; %Bottom Bound of Character Area
pTop = playerHeight+playerLength; %Top Bound of Character Area
player = hitbox(pLeft,pRight,pBot,pTop); %Initial Player Location

%Create Area for Obstacle
% obstacle = hitbox(0,100,0,4);   %Initial First Obstacle
obstacles = [];         %Initializes obstacle array
collectibles = [];      %Initializes collectibles array

%Setup Initial Postion
[x1,y1] = drawHitbox(player);   %Get Initial Player Coordinate

%Figure setup
set(currentFigure,'Color',world(8:10),...       %Set Figure Color to Blac
        'KeyPressFcn', @game_KeyDown,...        %Sets KeyPressFcn to custom function
        'KeyReleaseFcn', @game_KeyUp);          %Sets KeyReleaseFcn to custom function 
%Sets plot to take the size of the whole figure
set(gca,'position',[0 0 1 1],'units','normalized');
[xStars,yStars] = generateStars(50);            %Generates stars to populate background
updatePlot();      %Keep Initial Setup in Background

%Display Start Instructions
startStr = 'Press Space to Start';      %Text to Display on Start
startTXT = text(50, 50, startStr,...    %Set Properties of Start Text
    'HorizontalAlignment','center',...  %Set Alignment
    'FontSize',20,...                   %Set Font Size
    'Color',[1 1 1]);                   %Set Color
set(currentFigure,'currentchar','~')    %Initialize Current Key to ~= Space
while ~(get(currentFigure,'currentchar')==32) %Exit when Space is Pressed
    figure(currentFigure)               %Bring Current Figure into Focus
    pause(t);                           %Delay for Frame Rate
    if ~isplaying(musicPlayer)          %Restarts music when music stops
        play(musicPlayer);
    end  
end 

%Main Loop
while true
%    M(frame)=getframe(currentFigure); %Used for retrieving frames for making a video
    [player,v] = playerMove(player,v);%Moves player based on key input
    clc;
    [x1,y1] = drawHitbox(player);           %Get New Player Coordinates
    %Checks for collision
    if playerDeath(player,lowerBound(playerLoc),upperBound(playerLoc))       
        break                               %If the player dies, then break out of game loop
    end
    if world(1) == 3 || world(1) == 4 || world(1) == 5 
        obs_y = rand*randi([-1 1])*2;
    end
    updatePlot();      %Update 1figure for the new position
    moveObstacles(obs_x,obs_y);             %Update object positions for next round
    obstSize = randi([8 17]);              %[Min Max] obstacle size
    if world(1) == 6
        createObstacle(obstSize-obstSize*2/5,obstSize);%Creates new rectangular obstacles
    else
        createObstacle(obstSize,obstSize);%Creates new rectangular obstacles
    end
    obstSize = randi([8 16]);              %[Min Max] obstacle size
    
    if world(1) == 7                        %Collectibles only applies to world 6
        createCollectibles(obstSize-obstSize*2/5,obstSize); %Creates collectibles
        playerCollect(player);              %Collects the collectibles for bonus points
    end
    
    pause(t);                               %Delay between frame updates
    score = getScore();                     %Updates Score for current frame
    if ~isplaying(musicPlayer)              %Restarts music when music stops
        play(musicPlayer);
    end  
    [~,height(frame-1)] = getCenter(player); %Gets the player's position and stores it in height
end
stop(musicPlayer);              %Stops music
sound(yExplosion,FsExplosion);  %Plays explosion noise

%End Game Functions
highScore = saveScore(score);   %Save Score and Get Current High Score
return2Menu=endGame(score,highScore);       %Generate Game Over Screen
end %End Line for Play Again Loop

close all;
clearvars -except M; clc;