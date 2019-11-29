% Function t = evolution_system(t_now,N,vaccination,dynamic, drawsystem, todraw)
% 
% This function evolves `N` times the whole system and, if the bool
% variable `drawsystem` is set to true, draws the parameters given in
% string vector `todraw` at each step.
%
% `vaccination` and `dynamic` are boolean determining whether the agents
% can vaccinate and/or move in the system.
%
% The function returns the final time t after these evolutions
% 


function t = evolve_system(t_now,N,vaccination,dynamic,drawsystem,todraw)
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
            if ~isnan(system.cfg.patient_zero_coord)
                x = system.cfg.patient_zero_coord(1);
                y = system.cfg.patient_zero_coord(2);
                [x_n, y_n] = nearest_neighbours(x,y);
                if system.cfg.p_zero_plus_neighbours
                    system.state(x_n,y_n) = 'I';
                    system.reward(x_n,y_n) = system.reward(x_n,y_n) + r_ill;
                end
            else
                x = randi([1,n]);
                y = randi([1,n]);
            end
            system.state(x,y) = 'I';
            system.reward(x,y) = system.reward(x,y) + r_ill;
        end
        t_now = step(t_now,vaccination,dynamic);
        if(drawsystem)
            draw(todraw,t_now);
            pause(0.0005);
        end
    end
    
    t = t_now;
    
end