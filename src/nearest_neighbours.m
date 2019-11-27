% Function N_cells = count_nearest_neighbours(k,l)
%
% This function returns the valid indices of the nearest neighbours 
% of cell (k,l)
% 


function [id_lin, id_col] = nearest_neighbours(k,l)
    
    global system
    
    n = size(system.age,1);
    
    if nargin<4
       error('ID:invalid_input','The function has to take 4 parameters.')
    end
    
    id_lin = k;
    id_col = l;
    
    
    if(k>1)
        id_lin = [k-1,id_lin];
    end
    if(k<n)
        id_lin = [id_lin,k+1];
    end
    if(l>1)
        id_col = [l-1,id_col];
    end
    if(l<n)
        id_col = [id_col,l+1];
    end
    
    
end