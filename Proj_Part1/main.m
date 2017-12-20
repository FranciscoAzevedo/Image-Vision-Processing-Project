% Main
load('cameraparametersAsus');
[ imgseq1,imgseq2 ] = creates_structures( );

% O k é o numero da imagem
k=15;
objects = track3D_part2(imgseq1, imgseq2, cam_params);