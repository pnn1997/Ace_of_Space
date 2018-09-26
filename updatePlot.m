function updatePlot()
%updatePlot draws all of the required components for each frame of the game
%   Inputs: none
%   Outputs: none

    global x1 y1 obstacles L currentFigure  %Global Variables for this Scope
    global xStars yStars twinklers frame          %More Global Variables
    global lowerBound upperBound botLim topLim xGrid rxGrid%Global variables for plotting the bounds
    global character world %Global variables resulting from the menu
    global imageArrayChar alphaArrayChar %Structures containing character images, don't want to add parameters to fcns
    global imageArray alphaArray
    global imageIndex                   %Determines which image goes with which obstacle
    global collectibles imageIndexCollect imageArrayCollect alphaArrayCollect
    
    figure(currentFigure)               %Bring Figure into Focus
    
    %Plots stars in the background and makes some of them twinkle
    plot(xStars,yStars,'w*','markersize',1); %Plots all the stars in the background
    hold on;                                                %Add to Figure
    axis tight
    %Every new stars to twinkle every once in a while
    if mod(frame,20) == 0
        %Chooses random stars to be twinkled
        twinklers = randi([1,length(xStars)],1,15);
    end
    plot(xStars(twinklers),yStars(twinklers),'w*','MarkerSize',3);
    
    %Uses imageIndex to assign images for each obstacle and draws it
%     if character(1) == 1
%         margin = 1; %margin between the outer edge of the sprite and the hitbox 
%     else
        margin = 1;
%     end        
    imagesc([x1(1)-margin x1(3)+margin],...
        [y1(2)+margin y1(4)-margin],...
        imageArrayChar(character).imageMatrix,...
        'AlphaData',alphaArrayChar(character).imageMatrix)
%      plot(x1,y1,'g-o','markersize',1,'markerfacecolor','g'); %Plot hitbox on top

    if world(1) ~= 6 || world(1) ~= 5 %Change margins for asteroids to something more reasonable
        margin = 3; %margin between the outer edge of the sprite and the hitbox 
    end
    
    %Plots all the hitboxes in the obstacles array
    for i = 1:length(obstacles)
        [x,y] = drawHitbox(obstacles(i));
        
        %Uses imageIndex to assign images for each obstacle and draws it
        imagesc([x(1)-margin x(3)+margin],...
            [y(2)+margin y(4)-margin],...
            imageArray(imageIndex(i)).imageMatrix,...
            'AlphaData',alphaArray(imageIndex(i)).imageMatrix)
%          plot(x,y,'r-o','markersize',1,'markerfacecolor','r'); %Plots hitbox on top
    end
    %Collectibles only apply to world 6
    if world(1) == 7    
        %Plots all of the entities int eh collectibles array
        for i = 1:length(collectibles)
            [x,y] = drawHitbox(collectibles(i));
            imagesc([x(1)-margin x(3)+margin],...
                [y(2)+margin y(4)-margin],...
                imageArrayCollect(imageIndexCollect(i)).imageMatrix,...
                'AlphaData',alphaArrayCollect(imageIndexCollect(i)).imageMatrix)
        end
    end
    
    %Plots the upper and lower boundaries
    plot(xGrid,lowerBound,'b-',xGrid,upperBound,'b-');
    gradientVector = [ones(1,L(2)+1),zeros(1,L(2)+1)];
    %Fills in the areas between the bounds and the limits
    patch([rxGrid,xGrid],[botLim,lowerBound],world(2:4),...
        'FaceVertexAlphaData',gradientVector',...
        'FaceAlpha','interp',...
        'EdgeAlpha',1,'EdgeColor',world(2:4),'LineStyle','-'); %CHANGED TO PATCH B/C IT ALLOWS FOR 
    patch([rxGrid,xGrid],[topLim,upperBound],world(5:7),...     %GRADIENT COLORS
        'FaceVertexAlphaData',gradientVector',...
        'FaceAlpha','interp',...
        'EdgeAlpha',1,'EdgeColor',world(5:7),'LineStyle','-'); %CHANGED TO PATCH B/C IT ALLOWS FOR 

    bounds(3); %Updates the bounds
  
    hold off;                           %Finished with Figure
    grid off;                           %Hide grid
    axis(L);                            %Set axis limits to global borders
    axis off;                           %Hide axis lines
    frame = frame + 1;                  %Updates the frame count
    
    scoreTxt =['Score: ',num2str(getScore())];    %Set Text to Display
    text(L(2)*3/4-3, L(4)/25,...                 %Set Position
        scoreTxt,...                        %Set Text to Display
        'HorizontalAlignment','left',...   %Set Alignment
        'FontSize',14,...                   %Set Font Size
        'Color','w','FontWeight','bold');                       %Set Color 
end