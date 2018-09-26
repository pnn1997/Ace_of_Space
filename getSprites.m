function [imageArray,alphaArray] = getSprites(imgFolderName)
%getSprites retrieves the images from a folder and extracts the associated
%  data
%   Inputs:
%   imgFolderName = name of the folder the pictures are located
%   Outputs:
%   imageArray = an array of the image matrices extracted from the images
%   alphaArray = array of the alpha data for the images
    contents = dir([imgFolderName,'/*.png']);
    for i = 1:numel(contents)
        filename = contents(i).name;
        [imgData,~,imgAlpha] = imread(fullfile(imgFolderName,filename));
        imageArray(i) = imageData(imgData);
        alphaArray(i) = imageData(imgAlpha);
    end
end