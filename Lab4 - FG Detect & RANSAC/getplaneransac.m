xyz=get_xyz_asus(bgim(:),[480 640],(1:480*640),Depth_cam.K,1,0);
inds=find(xyz(:,3)~=0);
xyz=xyz(inds,:);
pc=pointCloud(xyz);
showPointCloud(pc);
%%%%%%%%%%%%%%ransac for 3D planes
errorthresh=0.10;
niter=100;
%generate sets of 3 points (randomly selected)
aux=fix(rand(3*niter,1)*length(xyz))+1;
%
planos=[];
numinliers=[];
for i=1:niter-3,
    pts=xyz(aux(3*i:3*i+2),:);
    A=[pts ones(3,1);zeros(1,4)];
    [u s v]=svd(A,'econ');
    plano=v(:,4);
    plano=plano/norm(plano(1:3));
    planos=[planos plano];
    erro=abs([xyz ones(length(xyz),1)]*plano);
    inds=find(erro<errorthresh);
    plot3(xyz(:,1),xyz(:,2),xyz(:,3),'.b');
    hold on;
    plot3(xyz(inds,1),xyz(inds,2),xyz(inds,3),'.r');
    hold off,
    drawnow;
    numinliers=[numinliers length(find(erro<errorthresh))];
end
[mm,ind]=max(numinliers);
fprintf('Maximum num of inliers %d \n',mm);
plano=planos(:,ind);
inds=find(abs([xyz ones(length(xyz),1)]*plano)<errorthresh);
A=[xyz(inds,:) ones(length(inds),1)];
    [u s v]=svd(A,'econ');
    planofinal=v(:,4);
    pc2=pointCloud(xyz(inds,:),'Color',uint8(ones(length(inds),1)*[255 0 0]));
    showPointCloud(pc);hold; showPointCloud(pc2);