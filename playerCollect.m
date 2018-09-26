function playerCollect(player)
%playerDeath returns true when the player character collides with an
%obstacle or a boundary and false othewise
%   Inputs:
%   player = player character hitbox
%   botBound = the lowest the player can go in this instance
%   topBound = the highest the player can go in this instance
%   Outpus:
%   death = returns true when the player is dead, false otherwise
    
    global collectibles %Uses the obstacles vector to determine if collisions occur
    global imageIndexCollect imageArrayCollect %Used to determine which professor was collected
    global  bonusPoints    %Stores the number of bonus points earned
    %Checks if the player collided with any obstacles
    for i = 1:length(collectibles)
        if colDetect(player,collectibles(i))
            %Checks to see if a professor killed the TA in memeworld
            pCollect = load('Save Files/profsCollected.txt');  %Loads the failure data from file
            fidCollector=fopen('Save Files/profsCollected.txt','w+');    %File to be written and read from
            if isempty(pCollect)              %Initializes file in case it does not exist
                pCollect = zeros(length(imageArrayCollect),1);
            end
            profID = imageIndexCollect(i);             %Retrieves the index of the guilty professor
            pCollect(profID)=pCollect(profID)+1;    %Increments the corresponding professor's failure count
            fprintf(fidCollector,'%i\n',pCollect);  %Updates the information in the file
            fclose(fidCollector);
            %Checks if cheat has been activated. Cheat allows you to
            %destroy the obstacles
            bonusPoints = bonusPoints+50;
            collectibles(i) = [];
            imageIndexCollect(i) = [];
            %Replaces the element of the imageIndex that was just
            %deleted
            imageIndexCollect(end+1) = ...                %Adds a random picture to the
                randi([1,length(imageArrayCollect)]);     %end of queue to be shown later
            break;       %Breaks out of loop as only one collision is possible per column
        end
    end
end