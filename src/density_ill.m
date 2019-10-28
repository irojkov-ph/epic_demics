function y = density_ill(sys,k,l)
    
    N_lin = size(sys,1);
    N_col = size(sys,2);
    
    id_lin = [k-1,k,k+1];
    id_col = [l-1,l,l+1];
    
    N_cells = 0;
    N_I = 0;
    
    for i = 1:3
        
        for j = 1:3
            if(id_lin(i)>=1 && id_lin(i)<=N_lin && id_col(j)>=1 && id_col(j)<=N_col && (i~=2 || j~=2) )
                %if we are in the boundaries of the grid and not in (k,l)
                N_cells = N_cells + 1;
                if(sys(id_lin(i),id_col(j)).state == 'I')
                    N_I = N_I + 1;
                end
            end
        end
        
    end
    y = N_I./N_cells;
    
end