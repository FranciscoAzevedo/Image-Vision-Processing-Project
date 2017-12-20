function [ imgseq1,imgseq2 ] = creates_structures( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
cd M:\Paco\A4_S1\PIV\Projecto_PIV\Proj_Part1\cam1\;
%cd D:\abran\Desktop\Tecnico\4ºAno\PIV\PIV_Project\Proj_Part1\cam1\;
imgseq1.rgb = dir('*.png');
imgseq1.depth = dir('*.mat'); 

cd M:\Paco\A4_S1\PIV\Projecto_PIV\Proj_Part1\cam2\;
%cd D:\abran\Desktop\Tecnico\4ºAno\PIV\PIV_Project\Proj_Part1\cam2\
imgseq2.rgb = dir('*.png');
imgseq2.depth = dir('*.mat'); 

cd M:\Paco\A4_S1\PIV\Projecto_PIV\Proj_Part1\;
%cd D:\abran\Desktop\Tecnico\4ºAno\PIV\PIV_Project\Proj_Part1

end

