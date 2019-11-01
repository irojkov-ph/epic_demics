function [t,system] = evolution_illness(t_now,mean_dt,sys,dynamic)
    
    % dt is the small time step in which only one evenement happens
    % sys matrix of structures containing the people
    % M is the number of times we choose a random cell
    
    Nlin = size(sys,1);
    Ncol = size(sys,2);
    
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
    
    %time is chosen exponentially
    dt=interval(mean_dt);
    
    [t_now,sys] = evolve_cell(t_now,dt,sys,k,l);
    
    if(dynamic)
        sys = displacement(sys,k,l);
    end
    
    t = t_now;
    system = sys;
end