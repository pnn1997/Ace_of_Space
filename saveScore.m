function [highScore] = saveScore(score)
%saveScore retrieves the high score stored in the score history files and
%  determines if the new score is a new high score
%   Inputs:
%   score = current score
%   highScore = the high score

global world %Global variable used in function

%Retrieves the score information from the score file
scoreFile = ['Save Files/','Score_History_','World',num2str(world(1)),'.txt'];
fidScores = fopen(scoreFile,'a+');

%Finds the highest score stored in file
scoreHistory = load(scoreFile);
highScore = max(scoreHistory);

%This deals with the case where the score history is empty
if isempty(highScore)
    highScore = -1;
end

%Adds the new score to the file
fprintf(fidScores,'%.f\n',score);
fclose(fidScores);

end