%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    get_T_R_world.m                                        %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luís Almeida ()              %
%                              Francisco Pereira ()         %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R,T] = get_T_R_world( im1, imd1, im2, imd2 )
% Get the T and R transformation matrices using SIFT and RANSAC

% Using SIFT to get matches
[nmatches, matches,f1, d1, f2, d2,] = sift_match(im1, imd1, im2, imd2)





end 

