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
       if(mod(i,52) == 0)
           new_season();
       end
       t_now = step(t_now,M,dynamic);
       evolution_vaccination();
       if(drawsystem)
           draw(todraw,i);
           pause(0.0005);
       end
    end
    
    t = t_now;
    
end