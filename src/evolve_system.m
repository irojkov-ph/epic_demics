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
    
     figure
     n = size(system.age,1);
     x_S = 0;
     x_I = 0;
     x_R = 0;
     for i=1:N
         t_now = step(t_now,M,dynamic);
        if(drawsystem)
            
%             draw(todraw);
            
            s_S = (system.state == 'S');
            b_S = sum(s_S(:))/(n*n);
            x_S = dynamic_plot(x_S,b_S,i,'g'); %plots average vacc rate over time
            grid on
            hold on
            s_I = (system.state == 'I');
            b_I = sum(s_I(:))/(n*n);
            x_I = dynamic_plot(x_I,b_I,i,'r'); %plots average vacc rate over time
            grid on
            hold on
            s_R = (system.state == 'R');
            b_R = sum(s_R(:))/(n*n);
            x_R = dynamic_plot(x_R,b_R,i,'b'); %plots average vacc rate over time
            grid on
            hold on
            
            pause(0.005);
        end
     end
    
    
    t = t_now;
    
end