%para testar cena do histograma de cores
% %Split into RGB Channels
%     Red = rgbImage(:,:,1);
%     Green = rgbImage(:,:,2);
%     Blue = rgbImage(:,:,3);    
%     %Get histValues for each channel
%     [yRed, x] = imhist(Red,4);
%     [yGreen, x] = imhist(Green,4);
%     [yBlue, x] = imhist(Blue,4);
%     %Plot them together in one plot
%     %hist(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');
%     
%     stem(x,yRed);
%----------------------------------------------------%
rgbImage = imread('rgb_image1_15.png');

%[counts, binlocations] = imhist(rgbImage,4)
I = rgbImage;

R=imhist(I(:,:,1),4);
G=imhist(I(:,:,2),4);
B=imhist(I(:,:,3),4);

figure(1);
stem(R,'r');
hold on;
stem(G,'g');
hold on;
stem(B,'b');
hold on;
legend(' Red channel','Green channel','Blue channel');

rgbImage = imread('rgb_image1_16.png');

%[counts, binlocations] = imhist(rgbImage,4)
I=rgbImage;

R=imhist(I(:,:,1),4);
G=imhist(I(:,:,2),4);
B=imhist(I(:,:,3),4);

figure(2);
stem(R,'r');
hold on;
stem(G,'g');
hold on;
stem(B,'b');
hold on;
legend(' Red channel','Green channel','Blue channel');

