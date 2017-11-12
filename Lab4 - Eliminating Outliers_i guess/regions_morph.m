%%lab 8%%

im=imread('eight.jpg');
imr=rgb2gray(im);
figure;
imshow(im);
pause;
figure;
imhist(imr);
pause;
%binarize the image
figure;
imagesc(imr<160);
colormap(gray);
pause;
%delete the black part inside the coins
%LP filter
LPf=ones(5)/25;
imf=conv2(imr,LPf,'same');
figure;
imagesc(imf<160);
colormap(gray);
pause;

figure;
imagesc(double(imr).*(imf<160));
colormap(gray);
pause;

%in this case it doesn't work well
figure;
imagesc(double(imr).*(imf<100));
colormap(gray);
pause;
close all;
%Morfological filter
%Erosion (-): we use a patch f_z and we select pixels whose intersection
%with the image I is not 0. 
%if f_z = 1 and I = 0 the intersection is 0
%if f_z = 1 and I = 1 the intersection is 1
%if f_z = 0 is always 0
%
%Dilation (+): we use a patch f_z compute the union and select pixels
% {z: f_z U I}
%
%There are two ways to do this:
%OPEN => first erose and then dilate (f_z (-) I) (+) f_z
%CLOSE => first dilate and then erose (f_z (+) I) (-) f_z
%
%Binary image
imb=imr<120;
figure;
imshow(imb);
pause;

f_z=strel('disk',5);
%erosion
ime=imerode(imb,f_z);
figure;
subplot(2,2,1);
imagesc(ime);
colormap(gray);

%dilation
imd=imdilate(imb,f_z);
subplot(2,2,2);
imagesc(imd);
colormap(gray);

%open
imo=imopen(imb,f_z);
subplot(2,2,3);
imagesc(imo);
colormap(gray);

%close
imc=imclose(imb,f_z);
subplot(2,2,4);
imagesc(imc);
colormap(gray);
