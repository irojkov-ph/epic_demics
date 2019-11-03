% Function N_cells = count_nearest_neighbours(k,l,N_lin,N_col)
% 
% This function counts the number of nearest neighbours of the cell (k,l) 
% in a square lattice of size `N_lin x N_col`.
% 
%%%%% TO IMPROVE: if we allow to change the geometry we have to rewrite
%%%%% this fuction.
% 


function N_cells = count_nearest_neighbours(k,l,N_lin,N_col)
    N_cells = 0;
    
    if nargin<4
       error('ID:invalid_input','The function has to take 4 parameters.')
    end
    
    id_lin = [k-1,k,k+1];
    id_col = [l-1,l,l+1];
    
    for i = 1:3

        for j = 1:3
            
            % Check if we are in the boundaries of the grid and not in (k,l)
            if(id_lin(i)>=1 && id_lin(i)<=N_lin && ...
               id_col(j)>=1 && id_col(j)<=N_col && (i~=2 || j~=2) )
                
                N_cells = N_cells + 1;
            
            end
            
        end
        
    end
    
end