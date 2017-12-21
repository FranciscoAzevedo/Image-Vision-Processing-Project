%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    track_objects                                          %
%    Program developed by:     Francisco Azevedo (80966)    %
%                              Luis Almeida (81232)         %
%                              Francisco Pereira (81381)    %                   
%                                                           %
%    At IST, Lisbon 2017                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [objects] = track_objects(prev_frame_objects, atual_frame_objects, objects, n_frame_atual )
    %Description: Dado as point clouds de duas frames       
    %consecutivas, identifica cada objecto nas duas frames     

    %Inputs: prev_frame_objects -> Contem os objectos da     
    %frame anterior o numero de cada objecto que foi         
    %detetado na frame anterior                                                                                
                                                          
    %atual_frame_objects ->Contem os objectos da     
    %frame atual, as cores da pointcloud,            
    %n_frame_atual -> numero da frame em que vamos                                              

    %Erro de 10%
    erro_treshold = 0.1;
    
    % Caso haja um objecto na frame anterior
    if( isempty(prev_frame_objects) == 0 && isempty(atual_frame_objects) == 0) 
        
        % METAM em objects(i).PC_rgb AS CORES DA POINT CLOUD!!!!!!!!!!!!
        % Metam em prev_frame_objects(i).n_object que corresponde ao
        % numero ao j-th do objects(j)
        
        for i = 1:length(atual_frame_objects)
            % R G B da frame anterior (RGB � um vetor de quatro elementos)
            [Ra,Ga,Ba] = histograma_cores(atual_frame_objects(i).PC_rgb);

            for j = 1:length(prev_frame_objects)   
                % R G B da frame atual
                [Rp, Gp, Bp] = histograma_cores(prev_frame_objects(j).PC_rgb);

                % Dist�ncias entre histogramas de cada componente da cor
                % Entre duas frames
                Erro_R = Rp-Ra;
                Erro_G = Gp-Ga;
                Erro_B = Bp-Ba;
                
                % Erro entre as duas imagens (soma do quadrado dos erros)
                Erro(j)= Erro_R'*Erro_R + Erro_G'*Erro_G + Erro_B'*Erro_B; 
            end

            % Se o erro minimo for menor do que um certo treshold significa
            % que existe o mesmo objecto em ambas frames (match)
            index = min(Erro)
            if (index < erro_treshold)

               % i-th object na estrutura objects
               atual_frame_objects(i).i_th_object = prev_frame_objects(index).i_th_object;

               % Numero de frames em que objecto foi detetado 
               % atual_frame_objects(i).N_frame_detected = prev_frame_objects(index).N_frame_detected + 1;

               %Poe os novos cantos nA estrutura objects
               objects(atual_frame_objects(i).i_th_object ).X(atual_frame_objects(i).N_frame_detected)= atual_frame_objects(i).X;
               objects(atual_frame_objects(i).i_th_object ).Y(atual_frame_objects(i).N_frame_detected)= atual_frame_objects(i).Y;
               objects(atual_frame_objects(i).i_th_object ).Z(atual_frame_objects(i).N_frame_detected)= atual_frame_objects(i).Z;
               % Atualiza o numero da frame que foi trackeada
               objects(atual_frame_objects(i).i_th_object ).frames_tracked(atual_frame_objects(i).N_frame_detected)=n_frame_atual; 
            else
               % new object
               atual_frame_objects(i).i_th_object=lenght(object);
               % Primeira frame :)
               atual_frame_objects(i).N_frame_detected = 1;

               objects(atual_frame_objects(i).i_th_object ).X(atual_frame_objects(i).N_frame_detected)= atual_frame_objects(i).X;
               objects(atual_frame_objects(i).i_th_object ).Y(atual_frame_objects(i).N_frame_detected)= atual_frame_objects(i).Y;
               objects(atual_frame_objects(i).i_th_object ).Z(atual_frame_objects(i).N_frame_detected)= atual_frame_objects(i).Z;
               % Atualiza o numero da frame que foi trackeada
               objects(atual_frame_objects(i).i_th_object ).frames_tracked(atual_frame_objects(i).N_frame_detected)=n_frame_atual;       
            end
        end
        % Atualiza o prev_frame e limpa o prev_.... de modo a n�o termos
        % problema, no sei se isto impporta muito
        clear var prev_frame_objects;
        prev_frame_objects =  atual_frame_objects;
    end
end

