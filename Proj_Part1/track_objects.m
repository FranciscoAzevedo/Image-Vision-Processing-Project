%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    track_objects                                          %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %                   
%                                                           %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [objects] = track_objects(prev_frame_objects, actual_frame_objects, objects, n_frame_actual )
    %Description: Dado as point clouds de duas frames       
    %consecutivas, identifica cada objecto nas duas frames     

    %Inputs: prev_frame_objects -> Contem os objectos da     
    %frame anterior o numero de cada objecto que foi         
    %detetado na frame anterior                                                                                
                                                          
    %actual_frame_objects ->Contem os objectos da     
    %frame atual, as cores da pointcloud,            
    %n_frame_atual -> numero da frame em que vamos                                              

    %Erro de 10%
    erro_treshold = 0.1;
    
    % Caso haja objectos em ambas as frames
    if( isempty(prev_frame_objects) == 0 && isempty(actual_frame_objects) == 0) 
        
        for i = 1:length(actual_frame_objects)
            % R G B da frame anterior (RGB é um vetor de quatro elementos)
            [Ra,Ga,Ba] = histograma_cores(actual_frame_objects(i).PC_rgb);

            for j = 1:length(prev_frame_objects)   
                % R G B da frame atual
                [Rp, Gp, Bp] = histograma_cores(prev_frame_objects(j).PC_rgb);

                % Distâncias entre histogramas de cada componente da cor
                % Entre duas frames
                Erro_R = Rp-Ra;
                Erro_G = Gp-Ga;
                Erro_B = Bp-Ba;
                
                % Erro entre as duas imagens (soma do quadrado dos erros)
                Erro(j)= Erro_R'*Erro_R + Erro_G'*Erro_G + Erro_B'*Erro_B; 
            end

            % Se o erro minimo for menor do que um certo treshold significa
            % que existe o mesmo objecto em ambas frames (match)
            idx = min(Erro);
            if (idx < erro_treshold)
                
                init = length(objects);
                objects(idx).X(init + 1,:) = actual_frames_objects(i).X(1,:); 
                objects(idx).Y(init + 1,:) = actual_frames_objects(i).Y(1,:); 
                objects(idx).Z(init + 1,:) = actual_frames_objects(i).Z(1,:);
                objects(idx).frames_tracked(init + 1) = actual_frames_objects(i).frames_tracked;
                objects(actual_frames_objects(i).index) = [];
                
            end
        end
        
        % Atualiza o prev_frame_objects de modo a não termos problemas
        % Não sabemos se isto importa muito
        clear var prev_frame_objects;
        prev_frame_objects =  actual_frame_objects;
    end
end