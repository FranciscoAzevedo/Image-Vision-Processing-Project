im=imread('lena.gif');
im=double(im);
[u,s,v]=svd(im);
for i=1:length(s),
    imr=zeros(size(im));
    for k=1:i,
        imr=imr+u(:,k)*s(k,k)*v(:,k)';
        imagesc([im imr]);
        k
        pause(.3);
    end
end