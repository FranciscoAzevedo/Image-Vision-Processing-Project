function ret = create_matched_xyz( subset, imd1, f1, imd2, f2)
% This function creates the matches between 2 PC, which means it
% will get, in both PC's, the points choosen by the SIFT (lord)

    P1 = []; P2 = [];
    
    % For each match
    for k=1:size(subset,2)
        
        i1 = subset(1,k);
        
        % Get xyz points in PC1 indexed by the matches of each subset
        x1 = imd1(round(f1(2,i1)), round(f1(1,i1)), 1);
        y1 = imd1(round(f1(2,i1)), round(f1(1,i1)), 2);
        z1 = imd1(round(f1(2,i1)), round(f1(1,i1)), 3);

        i2 = subset(2,k);
        
        % Get xyz points in PC2 indexed by the matches of each subset
        x2 = imd2(round(f2(2,i2)), round(f2(1,i2)), 1);
        y2 = imd2(round(f2(2,i2)), round(f2(1,i2)), 2);
        z2 = imd2(round(f2(2,i2)), round(f2(1,i2)), 3);

        P1 = [P1 [x1;y1;z1]];
        P2 = [P2 [x2;y2;z2]];
        
    end
    
    ret.P1 = P1; ret.P2 = P2;
    
end