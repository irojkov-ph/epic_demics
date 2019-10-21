function [t,system] = evolution_illness(t_now,dt,M,sys)
    
    % dt is the small time step in which only one evenement happens
    % sys matrix of structures containing the people
    % M is the number of times we choose a random case
    
    Nlin = size(sys,1);
    Ncol = size(sys,2);
    
    for i=1:M
        
        k = floor(rand.*(Nlin+1));
        l = floor(rand.*(Ncol+1));
        
        [t_now,sys] = evolve_cell(t_now,dt,sys,k,l);
        
    end
    
    t = t_now;
    system = sys;
end