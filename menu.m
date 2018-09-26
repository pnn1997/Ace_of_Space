function quitGame=menu()

%menu initiates command line prompts for inputs for world and character
%selection
%   Inputs: none
%   Outputs: none

format compact;
clc;

global world     %Calls global world containing level #, and background color data
global character %Calls global character containing playable sprite #
global displayFails %Whether to display fail graph or not
global cheat     %Cheat is activated if the konami kode is entered into the cheat menu
global worldNames charNames %Globals containing names of worlds and characters
global invalidInput

numMenuDashes = 60; %Number of double dashes to display on each line in menu

%Contains string for invalid input which is repetitive, global b/c used in
%function menuSelection as well
invalidInput = 'ERROR - Invalid entry. Please re-enter your Selection: ';

%loads the high score to see what characters and worldNums are unlocked
topScores = zeros(length(worldNames),5);    %Initialize topScores vector
highScore = zeros(1,length(worldNames));    %Initialize highScores vector

for ii = 1:length(worldNames)               %Loop to get top scores     
    scoreFile = ['Save Files/','Score_History_','World',num2str(ii),'.txt']; %Name of file
    if ~exist(scoreFile,'file') %Check if file exists
       fidScore = fopen(scoreFile,'w+');    %If file doesn't, create it
       fclose(fidScore);                    %Close writing to file
    end
   
    scoreHistory = load(scoreFile);         %Get data from file

    if isempty(scoreHistory)                %Check if data vector is empty
        fidScores = fopen(scoreFile,'a+');  %Append to the file if so
        fprintf(fidScores,'%.f\n',0);       %Initialize it with 0
        fclose(fidScores);                  %Close/save the new file
    end
    
    if length(scoreHistory) < 5             %Check if there are less than 5 scores in the file
       for jj = length(scoreHistory)+1:5    %If say there are only 4 values, then write a fifth
           scoreHistory(jj) = 0;            %value of 0 to the vector
       end
    end
    
    highScore(ii) = max(scoreHistory);      %Set the hich score of this world to the max of the file
    
    if isempty(highScore)                   %Check if no high score in world
        highScore = -1;                     %Then set high score to -1
    end
    sortedScores = sort(scoreHistory,'descend');    %Sort the scores
    topScores(ii,:) = sortedScores(1:5);            %Only use the top five of each
end

highScore = max(highScore);                 %Set overall high score to max of all
scoreUnlockModifier = 400;                  %How many points between unlocks

if highScore < scoreUnlockModifier*1      %Establishes if user has yet to unlock
    unlock = 1; 
elseif highScore < scoreUnlockModifier*2  %Establishes if unlocked next world/char
    unlock = 2; 
elseif highScore < scoreUnlockModifier*3  %Establishes if unlocked next world/char
    unlock = 3;
elseif highScore < scoreUnlockModifier*4  %Establishes if unlocked next world/char
    unlock =4;
elseif highScore < scoreUnlockModifier*5  %Establishes if unlocked next world/char
    unlock = 5;
elseif highScore < scoreUnlockModifier*6  %Establishes if unlocked next world/char
    unlock = 6;
elseif highScore >= scoreUnlockModifier*7 %Establishes if unlocked next world/char
    unlock = 7;
end

Startgame=0;    %Initialize the while loop value to 0
while Startgame~=1  %Run until user specifies to start the game
    for borderLines = 1:numMenuDashes %Create border lines
        fprintf('=');                 %Double line style
    end
    fprintf('\n');                    %Next line
    for borderLines = 1:numMenuDashes %Create border lines
        fprintf('-');                 %Single line style
    end
    fprintf('\n');                    %Next line
    
    %Create the graphics for the main menu
    fprintf('\n');
    fprintf('\t ACE OF SPACE\n\n');
    fprintf('\t      |\n');
    fprintf('\t     / \\              We await your order Commander:\n');
    fprintf('\t    / _ \\\n');
    fprintf('\t   |.o ''.|              1. Play Game\n');
    fprintf('\t   |''._.''|              2. Customize\n');
    fprintf('\t   |     |              3. View Stats\n');
    fprintf('\t ,''|  |  |`.            4. Quit\n');
    fprintf('\t/  |  |  |  \\\n');
    fprintf('\t|,-''--|--''-.|\n');
    fprintf('\n\n');

    
    for borderLines = 1:numMenuDashes %Number of dashes to display
        fprintf('-'); %Single Dash Style
    end
    fprintf('\n');  %New Line
    for borderLines = 1:numMenuDashes %Number of double dashes to display
        fprintf('='); %Double Dash Style
    end
    fprintf('\n\n'); %Blank line between

MainSelection = input('What is your command? \n','s');  %Ask for input
MainSelection = str2double(MainSelection);              %Convert to number for comparison
while (MainSelection~=1)&&(MainSelection~=2)&&(MainSelection~=3)&&...
        (MainSelection~=4)&&(MainSelection~=5)          %Check valid selections        
    fprintf('\n');                                      %New line
    fprintf('%s',invalidInput);                         %Display error
    MainSelection = input('','s');                      %Ask again
    MainSelection = str2double(MainSelection);          %Convert again
end

if MainSelection==1 %If option 1
    Startgame=1;    %Start game
    quitGame = 0;   %Don't end the menu and break the main loop
    clc;            %Clear command window
