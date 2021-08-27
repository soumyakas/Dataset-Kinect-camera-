% clear; 
clearvars -except vid vid2;
clc; close all;
% if exist vid == 1
%     stop([vid vid2]);
% end
folder_img = 'cimg/';
folder_depth = 'dimg/';

vid = videoinput('kinect',1);
vid2 = videoinput('kinect',2);
srcDepth = getselectedsource(vid2);
srcDepth.EnableBodyTracking = 'on';
vid.FramesPerTrigger = 1;
vid2.FramesPerTrigger = 1;
vid.TriggerRepeat = 200;
vid2.TriggerRepeat = 200;
triggerconfig([vid vid2],'manual');
start([vid vid2]);
% Trigger 200 times to get the frames.
fig = gcf;
for i = 1:100
    % Trigger both objects.
    trigger([vid vid2])
    % Get the acquired frames and metadata.
    %Skeletal data is accessed as metadata on the depth stream. You can use getdata to access it.
    [imgColor, ts_color, metaData_Color] = getdata(vid);
    [imgDepth, ts_depth, metaData_Depth] = getdata(vid2);
    img_name = [folder_img, sprintf('%06d.tif',i)]
    depth_name = [folder_depth, sprintf('%06d.tif',i)]
    subplot(1,2,1);
%     set(imageHandle ,'CData',frame)
    imshow(imgColor);
    imwrite(imgColor, img_name);
%     figure;
subplot(1,2,2);
imshow(imgDepth,[0 4500]);

%KINECT USUAL DEPTH RANGE IS BETWEEN 800 TO 4000
% maxdepth = 4500;
% relative_depths = min(1, (0:65535).' ./ maxdepth);
% cmap = [relative_depths, relative_depths, relative_depths];  %greyscale
%   imwrite(imgDepth, cmap, 'fo.tiff');
%    [depth_in, cmap_in] = imread('fo.tiff');
%     image(depth_in); colormap(cmap_in);
    imwrite(imgDepth, depth_name);
   
    
    
end

stop([vid vid2]);