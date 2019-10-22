function N_cells=count_nearest_neighbours(k,l,N_lin,N_col)
    N_cells = 0;
    
    id_lin = [k-1,k,k+1];
    id_col = [l-1,l,l+1];
    
    for i = 1:3

        for j = 1:3
            
            if(id_lin(i)>=1 && id_lin(i)<=N_lin && id_col(j)>=1 && id_col(j)<=N_col && (i~=2 || j~=2) )
                %if we are in the boundaries of the grid and not in (k,l)
                N_cells = N_cells + 1;
            end
            
        end
        
    end
    
end