elseif MainSelection == 2; %If option 2
    clc;            %Clear command window
    fprintf('CUSTOMIZATION:\n\n');  %Display category chosen
    %Create string of options
    menuOptions = {'Choose Character','Choose World','Return to Menu'}; 
    SelectCust=menuSelection(menuOptions);  %Call selection function
            
    if SelectCust == 1;  %character Selection menu
        clc;
        fprintf('CHARACTER SELECTION:\n\n');
        if unlock==1  %Displays and allows only the characters that the  player has unlocked
            character=menuSelection(charNames(1));  %Only the main character
        elseif unlock==2
            character=menuSelection(charNames(1:2)); %Next characters
        elseif unlock==3 || unlock==4
            character=menuSelection(charNames(1:3)); %Next characters
        elseif unlock==5
            character=menuSelection(charNames(1:5)); %Next 2 characters
        elseif unlock==6
            character=menuSelection(charNames(1:7)); %Next 2 characters
        elseif unlock >= 7
            character=menuSelection(charNames(1:8)); %Last Character
        end
        clc;
    end
    
    if SelectCust == 2;  %World Selection menu
        clc;
        fprintf('WORLD SELECTION:\n\n');
        if unlock==1;  %Displays and allows only the worldNums that the  player has unlocked
            worldNum=menuSelection(worldNames(1));
        elseif unlock==2;
            worldNum=menuSelection(worldNames(1:2));
        elseif unlock==3;
            worldNum=menuSelection(worldNames(1:3));
        elseif unlock==4;
            worldNum=menuSelection(worldNames(1:4));
        elseif unlock==5;            
            worldNum=menuSelection(worldNames(1:5));
        elseif unlock==6;
            worldNum=menuSelection(worldNames(1:6));
        elseif unlock>=7;
            worldNum=menuSelection(worldNames(1:7));
        end
        world(1) = worldNum;
        clc;
    end 
        
    if SelectCust == 3;  %Return to menu
        Startgame = 0;
        clc;
    end 

    
elseif MainSelection==3
    clc;
    fprintf('STATISTICS:\n\n');
    fprintf('Your top 5 scores are:\n');
    for k = 1:numel(worldNames)
        fprintf('%-*s\t',length(worldNames{k})+1,worldNames{k});
    end
    fprintf('\n');
    for k = 1:5
        for ii = 1:numel(worldNames)
            fprintf('%-*i\t',length(worldNames{ii})+1,topScores(ii,k))
        end
        fprintf('\n');
    end
    
    %Get histograms for each world with each color specified
    worldNum = world(1);
    displayFails = 1;
    for ii = length(worldNames):-1:1
        world(1) = ii;
        worldBuilder();
        stats(0,false);
        displayFails = 0;
    end
    world(1) = worldNum;
         
    fprintf('\nA histogram of your scores has been generated\n\n');
    input('Enter any key to return to main menu\n','s');
    close all;
    clc;
    
elseif MainSelection==4
    Startgame=1;
    quitGame = 1;
    clc;

%Checks if player entered the secret code 5
elseif MainSelection==5     
    fprintf('SECRET! Enter the secret code: \n');
    secretCode = [30 30 31 31 28 29 28 29 98 97 13];    %Vector having the ascii code for keys for the konami code
        %[up up down down left right left right a b enter]
    cheat = true;       %Sets cheat to true and resets it if any part of the code is wrong
    code=figure;             %Creates figure to read in the code
    axis([0 100 0 100]);
    %Compares the user input with the konami code
    for i = 1:length(secretCode)
        figure(code); %Refocuses figure
        set(gcf,'Color',[0 0 0]);   %Set Figure Color to black
        grid off;                   %Turn Off Grid
        axis off;                   %Turn Off Axis Lines
        
        endStr = 'Enter Code:';      %Text to Display on Start
        text(50, 67,...               %Set Position
            endStr,...                          %Set Text to Display
            'HorizontalAlignment','center',...  %Set Alignment
            'FontSize',40,...                   %Set Font Size
            'Color',[1 1 1]);                   %Set Color
        %Adds asterisks to the figure
        if i ~= 1
            text(18+(i-1)*5,34,...                 %Set Position
                '*',...                      %Set Text to Display
                'HorizontalAlignment','center',...  %Set Alignment
                'FontSize',40,...                   %Set Font Size
                'Color',[1 1 1]);                   %Set Color
        end
        waitforbuttonpress;                     %Waits for button press
        key = get(gcf,'currentcharacter');      %Retrieves key pressed
        if key ~= secretCode(i)
            cheat = false;
        end
    end
    %Adds in the last asterisk
    text(18+(11)*5,34,...                   %Set Position
        '*',...                             %Set Text to Display
        'HorizontalAlignment','center',...  %Set Alignment
        'FontSize',40,...                   %Set Font Size
        'Color',[1 1 1]);                   %Set Color

    %Prints out response
    if cheat == true    %Code was successfully inputted
        fprintf('Congratulations! You can now destroy obstacles!\n');
    else                %Code was not inputted correctly
        fprintf('Sorry! That code was wrong.\n');
    end
    pause(1);           %Pauses for 1 second before moving on
    close all;
    clc;
end
    
end


