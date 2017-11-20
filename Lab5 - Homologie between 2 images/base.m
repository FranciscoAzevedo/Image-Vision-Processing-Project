d=dir('*.jpg');
p={};for i=1:length(d),imagesc(imread(d(i).name));p=[p {ginput(3)}];end
pb = p{3};
ims=[];
for i=1:length(d),
    im=rgb2gray(imread(d(i).name));
    im=im(round(p{i}(1,2))-60:round(p{i}(1,2))+80,round(p{i}(1,1))-30:round(p{i}(1,1))+80);
    figure(1);imagesc(im);colormap(gray);pause(1);
    drawnow;
    ims=[ims im(:)];
end
ims=double(ims);
caramedia=mean(ims')';
imsc=ims-caramedia*ones(1,size(ims,2));
imagesc(reshape(caramedia,141,111));pause(2);
%for i=13:-1:1,imagesc(reshape(imsc(:,i),141,111));pause,end
[v,s]=eig(imsc'*imsc);
u=imsc*v*inv(sqrt(abs(s)));
for i=13:-1:1,imagesc(reshape(u(:,i),141,111));pause,end
