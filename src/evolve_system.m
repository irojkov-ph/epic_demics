% Function t = evolution_system(t_now,dt,dynamic,N,drawsystem)
% 
% This function evolve `M` times the whole system for a time interval `dt`
% with respect to the illness (realized by `evolution_illness.m`) and then
% evolves the choices of vaccination of the whole system (realized by
% `evolution_vaccination.m`).
% 
% The function returns the final time after these evolutions, mainly: 
%       t = t_now + dt;
% 


function t = evolve_system(t_now,dynamic,N,drawsystem,todraw)
    global system;
    
    n = size(system.age,1);

    if nargin<5
       error('ID:invalid_input','Not enough parameters specified.') 
    elseif ~isnumeric(N)
        error ('ID:invalid_input','Input parameters are invalid.')
    end
    
    % Reward of a person to get infected
    if isfield(system.cfg,'r_ill') && ~isnan(system.cfg.r_ill)
        r_ill = system.cfg.r_ill;
    else
        r_ill=-10;
    end
    
    for i=1:N
        if(mod(i,1) == 0)
            x = randi([1,n]);
            y = randi([1,n]);
            system.state(x,y) = 'I';
            system.reward(x,y) = system.reward(x,y) + r_ill;
        end
        t_now = step(t_now,dynamic);
        if(drawsystem)
            draw(todraw,t_now);
            pause(0.0005);
        end
    end
    
    t = t_now;
    
end