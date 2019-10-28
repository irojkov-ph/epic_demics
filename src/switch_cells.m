function system = switch_cells(k,l,m,n,sys)
    system = sys;
    
    % Iterate over all fields of the system structure
    n_fields = fieldnames(system);
    for i=1:numel(n_fields)
        system.(n_fields{i})(k,l)=sys.(n_fields{i})(m,n);
        system.(n_fields{i})(m,n)=sys.(n_fields{i})(k,l);
    end

end