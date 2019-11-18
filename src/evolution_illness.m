% Function t = evolution_illness(t_now,dynamic)
% 
% This function evolve the "whole" system for a time step.
% 
% The evolution of the system is programmed randomly, i.e. the cell which
% will evolve during this time interval is chosen randomly.
% 
% As it is meant in the title of the function, it evolves only the illness
% throughout the system at not the vaccination choices.
% 
% The function returns the time returned by `evolve_cell.m`
% 


function t = evolution_illness(t_now,dynamic)
    
    % dt is the small time step in which only one evenement happens
    % M (in step.m) is the number of times we choose a random cell
        
    if nargin<2
       error('ID:invalid_input','No input specified')
    end
    
    global system
    
    Nlin = size(system.age,1);
    Ncol = size(system.age,2);
    
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
        
    t_now = evolve_cell(t_now,k,l);
    
    if(dynamic)
        try
            displacement(k,l);
        catch
            error('ID:move_fail','The execution of ''displacement'' function failed.')
        end
    end
    
    t = t_now;
end