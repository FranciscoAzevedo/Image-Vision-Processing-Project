function [ img_seq1,img_seq2 ] = creates_structures( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

imgseq1.rgb = dir('*.png');
imgseq1.depth = dir('*.mat'); 
imgseq2.rgb = dir('*.png');
imgseq2.depth = dir('*.mat'); 



end

