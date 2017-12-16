function [nmatches, matches,f1, d1, f2, d2,] = sift_match(im1, imd1, im2, imd2)
    
    % Convert to grayscale
    im1g = rgb2gray(im1)
    im2g = rgb2gray(im2)
    
    % Convert to single (documentation recommends it)
    im1g = im2single(im1g) ;
    im2g = im2single(im2g) ;

    % Get sift descriptors 
    % Each column of F is a feature frame and has the format [X;Y;S;TH]
    % Where X,Y is the (fractional) center of the frame, S is the scale 
    % and TH is the orientation (in radians)
    [f1,d1] = vl_sift(im1g) ;
    [f2,d2] = vl_sift(im2g) ;

    thres = 7;

    % Match descriptors regarding a decreasing threshold + exclude invalid depth points
    while thres > 1.5

        % Get descriptors match
        [matches, scores] = vl_ubcmatch(d1,d2,thres) ;

        matches_ = [];
        scores_ = [];

        % Get rid of invalid depth values
        for j=1:size(matches,2)
            
            z1 = imd1(round(f1(2,matches(1,j))), round(f1(1,matches(1,j))), 3);
            z2 = imd2(round(f2(2,matches(2,j))), round(f2(1,matches(2,j))), 3);
            
            if z1~=0 && z2~=0
                matches_ = [matches_ matches(:,j)];
                scores_ = [scores_ scores(j)];
            end
        end


        matches = matches_; 
        scores = scores_;
        nmatches = size(matches,2);

        % Enough points for R and T estimate
        if nmatches >= 10,
            break;
        end

        thres = thres - 0.5;
    end

    % Just in case things dont work out how they should...
    if nmatches < 10 && thres == 1.5
        valid = false;
        nmatches = []; matches= []; PP1 = []; PP2 = []; f1 = []; d1 = []; f2 = [];  d2 = []; scores =[];
        disp('there is no valid matching between these two images');
        return;
    end

end