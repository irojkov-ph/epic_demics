% Function t = evolution_system(t_now,dt,dynamic,M,N,drawsystem)
% 
% This function evolve `M` times the whole system for a time interval `dt`
% with respect to the illness (realized by `evolution_illness.m`) and then
% evolves the choices of vaccination of the whole system (realized by
% `evolution_vaccination.m`).
% 
% The function returns the final time after these evolutions, mainly: 
%       t = t_now + M*dt;
% 


function t = evolve_system(t_now,dynamic,M,N,drawsystem,todraw)
    global system;
    if nargin<6
       error('ID:invalid_input','Not enough parameters specified.') 
    elseif ~isnumeric(M)|| ~isnumeric(N)
        error ('ID:invalid_input','Input parameters are invalid.')
    end
    
    for i=1:N
       t_now = step(t_now,M,dynamic);
       if(drawsystem)
           draw(todraw,t_now);
           pause(0.005);
       end
    end
    
    t = t_now;
    
end