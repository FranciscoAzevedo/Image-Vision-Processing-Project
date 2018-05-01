#Lab 1 PIV 2017

load('CalibrationData.mat')
load('depth_10.mat')

u = ones(480,1) *(1:640);

v = (1:480)'*ones(1,640);

Zd = double(depth_array)/1000;

P = inv(Depth_cam.K)*[reshape( u.*Zd,[1 640*480] ); reshape( v.*Zd,[1 640*480] );reshape(Zd,[1 640*480]) ];

P2 = Aruco_cam.K*[R_d_to_rgb T_d_to_rgb]*[P; ones(1, 640*480)];

u2 = P2(1,:)./P2(3,:); 
v2 = P2(2,:)./P2(3,:);

%ESTA CENA NAO E DO PROF
% n = 1;
% imshow('rgb_image_10.png')
% [u_d, v_d ] = ginput(n);
% figure(2);

for i=1:n
    
    u_2 = u2(u_d);
    v_2 = v2(v_d);
    imshow('rgb_image_14.png')
    hold on;
    plot(u_2, v_2, '*');

end

