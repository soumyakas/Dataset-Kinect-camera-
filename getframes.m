clear; 
% clearvars -except vid vid2;
clc; 
% close all;
imaqreset;
%imaqmex('feature','-limitPhysicalMemoryUsage',false);
% if exist vid == 1
%     stop([vid vid2]);
% end
max_frames = 100
folder_img = 'cimg8/';
folder_depth = 'dimg8/';

vid = videoinput('kinect',1);
vid2 = videoinput('kinect',2);
srcDepth = getselectedsource(vid2);
srcDepth.EnableBodyTracking = 'on';
vid.FramesPerTrigger = 1;
vid2.FramesPerTrigger = 1;
vid.TriggerRepeat = max_frames;
vid2.TriggerRepeat = max_frames;

% preview(vid)
% k=-1;
% while(k<0)
%     k = waitforbuttonpress
% end

for i=5:-1:1
    disp(i)
    pause(1)
end

    % Trigger 200 times to get the frames.
% fig = gcf;

start([vid vid2]);
disp('start recording')
imgColor = zeros(max_frames, 1080,1920,3,'uint8');
imgDepth = zeros(max_frames,424,512,'uint16');

for i = 1:max_frames
    % Trigger both objects.
%     trigger([vid vid2])
    % Get the acquired frames and metadata.
    %Skeletal data is accessed as metadata on the depth stream. You can use getdata to access it.
    [imgColor(i,:,:,:), ts_color, metaData_Color] = getdata(vid);
    [imgDepth(i,:,:), ts_depth, metaData_Depth] = getdata(vid2);
%     img_name = [folder_img, sprintf('%06d.tif',i)];
%     depth_name = [folder_depth, sprintf('%06d.tif',i)];
    
    
    
end
disp('start saving')
img_temp = zeros(1080,1920,3,'uint8');
depth_temp = zeros(424,512,'uint16');
for i=1:max_frames
    img_name = [folder_img, sprintf('%06d.tif',i)];
    depth_name = [folder_depth, sprintf('%06d.tif',i)];
    
    
    img_temp(:,:,:) = imgColor(i,:,:,:);
    depth_temp(:,:) = imgDepth(i,:,:);
    
    imwrite(img_temp, img_name);
    imwrite(depth_temp, depth_name);
end
stop([vid vid2]);
delete([vid vid2])
clear vid
clear vid2
disp('done')