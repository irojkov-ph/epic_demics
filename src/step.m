% Function t = evolution_illness(t_now,M,dynamic)
% 
% This function evolves `N` times the whole system (illness and
% vaccination) for M "illness time steps" and at each step draws one of the
% attributes of the system
% 
% The function returns the final time after these evolutions, mainly: 
%       t = t_now + N*M*dt;
% 

function t = step(t_now,M,dynamic)
    
    if nargin<3
       error('ID:invalid_input','Not enough parameters specified.') 
    elseif ~isnumeric(M)
        error ('ID:invalid_input','Input parameters are invalid.')
    end
    
    % M the number of steps in the illness big step
    % dynamic is a bool allowing the agents to move
    
    t = t_now;
    
    while t - t_now < 1
        t = evolution_illness(t,dynamic);
    end
    
    %evolution_vaccination();
    
end