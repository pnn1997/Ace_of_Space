function selectionNum=menuSelection(stringVector)
%menuSelection initiates selection inputs to avoid repetitiveness
%selection
%   Inputs: stringVector (worldNames)
%   Outputs: selectionNum (worldNum)

global invalidInput

    for k = 1:length(stringVector)
        fprintf('%i. %s\n',k,stringVector{k});
    end
    selectionNum = input('Enter Selection:\n','s');
    selectionNum = str2double(selectionNum);
    validInput = (selectionNum~=1);
    if length(stringVector) > 1
        for k = 2:length(stringVector)
            validInput = (selectionNum~=k)*validInput;
        end
    end
    while validInput
        fprintf('%s',invalidInput);
        selectionNum = input('','s');
        selectionNum = str2double(selectionNum);
    end
end