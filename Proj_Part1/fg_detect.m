%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    fg_detect.m                                            %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fg_depth,filtered_fg_final] = fg_detect(img_seq,frame_number,bg_depth)

    % Getting the foreground
    load(img_seq.depth(frame_number).name);
    
    % Doing an average of depth without zeros (dead pixels)
    fg_depth = abs(double(depth_array) - bg_depth);
    cnt = 0;
    
    [r,c] = find(fg_depth ~= 0);
    for i = 1:length(r)
        cnt = cnt + fg_depth(r(i),c(i));
    end
    
    if(isempty(r) == 1)
        cnt = 1;
    end    
    
    thres = (cnt/(length(r)))*2;
    fg_depth_bin = fg_depth > thres; %Detect close enough objects
    
    % Calculate gradients
    [grad_x, grad_y] = gradient(fg_depth);
    mag_grad = sqrt(grad_x.^2 + grad_y.^2);
    mag_grad(mag_grad < 500) = 0;
    mag_grad = not(mag_grad); % invert values

    % Apply the filters (split different objects and filter garbage)
    segmented_fg = fg_depth_bin.*mag_grad;
    filtered_fg = imopen(segmented_fg,strel('disk',3));
    filtered_fg_final = bwareaopen(filtered_fg,2000);
    fg_depth = fg_depth.*filtered_fg_final;

    end