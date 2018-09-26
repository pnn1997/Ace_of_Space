function game_KeyDown(hObject, eventdata, handles)
%game_KeyUp acts as the key release callback function for the game
%   Inputs:
%   hObject = the figure that uses this callback function
%   eventdata = not used currently, reserved for future versions
%   handles = figure handles
    global key %Stores the value of the key
    key = get(hObject,'CurrentKey'); %Retrieves key value from figure window
end

