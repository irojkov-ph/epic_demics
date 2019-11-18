% Function N_cells = count_nearest_neighbours(k,l,N_lin,N_col)
% 
% This function counts the number of nearest neighbours of the cell (k,l) 
% in a square lattice of size `N_lin x N_col`.
% 
%%%%% TO IMPROVE: if we allow to change the geometry we have to rewrite
%%%%% this fuction.
% 


function [id_lin, id_col] = nearest_neighbours(k,l,N_lin,N_col)
    
    if nargin<4
       error('ID:invalid_input','The function has to take 4 parameters.')
    end
    
    id_lin = k;
    id_col = l;
    
    
    if(k>1)
        id_lin = [k-1,id_lin];
    end
    if(k<N_lin)
        id_lin = [id_lin,k+1];
    end
    if(l>1)
        id_col = [l-1,id_col];
    end
    if(l<N_col)
        id_col = [id_col,l+1];
    end
    
    
end