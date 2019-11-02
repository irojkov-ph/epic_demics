function status = switch_cells(k,l,m,n)
    status = -1;
    global system
    
    % Iterate over all fields of the system structure
    n_fields = fieldnames(system);
    for i=1:numel(n_fields)
        tmp =  system.(n_fields{i}); 
        system.(n_fields{i})(k,l)=tmp(m,n);
        system.(n_fields{i})(m,n)=tmp(k,l);
    end
    
    status = 1;
end