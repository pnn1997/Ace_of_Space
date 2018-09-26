classdef imageData
    %imageData is used to store image matrices
    %   An array of this class will be used to store various the matrices
    %   for various images
    %   Example: for i = 1:10
    %               ImageArray(i) = imageData(EXTRACTED_IMAGE_MATRIX);
    %            end
    
    properties
        imageMatrix %Contains the matrix for an image
    end
    
    methods
        %Constructor - sets the input parameter to the object's imageMatrix
        %   property
        function obj=imageData(iMatrix)
            obj.imageMatrix=iMatrix;
        end
    end
    
end

