function return2Menu=endGame(score,highScore)
%endGame plots different graphs and displays the game over screen upon the
% game ending
%   Inputs:
%   score = player's current score
%   highScore = highest score across all games
%   Outputs:
%   return2Menu = true if player wants to return to menu, false otherwise
    global t L playAgain        %Global Variables Used in Scope
    global currentFigure        %Current Figure Window    
    global currentHistogram failsFigure heightFigure

    figure(currentFigure)       %Bring Current Figure into Focus
    clf('reset')                %Reset Figure Window
    axis(L);                    %Set Axis Values
    set(gcf,'Color',[ 1 1 1 ]); %Set Figure Color to White
    grid off;                   %Turn Off Grid
    axis off;                   %Turn Off Axis Lines
    
    pause(t*6);                 %Flash Period
    
    set(gcf,'Color',[0 0 0]);   %Set Figure Color to black
    grid off;                   %Turn Off Grid
    axis off;                   %Turn Off Axis Lines
    
    endStr = 'GAME OVER!';      %Text to Display on Start
    text(L(2)/2, L(4)*2/3,...               %Set Position
        endStr,...                          %Set Text to Display
        'HorizontalAlignment','center',...  %Set Alignment
        'FontSize',40,...                   %Set Font Size
        'Color',[1 1 1]);                   %Set Color
    
    finalScore = ['SCORE: ' num2str(score)];%Create Score String
    text(L(2)/2, L(4)/3,...                 %Set Position
        finalScore,...                      %Set Text to Display
        'HorizontalAlignment','center',...  %Set Alignment
        'FontSize',20,...                   %Set Font Size
        'Color',[1 1 1]);                   %Set Color
    
    if score > highScore
        newHighStr = ['NEW HIGH SCORE: ' num2str(score)];   %Create String        
        text(L(2)/2, L(4)/4,...                 %Set Position
            newHighStr,...                      %Set Text to Display
            'HorizontalAlignment','center',...  %Set Alignment
            'FontSize',14,...                   %Set Font Size
            'Color',[1 0.3 0.3]);               %Set Color
        
    else
        oldHighScore = ['BEST SCORE: ' num2str(highScore)]; %Create String
        text(L(2)/2, L(4)/4,...                 %Set Position
            oldHighScore,...                    %Set Text to Display
            'HorizontalAlignment','center',...  %Set Alignment
            'FontSize',14,...                   %Set Font Size
            'Color',[1 1 1]);                   %Set Color
    end
    
    stats(score,true);                  %Generate Histogram of Scores
    figure(currentFigure)               %Bring Current Figure into Focus

    againTxt = {'Press Space to Try Again','or Press m to Return to Menu',...
        'or Press q to Quit'};
    text(L(2)/2, L(4)/20,...                %Set Position
        againTxt,...                        %Set Text to Display
        'HorizontalAlignment','center',...  %Set Alignment
        'FontSize',14,...                   %Set Font Size
        'Color',[0.8 0.8 0.8]);             %Set Color
    set(gcf,'currentchar','~')    %Initialize Current Key to ~= Space
    while ~(any(get(gcf,'currentchar') == 'q'|...  %w or s option for move
        get(gcf,'currentchar') == ' '|...
        get(gcf,'currentchar') == 'm')) %Only run when keys aren't pressed
        pause(t);                       %Give a Time Delay to Slow Loop
%         figure(currentFigure)           %Bring Current Figure into Focus
        if get(gcf,'currentchar') == 'q'
            playAgain = 0;              %If q then quit by exiting loop
            return2Menu = false;
        elseif get(gcf,'currentchar') == 'm'
            return2Menu = true;
            playAgain = 1;              %If anything else, run loop again
        else
            return2Menu = false;
            playAgain = 1;              %If anything else, run loop again
        end
    end
    if ishandle(currentHistogram)
        close(currentHistogram);
    end
    if ishandle(failsFigure)
        close(failsFigure);
    end
    if ishandle(heightFigure)
        close(heightFigure);
    end
    clc;
end