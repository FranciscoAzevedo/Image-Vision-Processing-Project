%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    get_cornerpoints                                       %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ cornerpoints ] = get_cornerpoints( PC )

    min_x = PC.XLimits(1);
    max_x = PC.XLimits(2);
    min_y = PC.YLimits(1);
    max_y = PC.YLimits(2);
    min_z = PC.ZLimits(1);
    max_z = PC.ZLimits(2);
    
    cornerpoints(1,:) = [min_x, min_y, min_z];
    cornerpoints(2,:) = [min_x, max_y, min_z];
    cornerpoints(3,:) = [max_x, min_y, min_z];
    cornerpoints(4,:) = [max_x, max_y, min_z];
    cornerpoints(5,:) = [min_x, min_y, max_z];
    cornerpoints(6,:) = [min_x, max_y, max_z];
    cornerpoints(7,:) = [max_x, min_y, max_z];
    cornerpoints(8,:) = [max_x, max_y, max_z];
    

end

