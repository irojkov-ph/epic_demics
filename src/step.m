% Function t = evolution_illness(t_now,vaccination,dynamic)
% 
% This function evolves the whole system (illness, realized by 
% `evolution_illness.m` and vaccination, realised by 
% `evolution_vaccination.m`) for one vaccination step.
% The vaccination decision is taken every week.
%
% `vaccination` and `dynamic` are boolean determining whether the agents
% can vaccinate and/or move in the system.
% 
% The function returns the final time t after these evolutions, mainly
% 

function t = step(t_now,vaccination,dynamic)
    
    if nargin<2
       error('ID:invalid_input','Not enough parameters specified.') 
    end
    
    t = t_now;
    
    % During one week the illness evolves
    while t - t_now < 1
        t = evolution_illness(t,dynamic);
    end
    
    % The agents decide wether to vaccinate or not
    if vaccination
        evolution_vaccination();
    end
end