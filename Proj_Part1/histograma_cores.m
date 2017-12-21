function [ R , G , B ] = histograma_cores(PC)

    R = imhist(PC(:,1),4);
    G = imhist(PC(:,2),4);
    B = imhist(PC(:,3),4);

    total = sum(R+G+B);

    %Do percentages of R , G , B 
    R = R/total;
    G = G/total;
    B = B/total;
end
