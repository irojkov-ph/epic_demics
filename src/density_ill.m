% Function y = density_ill(k,l)
%
% This function takes as inputs two indices `k` and `l` and returns a 
% quantity `y` which corresponds to the local density of cells in state 
% "I" (Infected) around the position (k,l).
% 


function y = density_ill(k,l)
    global system
    
    if k<1 || l<1
       warning('ID:invalid_input',['The specified indices are out of range.\n', ...
                                   'The density is therefore null.'])
       y=0;
       return
    end
    
    [id_lin,id_col] = nearest_neighbours(k,l);
    
    N_cells = 0;
    N_I = 0;
    
    for i = 1:size(id_lin,2)
        for j = 1:size(id_col,2)
            % If not in (k,l)
            if(id_lin(i)~=k || id_col(j)~=l)
                N_cells = N_cells + 1;
                if(system.state(id_lin(i),id_col(j)) == 'I')
                    N_I = N_I + 1;
                end
                
            end
        end
    end
    
    if N_cells~=0, y = N_I./N_cells; end
    
end