function death = playerDeath(player,botBound,topBound)
%playerDeath returns true when the player character collides with an
%obstacle or a boundary and false othewise
%   Inputs:
%   player = player character hitbox
%   botBound = the lowest the player can go in this instance
%   topBound = the highest the player can go in this instance
%   Outpus:
%   death = returns true when the player is dead, false otherwise
    
    global obstacles %Uses the obstacles vector to determine if collisions occur
    global imageIndex imageArray world %Used to determine which professor killed the TA in memeworld
    global cheat bonusPoints    %True if cheat code was used
    death = false; %Base case for function
    %Checks to see if the player is past the boundaries
    if player.topBound > topBound || player.botBound < botBound
        death = true;
    end
    %Checks if the player collided with any obstacles
    for i = 1:length(obstacles)
        if colDetect(player,obstacles(i))
            death = true;
            %Checks to see if a professor killed the TA in memeworld
            if world(1) == 5 && ~cheat
                pFails = load('Save Files/failures.txt');  %Loads the failure data from file
                fidFailure=fopen('Save Files/failures.txt','w+');    %File to be written and read from
                if isempty(pFails)              %Initializes file in case it does not exist
                    pFails = zeros(length(imageArray),1);
                end
                profID = imageIndex(i);             %Retrieves the index of the guilty professor
                pFails(profID)=pFails(profID)+1;    %Increments the corresponding professor's failure count
                fprintf(fidFailure,'%i\n',pFails);  %Updates the information in the file
                fclose(fidFailure);
            end
            %Checks if cheat has been activated. Cheat allows you to
            %destroy the obstacles
            if cheat
                death = false;
                bonusPoints = bonusPoints+50;
                obstacles(i) = [];
                imageIndex(i) = [];
                %Replaces the element of the imageIndex that was just
                %deleted
                imageIndex(end+1) = ...                %Adds a random picture to the
                    randi([1,length(imageArray)]);     %end of queue to be shown later
            end
            break;      %Breaks as only one collision is possible per column
        end
    end
    

end

