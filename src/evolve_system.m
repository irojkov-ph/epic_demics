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

function t = evolve_system(t_now,dt,dynamic,M,N,drawsystem,todraw)
    global system;
    if nargin<7
       error('ID:invalid_input','Not enough parameters specified.') 
    elseif dt<=0 || ~isnumeric(M)|| ~isnumeric(N)
        error ('ID:invalid_input','Input parameters are invalid.')
    end
    
     figure
     n = size(system.age,1);
     x1 = 0;
     step_ = 1;
     for i=1:N
         t_now = step(t_now,dt,M,dynamic);
        if(drawsystem)
            %draw(todraw);
            s = (system.state == 'I');
            b = sum(s(:))/(n*n);
            x1 = dynamic_plot(x1,b,i,'r'); %plots average vacc rate over time
            grid on
            pause(0.05);
        end
     end
    
    
    t = t_now;
    
end