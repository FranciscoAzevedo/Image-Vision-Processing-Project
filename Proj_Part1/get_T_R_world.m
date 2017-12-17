%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    get_T_R_world.m                                        %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luís Almeida ()              %
%                              Francisco Pereira ()         %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R,T,P1,P2] = get_T_R_world( im1, imd1, im2, imd2 )
    % Get the T and R transformation matrices using SIFT and RANSAC

    % Using SIFT to get matches
    [nmatches, matches,f1, d1, f2, d2, PP1, PP2] = sift_match(im1, imd1, im2, imd2);

    % RANSAC
    for j=1:ransac_iterations
        
        [R, T, P1, P2, subset, e] = ransac_iteration(matches, imd1, f1, PP1, imd2, f2, PP2, nmatches);
        
        error(j) = e;
        
        % Store transformations and points in respective camera
        aux(j).R = R;
        aux(j).T = T;
        aux(j).P1 = P1;
        aux(j).P2 = P2;
        aux(j).subset = subset;

    end

    [min_score,min_idx] = min(error);
    
    % Obtain best transformation and respective group of points
    T = aux(min_idx).T;
    R = aux(min_idx).R;
    P1 = aux(j).P1;
    P2 = aux(j).P2;
    error = min_score;

end 

