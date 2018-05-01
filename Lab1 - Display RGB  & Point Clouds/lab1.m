%% LAB 1 de PIV 2017
clear
clc
close all

%im_10 = imshow('rgb_image_10.png');
%figure();
%im_14 = imshow('rgb_image_14.png');

load('CalibrationData.mat');
load('calib_asus.mat');

load('depth_10.mat'); %para cada pixel(u,v), esta matriz tem o valor da coordenada Z 

figure();
im_depth = imagesc(depth_array);%para ver os dados "z" em forma de imagem

[u_1, v_1] = ginput(1); %para escolher um ponto rgb e depois no surf com o Z 
                        % fazer "highlight" do ponto no plot 3d
u_1 = round(u_1);
v_1 = round(v_1);
    
u = ones(480,1)*(1:640);
v = (1:480)'*ones(1,640);

Zd = double(depth_array)/1000; %para estar em metros pois dept_array esta em mm

%matriz_3d = [reshape(u.*Zd,[640*480, 1]),reshape(v.*Zd,[640*480, 1]),reshape(Zd,[640*480, 1])]';

figure();
Z = mesh(u,v, Zd);
hold on;
Zd(u_1, v_1)
plot3( u_1,v_1, Zd(u_1, v_1) , 'r*', 'MarkerSize', 20);

