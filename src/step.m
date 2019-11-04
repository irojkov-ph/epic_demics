function t = step(t_now,dt,M,dynamic)
    
    % M the number of steps in the illness big step
    % dynamic is a bool allowing the agents to move
    
    for i=1:M
        t_now = evolution_illness(t_now,dt,dynamic);
    end
    
    % evolution_vaccination(sys)
    
    t = t_now;
    
end