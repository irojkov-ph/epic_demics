% Function status =  switch_cells(k,l,m,n)
% 
% This function is switching values of cells (k,l) and (m,n) in all  
% matrices of the system.
% 
% 

function status = switch_cells(k,l,m,n)
    status = -1;
    global system
    
    N_lin = size(system.age,1);
    N_col = size(system.age,2);
    
    if k<1 || k>N_lin || l<1 || l>N_col || ...
       m<1 || m>N_lin || n<1 || n>N_col
       error('ID:invalid_input','The specified indices are out of range')
    end
    
    % Iterate over all fields of the system structure
    n_fields = fieldnames(system);
    for i=1:numel(n_fields)
        if ~strcmp('cfg',n_fields{i})
            tmp =  system.(n_fields{i}); 
            system.(n_fields{i})(k,l)=tmp(m,n);
            system.(n_fields{i})(m,n)=tmp(k,l);
        end
    end
    
    status = 1;
end