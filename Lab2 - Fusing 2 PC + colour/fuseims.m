%% Program to Fuse two RGB+D Images
% Opening images and reshaping to new matrices
K=[525 0 319.5;
    0 525 239.5;
    0 0 1];

depth1 = imread('cardepth2.png');
im1 = imread('car2.jpg');
depth2=imread('cardepth393.png');
im2 = imread('car393.jpg');
figure(1);
imagesc([im1 im2]);
figure(2);
imagesc([depth1 depth2]);
xyz1 = get_xyz_asus(depth1(:),[480 640],1:640*480,K,1,0);
xyz2 = get_xyz_asus(depth2(:),[480 640],1:640*480,K,1,0);

cl1 = reshape(im1,480*640,3);
cl2 = reshape(im2,480*640,3);
 
p1 = pointCloud(xyz1,'Color',cl1);
p2 = pointCloud(xyz2,'Color',cl2);

figure(3)
showPointCloud(p1);
figure(4)
showPointCloud(p2);
%%
% Eleminating outliers (zeros)
m1 = depth1>0;
m2 = depth2>0;

imaux1 = double(repmat(m1,[1,1,3])).*double(im1)/255;
imaux2 = double(repmat(m2,[1,1,3])).*double(im2)/255;

figure(5);
imagesc(imaux1);
figure(6);
imagesc(imaux2);

% select figure with im1 and click 5 points
%[u1,v1]=ginput(5);
%select figure with im2 and click in the corresponding points
%[u2 v2]=ginput(5);

% Here we already have the optimal point correspondence by hand
u1 =[  216.7007  324.5143 329.1022 352.0412 372.6864]';
v1 =[  53.7925 80.2550 111.8629 194.9257 78.7848]';

u2=[257.9910  224.7294  135.2670   42.3638  192.6147]';
v2=[87.6057  108.1876  124.3591  168.4632  130.9747]';

%Plot chosen points
figure(5);hold on;plot(u1,v1,'*r');hold off;
figure(6);hold on;plot(u2,v2,'*r');hold off;

ind1 = sub2ind([480 640],uint64(v1),uint64(u1));
ind2 = sub2ind([480 640],uint64(v2),uint64(u2));

%%
% Do some kind of magic to then apply SVD ang get Rotation Matrix!
cent1 = mean(xyz1(ind1,:))';
cent2 = mean(xyz1(ind2,:))';

pc1 = xyz1(ind1,:)'-repmat(cent1,1,5);
pc2 = xyz2(ind2,:)'-repmat(cent2,1,5);

[a b c]= svd(pc2*pc1')
R12 = a*c'

%%
%This is the Translation Matrix!
T=cent2-R12*cent1;
xyzt1=R12*(xyz1'-repmat(cent1,1,length(xyz1)));
xyzt2=xyz2'-repmat(cent2,1,length(xyz2));


%%
% Show final result
ptotal = pointCloud([xyzt1';xyzt2'],'Color',[cl1;cl2]);
figure(7);
showPointCloud(ptotal);
