function [t,system] = step(t_now,sys,dt,M,dynamic)
    
    % M the number of steps in the illness big step
    % dynamic is a bool allowing the agents to move
    
    for i=1:M
        [t_now,sys] = evolution_illness(t_now,dt,sys,dynamic);
    end
    
    % evolution_vaccination(sys)
    
    t = t_now;
    system = sys;
    
end