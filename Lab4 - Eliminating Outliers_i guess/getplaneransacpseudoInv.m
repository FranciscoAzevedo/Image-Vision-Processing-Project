xyz=get_xyzasus(bgimd(:),[480 640],(1:480*640),Depth_cam.K,1,0);
inds=find(xyz(:,3)~=0);
xyz=xyz(inds,:);
pc=pointCloud(xyz);
showPointCloud(pc);
%%%%%%%%%%%%%%ransac for 3D planes
errorthresh=0.1;
niter=100;
%generate sets of 3 points (randomly selected)
aux=fix(rand(3*niter,1)*length(xyz))+1;
%
planos=[];
numinliers=[];
for i=1:niter-3,
    pts=xyz(aux(3*i:3*i+2),:);
    %pseudoinversa
    A=[pts(:,1:2) ones(3,1)];
    plano=inv(A'*A)*A'*pts(:,3);
    planos=[planos plano];
    erro=abs(xyz(:,3)-[xyz(:,1:2) ones(length(xyz),1)]*plano);
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
erro=abs(xyz(:,3)-[xyz(:,1:2) ones(length(xyz),1)]*plano);
inds=find(erro<errorthresh);
 A=[xyz(inds,1:1) ones(length(inds),1)];
    planofinal= inv(A'*A)*A'*xyz(inds,3);
    pc2=pointCloud(xyz(inds,:),'Color',uint8(ones(length(inds),1)*[255 0 0]));
    showPointCloud(pc);hold; showPointCloud(pc2);
    
    