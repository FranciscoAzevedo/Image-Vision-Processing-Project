%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    peopletracking.m                                       %
%    Progama desenvolvido por: Francisco Azevedo (80966)    %
%                              Luís Almeida ()              %
%                              Francisco Pereira ()         %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function objects = track3D_part1(imgseq1, imgseq2, cam_params, cam1toW, cam2toW)

%Point cloud for camera 1

%Point cloud for camera 2

%Detecting and eleminating background for camera 1 and 2

%Detecting objects in camera 1

%Detecting objects in camera 2

%Using SIFT to get correspondence between points in RGB

%Get respective points in X,Y,Z

%Run RANSAC to eliminate outliers

%Drawing box around object and storing data

%Making correspondence between current and last image

end