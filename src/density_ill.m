function y = density_ill(k,l)
    global system

    N_lin = size(system.age,1);
    N_col = size(system.age,2);
    
    id_lin = [k-1,k,k+1];
    id_col = [l-1,l,l+1];
    
    N_cells = 0;
    N_I = 0;
    
    for i = 1:3
        
        for j = 1:3
            if(id_lin(i)>=1 && id_lin(i)<=N_lin && id_col(j)>=1 && id_col(j)<=N_col && (i~=2 || j~=2) )
                % If we are in the boundaries of the grid and not in (k,l)
                N_cells = N_cells + 1;
                if(system.state(id_lin(i),id_col(j)) == 'I')
                    N_I = N_I + 1;
                end
            end
        end
        
    end
    y = N_I./N_cells;
    
end