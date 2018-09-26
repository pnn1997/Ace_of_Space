function getVideo(M,fileName)
%getVideo creates a video and gif from the frames captured in gameplay

%   Inputs:
%   M = frame data to be converted to a video format
%   fileName = name of the video to be created
%   Outputs: none

    %Goes through all the frames and writes them to a gif file
    %See link above on example on how to do this:
        %https://sukhbinder.wordpress.com/2012/10/09/gif-animation-in-matlab-in-3-steps/
%     [im,map] = rgb2ind(M(end).cdata,256,'nodither');
%     for k = 1:length(M)
%         im(:,:,1,k) = rgb2ind(M(k).cdata,map,'nodither');
%     end
%     imwrite(im,map,[fileName '.gif'],'DelayTime',0,'LoopCount',inf);

    v = VideoWriter([fileName '.mp4'],'MPEG-4'); %Creates video file writer object to create the file
    v.FrameRate = 15;
    open(v);
    for k = 1:length(M)
        writeVideo(v,M(k));
    end
    close(v);
     
end

