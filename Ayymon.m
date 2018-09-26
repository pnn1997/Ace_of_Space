function Ayymon()
%Ayymon shows the graphic of Dr. Raymond and plays a recording of her
%saying "You know this. You got this."
%   Inputs: none
%   Outputs: none

global currentFigure L t world
figure(currentFigure)
axis(L);                    %Set Axis Values
grid off;                   %Turn Off Grid
axis off;                   %Turn Off Axis Lines
imshow('YouKnowThisYouGotThis.jpg');
[y,Fs] = audioread('Sounds/RaymondStatic.mp3');  %Encouraging words from Dr. Raymond
sound(y,Fs);
%Sets plot to take the size of the whole figure
set(gca,'position',[0 0 1 1],'units','normalized'); 

pause(5);                   %Delay until sound is done playing
clf('reset')

set(gcf,'Color',[1 1 1]); %Set Figure Color to White
grid off;                   %Turn Off Grid
axis off;                   %Turn Off Axis Lines

pause(t*6);                 %Flash Period

set(gcf,'Color',world(8:10));   %Set Figure Color to White
grid off;                   %Turn Off Grid
axis off;                   %Turn Off Axis Lines
end