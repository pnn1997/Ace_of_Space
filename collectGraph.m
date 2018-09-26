function collectGraph()
%collectGraph prints out the statistics for which teacher collectibles were
%collected
%   Inputs: none
%   Outputs: none

prof={'Altiero','Anderson','Aung','Bayer','Brown','Dancisak','Gaver','Gilbertson',...
    'Job','Moore','Murfee','Raymond','Sanchez','Schuler','Walker'}; %Array of professors
collected = load('Save Files/profsCollected.txt'); %Reads in failure data from file
%Plots the data in a bar graph
figure;
bar(collected);
%Labels axes
title('Office Hours Attended');
xlabel('Professors');
ylabel('Number of Times');
%Applies the x-axis labels and rotates them 45 degrees
ax = gca;
ax.XTickLabels=prof;
ax.XTickLabelRotation = 45;
end

