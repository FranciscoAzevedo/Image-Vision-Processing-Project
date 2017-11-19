%% Detecting Background and Foreground
% Opening dataset
d=dir('rgb_image_10.png');
dd=dir('model001.mat');
ims=[];
imsd=[];

% Converting image to gray
for i=1:length(d),
    im = rgb2gray(imread(d(i).name));
    imshow(im); colormap(gray);
    load(dd(i).name);
    drawnow;
    
    %Convert to column vector to apply filters
    ims = [ims im(:)];
    imsd=[imsd depth_array(:)];
end

%Apply filter to have stronger border contrast
medim = median(double(ims),2);
meddep = median(double(imsd),2);

% bgim = rgb2gray(uint8(reshape(medim,[480 640 3]))); %

bgim = (uint8(reshape(medim,[480 640])));
bgimd = reshape(meddep,[480 640]);

% Detects if pixel in image is foreground or background
for i=1:length(d),
    
    im = rgb2gray(imread(d(i).name));
    
    foreg = abs(double(im) - double(bgim)) > 0; %foreground metric for colour
    load(dd(i).name);
    
    foregd = abs(double(depth_array) - bgimd) > 0; %foreground metric for depth
    
    % Opening the final result
    figure(1);
    imshow([im 255*foreg 255*imfill(imopen(foreg,strel('disk',5)),'holes')  ]);
    colormap(gray);
    figure(2);
    imagesc([depth_array double(max(depth_array(:)))*[foregd  imopen((foregd),strel('disk',10))]]);
    colormap('jet');
    pause;
end
