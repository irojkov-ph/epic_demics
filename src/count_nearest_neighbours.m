% Function N = count_nearest_neighbours(k,l)
% 
% This function counts the nearest neighbours to cell (k,l)
%

function N = count_nearest_neighbours(k,l)

    [l,c] = nearest_neighbours(k,l);
    
    N = size(l,2)*size(c,2)-1;
    
end