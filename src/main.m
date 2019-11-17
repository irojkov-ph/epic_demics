% Function main(t_now,dt,M,dynamic,N)
% 
% This function evolve `M` times the whole system for a time interval `dt`
% with respect to the illness (realized by `evolution_illness.m`) and then
% evolves the choices of vaccination of the whole system (realized by
% `evolution_vaccination.m`).
% 
% The function returns the final time after these evolutions, mainly: 
%       t = t_now + M*dt;
% 

function main()
    
    %number of cells
    n = 80;
    %current time
    t_now = 0;
    %nb of illness step
    M = 100;
    %nb of big steps
    N = 10000;
    %dynamic evolution of the agents
    dynamic = false;
    %to draw an attribute of the system while evolving
    drawsystem = true;
    %choose between 'vaccinated', 'age', 'reward', 'state'
    todraw = 'state';
    
    if ~isnumeric(n)|| ~isnumeric(N)
        error ('ID:invalid_input','Input parameters are invalid.')
    end
    
    system_init(n);
    t_now = evolve_system(t_now,dynamic,M,N,drawsystem,todraw);
    
    
    
end