% Function t = evolution_system(t_now,dynamic,N, drawsystem, todraw)
% 
% This function evolves `N` times the whole system and, if the bool
% variable ´drawsystem´ is set to true, draws the parameters given in
% string vector ´todraw´ at each step.
% 
% The function returns the final time t after these evolutions
% 


function t = evolve_system(t_now,dynamic,N,drawsystem,todraw)
    if nargin<5
       error('ID:invalid_input','Not enough parameters specified.') 
    elseif ~isnumeric(N)
        error ('ID:invalid_input','Input parameters are invalid.')
    end
    
    for i=1:N
       t_now = step(t_now,dynamic);
       if(drawsystem)
           draw(todraw,t_now);
           pause(0.0005);
       end
    end
    
    t = t_now;
    
end