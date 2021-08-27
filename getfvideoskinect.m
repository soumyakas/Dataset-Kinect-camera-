clear; 
clc; 
imaqreset;

max_frames = 400


folder_img = 'cimg23/';
folder_depth = 'dimg23/';

vid = videoinput('kinect',1);
vid2 = videoinput('kinect',2);
srcDepth = getselectedsource(vid2);
srcDepth.EnableBodyTracking = 'on';
vid.FramesPerTrigger = 1;
vid2.FramesPerTrigger = 1;
vid.TriggerRepeat = max_frames;
vid2.TriggerRepeat = max_frames;
for i=5:-1:1
    disp(i)
    pause(1)
end

start([vid vid2]);
disp('start recording')
imgColor = zeros(max_frames, 1080,1920,3,'uint8');
imgDepth = zeros(max_frames,424,512,'uint16');
v1 = VideoWriter(['videos/fall28_color.mp4'],'MPEG-4');
v2 = VideoWriter(['videos/fall28_depth.mp4'],'MPEG-4');
open(v1);
open(v2);
for i = 1:max_frames
   
    [imgColor, ts_color, metaData_Color] = getdata(vid);
    [imgDepth, ts_depth, metaData_Depth] = getdata(vid2);
    disp('start saving')
    writeVideo(v1,im2double(imgColor));
    writeVideo(v2,im2double(imgDepth));
    
    
end

close(v1);
close(v2);
stop([vid vid2]);
delete([vid vid2]);
clear vid
clear vid2 
disp('done')
filename='fall28.mat'; save(filename)