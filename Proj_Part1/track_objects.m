function [ output_args ] = track_objects( objects )

    %funcao tem de receber os objetos da 1a frame já merged e os objetos da
    %2a frame merged... (?)
    
    %1.transformar point cloud do objeto da frame 1 numa imagem RGB com a funcao
    %rgb = readRGB(pcloud)
    %2.calcular histograma e normalizá-lo com o número total de pixeis da
    %imagem
    
    %3.transformar point cloud do objeto da frame 2 numa imagem RGB com a funcao
    %rgb = readRGB(pcloud)
    %4.calcular histograma e normalizá-lo com o número total de pixeis da
    %imagem
    
    %5.guardar os histogramas como matrizes 4x3 - 4 porque temos 4
    %bins/cores; 3 porque existem 3 componentes (R,G,B)
    
    %6. fazer diferenças entre entradas da matriz e encontrar
    %correspondencias entre objetos entre 2 frames - distancias minimas 


end

