%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    track_objects                                          %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [objects, actual_frames_objects] = track_objects(prev_frames_objects, actual_frames_objects, objects,k)
    % Description: Given objects of 2 consecutive frames track objects that
    % are common in both frames and store them in struct "objects"

    % Inputs:      
    % prev_frames_objects -> Struct that has the objects of the previous frame                                                                                                                                     
    % actual_frames_objects -> Struct that has the objects of the actual frame    
    % objects -> Struct that has all the objects 

    % 10% Error threshold
    erro_threshold = 0.1;
    
    % In case there are objects in both frames
    if( isempty(prev_frames_objects) == 0 && isempty(actual_frames_objects) == 0) 
        
        % Lets compare all actual frame objects with prev frame objects to
        % find the best (in case it exists) match
        for i = 1:length(actual_frames_objects)
            
            % R G B of previous frame (RGB é um vetor de quatro elementos)
            [Ra,Ga,Ba] = histograma_cores(actual_frames_objects(i).PC_rgb.Color); 

            for j = 1:length(prev_frames_objects)   
                % R G B of actual frame
                [Rp, Gp, Bp] = histograma_cores(prev_frames_objects(j).PC_rgb.Color);

                % Distance between histogramas of each component of colour
                % between 2 frames
                Erro_R = Rp-Ra;
                Erro_G = Gp-Ga;
                Erro_B = Bp-Ba;
                
                % Error between 2 images (sum of squared error)
                Erro(j)= Erro_R'*Erro_R + Erro_G'*Erro_G + Erro_B'*Erro_B; 
            end

            % If the min error of all matches is below a certain threshold
            % it means its the same object between frames
            [M, idx] = min(Erro);
            
            if (Erro(idx) < erro_threshold)   
                
                % Assignment of the matched actual frame object to "objects"
                [r,c] = size(objects(prev_frames_objects.index(idx)).X);
                objects(prev_frames_objects.index(idx)).X(r + 1,:) = actual_frames_objects(i).X(1,:); 
                objects(prev_frames_objects.index(idx)).Y(r + 1,:) = actual_frames_objects(i).Y(1,:); 
                objects(prev_frames_objects.index(idx)).Z(r + 1,:) = actual_frames_objects(i).Z(1,:);
                objects(prev_frames_objects.index(idx)).frames_tracked(r + 1) = actual_frames_objects(i).frames_tracked;  
                 objects(prev_frames_objects.index(idx)).PC_rgb = actual_frames_objects(i).PC_rgb;
                if (actual_frames_objects(i).index ~= 1)    
                    objects(actual_frames_objects(i).index) = []; 
                end
            end
        end
        
        % Searches for objects that correspond to actual 
        sub_ind = find_objs_frame_x(objects,k);
        for i=1:length(sub_ind)
            actual_frames_objects(i).X = objects(sub_ind(i)).X;
            actual_frames_objects(i).Y = objects(sub_ind(i)).Y;
            actual_frames_objects(i).Z = objects(sub_ind(i)).Z;
            actual_frames_objects(i).frames_tracked = objects(sub_ind(i)).frames_tracked;
            actual_frames_objects(i).PC_rgb = objects(sub_ind(i)).PC_rgb;
            
            actual_frames_objects(i).index(i)=sub_ind(i);
        end
    end
end