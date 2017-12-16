%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    ransac_iteration.m                                     %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luís Almeida ()              %
%                              Francisco Pereira ()         %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R, T, P1, P2, subset, error] = ransac_iteration(matches, imd1, f1, PP1, imd2, f2, PP2, nmatches, noise_factor)
    
    % Get a subset "Y" of size 4 from "matches" (coordinates of cols are on Y)
    [subset, Y] = vl_colsubset(matches,4);
    
    ret = createPs( subset, imd1, f1, imd2, f2);

    P1 = ret.P1 + rand(3,size(subset,2));
    P2 = ret.P2 + rand(3,size(subset,2));

    [R,T] = rigid_transform_3D(P2',P1');

    PP1_ = R * PP2 + repmat(T,1,nmatches);
    dx = PP1_(1,:) - PP1(1,:) ;
    dy = PP1_(2,:) - PP1(2,:) ;
    dz = PP1_(3,:) - PP1(3,:) ;
    error = (1/nmatches)*sum(sqrt(dx.*dx + dy.*dy + dz.*dz));
    
end