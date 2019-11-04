function t = evolution_illness(t_now,dt,dynamic)
    
    % dt is the small time step in which only one evenement happens
    % M is the number of times we choose a random cell
    
    global system
    
    Nlin = size(system,1);
    Ncol = size(system,2);
    
    k = floor(rand.*(Nlin)+1);
    l = floor(rand.*(Ncol)+1);
    
    if(k<1)
       k=1; 
    elseif(k>Nlin)
       k=Nlin;
    end
    if(l<1)
        l=1;
    elseif(l>Ncol)
        l=Ncol;
    end
        
    t_now = evolve_cell(t_now,dt,k,l);
    
    if(dynamic)
        try
            displacement(k,l);
        catch
            error('ID:move_fail','The execution of ''displacement'' function failed.')
        end
    end
    
    t = t_now;
end