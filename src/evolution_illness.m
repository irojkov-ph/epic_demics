% Function t = evolution_illness(t_now,dynamic)
% 
% This function evolves the illness on the "whole" system for a time step.
% 
% The evolution of the system is programmed randomly, i.e. the cell which
% will evolve during this time interval is chosen randomly using two 
% uniform variables.
% 
% As it is meant in the title of the function, it evolves only the illness
% throughout the system at not the vaccination choices.
% 
% If the ´dynamic´ bool variable is true, then the agents have the
% possibility to change position during the simulation
% 
% The function returns the time returned by `evolve_cell.m`
% 


function t = evolution_illness(t_now,dynamic)
        
    if nargin<2
       error('ID:invalid_input','No input specified')
    end
    
    global system
    
    Nlin = size(system.age,1);
    Ncol = size(system.age,2);
    
    % the cell to evolve is chosen randomly following two uniform random
    % variables
    
    k=randi([1,Nlin]);
    l=randi([1,Ncol]);

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
    
    % The (k,l) cell is evolved
    t_now = evolve_cell(t_now,k,l);
    
    % If the dynamic mode was chosen, (k,l) cell has the opportunity to
    % displace
    if(dynamic)
        try
            displacement(k,l);
        catch
            error('ID:move_fail','The execution of ''displacement'' function failed.')
        end
    end
    
    t = t_now;
end