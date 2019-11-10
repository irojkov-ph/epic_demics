addpath('..\src');


n = 2000; %n*n == number of people
S = system_init(n);
%evolution(S,10);%currently plots average vacc and non-vacc rate over time
% figure
% draw(S,'reward');
figure
draw(S,"age");
% figure
% draw(S,'vaccinated');
% figure
% draw_(S,'state');

% tests

%this is a simplified init function that is only used for testing
%once this file is joined with the others this fct should be deleted
function [sys]=system_init(n)

    % Creating the age matrix (one can remove `round` if we assume decimal ages)
    age = round(100*rand(n));

    % Creating the rewards matrix
    r = rand(n);

    % Creating the vaccination matrix
    vaccin = round(rand(n));

    % Creating the state matrix
    state = string(ones(n));
    for i = 1:n
        for j =1:n
            rv = round(rand*2);
            if(rv == 0)
                state(i,j) = "I";
            end
            if(rv == 1)
                state(i,j) = "S";
            end
            if(rv == 2)
                state(i,j) = "R";
            end
        end
    end


    % Filling the system structure
    sys.state = state;
    sys.vaccin = vaccin;
    sys.r = r;
    sys.age = age;    

end

%this fct implements the time evolution of the system
%it should also be replaced once tis file is merged with the others
function evolution(sys,T)
    figure
    n = size(sys.age,1);
    t = 0 ;
    x1 = 0 ;
    x2 = 0;
    step = 0.1 ;
    while(t < T)
        sys = evolve_sys(sys);
        b = sum(sys.vaccin(:))/(n*n);
        x1 = dynamic_plot(x1,b,t,step,'r'); %plots average vacc rate over time
        hold on
        grid on
        x2 = dynamic_plot(x2,1-b,t,step,'b');% plots average non-vacc rate
        t = t + step;
        pause(0.05)
    end
end

%this fct makes very simple time evolutions at each time step
%it should also be replaced when this file merges with the others
function [sys]=evolve_sys(sys)
    n = size(sys.age,1);
    sys.age = sys.age + 1;
    for i = 1:n
        for j =1:n
            if(sys.age(i,j) > 100)
                sys.age(i,j) = 0;
            end
            sys.vaccin(i,j) = round(rand);
        end
    end
end