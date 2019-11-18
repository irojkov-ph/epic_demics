% Function main(t_now,dt,M,dynamic,N)
%
% The function returns the final time after these evolutions, mainly: 
%       t = t_now + N*M*dt;
% 

function main()
    
    % UNITS OF TIME (totaly subjective) -------------> a week 

    %number of cells --------------------------------> 10⁴ persons
    n = 100;
    %current time -----------------------------------> 0 (obvious) 
    t_now = 0;
    %nb of illness step -----------------------------> 80% of the population
    M = .8 * n*n;
    %time between two evolution_vaccination step ----> 1 week
    T = 1;
    %interval between two SIR steps
    dt = T/M;
    %nb of big steps --------------------------------> 2 year 
    N = 104;
    
    
    %dynamic evolution of the agents
    dynamic = false;
    %to draw an attribute of the system while evolving
    drawsystem = true;
    %choose between "vaccinated", "age", "reward", "state", "state_density"
    todraw = ["state_density";"state";"vaccinated";"reward"];
    
    if dt<=0 || ~isnumeric(n)|| ~isnumeric(N)
        error ('ID:invalid_input','Input parameters are invalid.')
    end
    
    system_init(n);
    t_now = evolve_system(t_now,dt,dynamic,M,N,drawsystem,todraw);
end


