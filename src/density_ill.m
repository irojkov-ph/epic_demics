% Function y = density_ill(k,l)
%
% This function takes as inputs two indices `k` and `l` and returns a 
% quantity `y` which corresponds to the local density of cells in state 
% "I" (Infected) around the position (k,l).
% 


function y = density_ill(k,l)
    global system

    N_lin = size(system.age,1);
    N_col = size(system.age,2);
    
    if k<1 || k>N_lin || l<1 || l>N_col
       warning('ID:invalid_input',['The specified indices are out of range.\n', ...
                                   'The density is therefore null.'])
       y=0;
       return
    end
    
    id_lin = [k-1,k,k+1];
    id_col = [l-1,l,l+1];
    
    N_cells = 0;
    N_I = 0;
    
    for i = 1:3
        for j = 1:3
            % If we are in the boundaries of the grid and not in (k,l)
            if(id_lin(i)>=1 && id_lin(i)<=N_lin && ...
               id_col(j)>=1 && id_col(j)<=N_col && (i~=2 || j~=2) )
                
                N_cells = N_cells + 1;
                if(system.state(id_lin(i),id_col(j)) == 'I')
                    N_I = N_I + 1;
                end
                
            end
        end
    end
    
    if N_cells~=0, y = N_I./N_cells; end
    
end