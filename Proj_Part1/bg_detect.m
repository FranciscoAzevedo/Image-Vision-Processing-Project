%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    bg_detect.m                                            %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [bg_depth] = bg_detect(img_seq)
    %Detects Background of a given RGB+D image using depth info
    
    % Allocating memory
    %ims = [];
    ims_d = [];

    % Opening images and storing in ims and imsd struct
    for i=1:length(img_seq.rgb)
        
        %im = rgb2gray(imread(img_seq.rgb(i).name));
        load(img_seq.depth(i).name);

        % Convert to column vector to apply filters
        %ims = [ims im(:)];
        ims_d = [ims_d depth_array(:)];
    end

    % Apply filter to have stronger border contrast 
    %median_rgb = median(double(ims),2);
    median_depth = median(double(ims_d),2);

    % Convert to matrix again 
    %bg_rgb = reshape(median_rgb,[480 640]); 
    bg_depth = reshape(median_depth,[480 640]);
    
end

