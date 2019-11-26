% Function t = evolution_illness(t_now,dynamic)
% 
% This function evolves `N` times the whole system (illness and
% vaccination) for M "illness time steps" and at each step draws one of the
% attributes of the system
% 
% The function returns the final time after these evolutions, mainly: 
%       t = t_now + N*dt;
% 

function t = step(t_now,dynamic)
    
    global system;
    
    n = size(system.age,1);
    
    if nargin<2
       error('ID:invalid_input','Not enough parameters specified.') 
    end
    
    % M the number of steps in the illness big step
    % dynamic is a bool allowing the agents to move
    
    t = t_now;
    
    x = randi([1,n]);
    y = randi([1,n]);
    system.state(x,y) = 'I';
    system.reward(x,y) = system.reward(x,y) - 10;
    
    i=0;
    
    while t - t_now < 1
        t = evolution_illness(t,dynamic);
        i = i+1;
    end
    i
    evolution_vaccination();
    sum(sum(system.vaccinated))
    
end