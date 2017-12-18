%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    ransac_iteration.m                                     %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luís Almeida ()              %
%                              Francisco Pereira ()         %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R, T, P1, P2, subset, error] = ransac_iteration(matches, imd1, f1, imd2, f2, nmatches)
    
    % Get a subset "Y" of size 4 from "matches" (coordinates of cols are on Y)
    [subset, Y] = vl_colsubset(matches,4);
    
    % Select only the points (in each PC) that were matched by SIFT
    ret = create_matched_xyz(subset, imd1, f1, imd2, f2);
    
    % P1 and P2 are matches in both camera frames
    P1 = ret.P1; % noise_factor * rand(3,size(subset,2)) TEST NOISE
    P2 = ret.P2;  % noise_factor * rand(3,size(subset,2))  
    
    % c — Translation component
    % T — Orthogonal rotation and reflection component
    % b — Scale component

    [error,transf_points,transf_matrix] = procrustes(P1',P2','scaling',false,'reflection',false);
    
    R = transf_matrix.T;
    T = transf_matrix.c;
    
end