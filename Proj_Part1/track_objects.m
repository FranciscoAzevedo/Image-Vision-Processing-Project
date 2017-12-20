%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    track_objects                                          %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %
%                                                           %
%   Inputs: prev_frame_objects -> Contem os objectos da     %
%   frame anterior o numero de cada objecto que foi         %
%    detetado na frame anterior                             %
%                                                           %
%                                                           %
%                                                           %
%           atual_frame_objects ->Contem os objectos da     %
%           frame atual, as cores da pointcloud,            %
%           
%          n_frame_atual -> numero da frame em que vamos
%
%    Outputs:                                               %
%                                                           %
%    Description: Dado as point clouds de duas frames       %
%    consecutivas, identifica cada objecto nas duas frames  %
%                                                           %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ output_args ] = track_objects( prev_frame_objects, atual_frame_objects, objects, n_frame_atual )
    
    %Erro de 10%
    erro_treshold=0.1;
    % Caso n„o haja nenhum objecto na frame anterior (empty space)
    if isempty(prev_frame_objects)==0
        
        %%% METAM em objects(i).PC_rgb AS CORES DA POINT CLOUD!!!!!!!!!!!!
        %%% Metam em prev_frame_objects(i).n_object que corresponde ao
        %%% numero ao j-th do objects(j)
        
        for i =1:lenght(prev_frame_objects)
            
                 % R G B da frame anterior (RGB È um vetor de quatro elementos)
                [ Rp , Gp , Bp ] = histograma_cores(prev_frame_objects(i).PC_rgb);
                
                for j = 1:lenght(atual_frame_objects)
                       
                        
                        % R G B da frame atual
                         [ Ra , Ga , Ba ] = histograma_cores(atual_frame_objects(j).PC_rgb);
                                             
                        Erro_R=Rp-Ra;
                        Erro_G=Gp-Ga;
                        Erro_B=Bp-Ba;
                        %Erro entre as duas imagens
                        Erro(j)= Erro_R'*Erro_R + Erro_G'*Erro_G + Erro_B'*Erro_B;
                        % fazer diferen√ßas entre entradas da matriz e encontrar
                        %correspondencias entre objetos entre 2 frames - distancias minimas 

                end
                
                
                % Se o erro minimo for menor do que um certo treshold significa
                % que existe um novo objecto em cena
                if (index=min(Erro)<erro_treshold)
                    
                    %i-th object na estrutura objects
                   atual_frame_objects(index).i_th_object = prev_frame_objects(i).i_th_object;
                   
                   % Numero de frames em que objecto foi detetado 
                   atual_frame_objects(index).N_frame_detected = prev_frame_objects(i).N_frame_detected + 1;
                   
                   %Poe os novos cantos nA estrutura objects
                   objects(atual_frame_objects(index).i_th_object ).X(atual_frame_objects(index).N_frame_detected)= atual_frame_objects(index).X;
                   objects(atual_frame_objects(index).i_th_object ).Y(atual_frame_objects(index).N_frame_detected)= atual_frame_objects(index).Y;
                   objects(atual_frame_objects(index).i_th_object ).Z(atual_frame_objects(index).N_frame_detected)= atual_frame_objects(index).Z;
                   % Atualiza o numero da frame que foi trackeada
                   objects(atual_frame_objects(index).i_th_object ).frames_tracked(atual_frame_objects(index).N_frame_detected)=n_frame_atual; 
                                     
                else
                    % new object
                end
        end
    else
        %%%WILD OBJECT APPEARS baaaaaaaaah
        
        
        
    end
end

