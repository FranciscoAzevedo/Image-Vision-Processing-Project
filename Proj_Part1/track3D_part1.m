%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    peopletracking.m                                       %
%    Progama desenvolvido por: Francisco Azevedo (80966)    %
%                              Lu�s Almeida ()              %
%                              Francisco Pereira ()         %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function objects = track3D_part1(imgseq1, imgseq2, cam_params, cam1toW, cam2toW)

% Point Cloud for camera 1 and 2


%Transform local reference frame to world frame

%Using SIFT to get correspondence between points in RGB

%Get respective points in X,Y,Z

%Run RANSAC to eliminate outliers

%Drawing box around object and storing data

%Making correspondence between current and last image

end