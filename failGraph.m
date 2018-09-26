function failGraph()
%failGraph prints out the statistics for which teacher obstacles caused the
%  most collisions
%   Inputs: none
%   Outputs: none

global failsFigure
prof={'Altiero','Anderson','Aung','Bayer','Brown','Dancisak','Gaver','Gilbertson',...
    'Job','Moore','Murfee','Raymond','Sanchez','Schuler','Walker'}; %Array of professors
fails = load('Save Files/failures.txt'); %Reads in failure data from file
%Plots the data in a bar graph
failsFigure = figure;
bar(fails);
%Labels axes
title('Which Professors Cause the Most Failure');
xlabel('Professors');
ylabel('Number of Failures');
%Applies the x-axis labels and rotates them 45 degrees
ax = gca;
ax.XTickLabels=prof;
ax.XTickLabelRotation = 45;
end