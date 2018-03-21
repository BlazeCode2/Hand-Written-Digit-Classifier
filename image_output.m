function exter = image_output()


% ima=snapshot(webcam);
% url = 'http://192.168.1.2:8080/shot.jpg';
% url = 'http://192.168.43.1:8080/shot.jpg';
url = 'http://192.168.8.100:8080/shot.jpg';
ima  = imread(url);
whos ima
ima=rgb2ntsc(ima);
ima=ima(:,:,1);
% ima=ima(:,280:280+720);
ima=ima(:,420:420+1080);
% ima=fliplr(ima);
figure(1),imshow(ima);
title('Original image input')
ima=imresize(ima,[28 28]);
% ima=-ima;
% minVal=min(ima(:));
% maxVal=max(ima(:));
% delta=maxVal-minVal;
% normalized=(ima-minVal)./delta;
ima=mat2gray(ima);
ima=1-ima;
idx=ima<0.5;
ima(idx)=0.1;
% contrastedImage = sigmoid((normalized -0.5) * 5);
% imshow(contrastedImage,[-1 1]);
% exter=contrastedImage(:)';
exter=ima(:)';
end