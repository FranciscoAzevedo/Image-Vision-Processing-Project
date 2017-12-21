%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    track_objects                                          %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [objects] = track_objects(prev_frame_objects, actual_frame_objects, objects)
    % Description: Given objects of 2 consecutive frames track objects that
    % are common in both frames and store them in struct "objects"

    % Inputs:      
    % prev_frame_objects -> Struct that has the objects of the previous frame                                                                                                                                     
    % actual_frame_objects -> Struct that has the objects of the actual frame    
    % objects -> Struct that has all the objects 

    % 10% Error threshold
    erro_threshold = 0.1;
    
    % In case there are objects in both frames
    if( isempty(prev_frame_objects) == 0 && isempty(actual_frame_objects) == 0) 
        
        % Lets compare all actual frame objects with prev frame objects to
        % find the best (in case it exists) match
        for i = 1:length(actual_frame_objects)
            
            % R G B of previous frame (RGB � um vetor de quatro elementos)
            [Ra,Ga,Ba] = histograma_cores(actual_frame_objects(i).PC_rgb);

            for j = 1:length(prev_frame_objects)   
                % R G B of actual frame
                [Rp, Gp, Bp] = histograma_cores(prev_frame_objects(j).PC_rgb);

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
            idx = min(Erro);
            if (Erro(idx) < erro_threshold)
                
                % Assignment of the matched actual frame object to "objects"
                init = length(objects);
                objects(prev_frame_objects.index(idx)).X(init + 1,:) = actual_frames_objects(i).X(1,:); 
                objects(prev_frame_objects.index(idx)).Y(init + 1,:) = actual_frames_objects(i).Y(1,:); 
                objects(prev_frame_objects.index(idx)).Z(init + 1,:) = actual_frames_objects(i).Z(1,:);
                objects(prev_frame_objects.index(idx)).frames_tracked(init + 1) = actual_frames_objects(i).frames_tracked;  
          
                objects(actual_frames_objects(i).index) = [];   
            end
        end
        
        % Updates objects struct after tracking (cleaning stuff)
        
        
    end
end