%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    fg_detect.m                                            %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fg_depth,filtered_fg_final] = fg_detect(img_seq,frame_number,bg_depth)

% Getting the foreground (REMINDER: NOT PROCESSING COLOUR HERE)
    %escolher imagem ainda:
    load(img_seq.depth(frame_number).name);
    
    fg_depth = abs(double(depth_array) - bg_depth);
    fg_depth_bin = fg_depth > 800; %Detect close enough objects

    % Calculate gradients
    [grad_x, grad_y] = gradient(fg_depth);
    mag_grad = sqrt(grad_x.^2 + grad_y.^2);
    mag_grad(mag_grad < 1000) = 0;
    mag_grad = not(mag_grad); % invert values

    % Apply the filters (split different objects and filter garbage)
    segmented_fg = fg_depth_bin.*mag_grad;
    filtered_fg = imopen(segmented_fg,strel('disk',3));
    filtered_fg_final = bwareaopen(filtered_fg,2000);
    fg_depth = fg_depth.*filtered_fg_final;
   
end