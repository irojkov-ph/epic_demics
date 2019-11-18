function N = count_nearest_neighbours(k,l,N_lin,N_col)
    [l,c] = nearest_neighbours(k,l,N_lin,N_col);
    
    N = size(l,2)*size(c,2)-1;
    
end