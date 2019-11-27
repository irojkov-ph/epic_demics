% Function t = evolution_illness(t_now,dynamic)
% 
% This function evolves the whole system (illness, realized by 
% `evolution_illness.m` and vaccination, realised by 
% `evolution_vaccination.m`) for one ´vaccination step´.
% The vaccination decision is taken every week.
% The bool variable dynamic gives wether we want the agents to be able
% to displace during the simulation or not
% 
% The function returns the final time t after these evolutions, mainly
% 

function t = step(t_now,dynamic)
    
    if nargin<2
       error('ID:invalid_input','Not enough parameters specified.') 
    end
    
    t = t_now;
    
    % During one week the illness evolves
    while t - t_now < 1
        t = evolution_illness(t,dynamic);
    end
    
    % The agents decide wether to vaccinate or not
    evolution_vaccination();
    
end