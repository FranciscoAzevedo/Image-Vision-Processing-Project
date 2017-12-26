function [ loners ] = find_loners( matches, length )
    loners = [];

    cnt = 1;
    for i = 1:length
        if(isempty(find(matches == i)) == 1)
            loners(cnt) = i;
            cnt = cnt +1;
        end
    end
end

