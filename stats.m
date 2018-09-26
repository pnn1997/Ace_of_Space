function stats(score,compareScore)
%stats plots out various figures associated with the game
%   Inputs:
%   score = current score
%   compareScore = boolean determining whether or not to compare current
%     score with high score
%   Outputs: none

global currentHistogram heightFigure height world displayFails worldNames

    scoreFile = ['Save Files/','Score_History_','World',num2str(world(1)),'.txt'];

    scoreHistory = load(scoreFile);             %Load Scores from File
    currentHistogram = figure;                  %Generate New Figure
    histScore = histogram(scoreHistory,12);     %Generate Histogram
    
    histScore.FaceColor = world(2:4);%Color bars based on bot world bounds
    
    titleTxt = strcat('Histogram of Scores for World: ',...
        worldNames(world(1)));
    title(titleTxt);                 %Generate Title
    xlabel('Scores');                           %Generate X axis label
    ylabel('Frequency');                        %Generate Y axis label
    
    if compareScore                             %Run Only after a Game
        hold on;                                %Add to Current Figure
        binValues = histScore.BinEdges;         %Get edge values of bins
        d=sort(abs(score-binValues));           %Sort by Closest Value
        closestEdge=find(abs(score-binValues)==d(1));   %Find Closest Edge
        nextEdge=find(abs(score-binValues)==d(2));  %Find Next Closest Edge
        binNum = min(closestEdge,nextEdge);     %Associated bin for score 
        x = histScore.BinEdges(binNum:binNum+1);%Both sides of bin's x coor
        x = [x fliplr(x)];                      %Mirror x coor of bin
        y = [0 0 repmat(min(histScore.Values(binNum)), 1, 2)];%Bin count for y
        patch(x,y,'r',...                       %Add an outline around bin
            'EdgeColor','r','FaceColor','none','LineWidth',2); %Red outline
        hold off;                               %Done with current figure
    
        %Plots height information throughout the game
        heightFigure = figure;
        plot(1:length(height),height,'-k','linewidth',2);
        xlabel('Frame #');
        ylabel('Height');
        title('Player Movement');
        axis([1,length(height),0,100]);
                
        %Plots the deaths caused by different professors if currently in memeworld
        if world(1) == 6
            failGraph();
        end
        
        %Plots total number of professors collected if in enhanced
        %memeworld
        if world(1) == 7
            collectGraph();
        end
    end
    if displayFails
        failGraph();
    end
    
end