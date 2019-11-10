% Function t = evolution_illness(t_now,dt,M,dynamic)
% 
% This function evolves `N` times the whole system (illness and
% vaccination) for a time step M*dt and at each step draws one of the
% attributes of the system
% 
% The function returns the final time after these evolutions, mainly: 
%       t = t_now + N*M*dt;
% 

function t = step(t_now,dt,M,dynamic)
    
    if nargin<4
       error('ID:invalid_input','Not enough parameters specified.') 
    elseif dt<=0 || ~isnumeric(M)
        error ('ID:invalid_input','Input parameters are invalid.')
    end
    
    % M the number of steps in the illness big step
    % dynamic is a bool allowing the agents to move
    
    for i=1:M
        t_now = evolution_illness(t_now,dt,dynamic);
    end
    
    %evolution_vaccination();
    
    t = t_now;
    
end