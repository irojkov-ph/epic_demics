n = 100; %n*n == number of people
S = system_init(n);
evolution(S,10);%currently plots average vacc and non-vacc rate over time
% figure
% draw_reward(S);
% figure
% draw_age(S);
% figure
% draw_vaccinated(S);
% figure
% draw_state(S);

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
        x1 = plot_stuff(x1,b,t,step,'r'); %plots average vacc rate over time
        hold on
        grid on
        x2 = plot_stuff(x2,1-b,t,step,'b');% plots average non-vacc rate
        t = t + step;
        pause(0.05)
    end
end

%this fct plots values b as the system evolves and moves the x axis
%accordingly
function y=plot_stuff(x,b,t,step,colour)
    y = [ x, b ];
    plot(x,colour);
    if ((t/step)-50 < 0)
        startSpot = 0;
    else
        startSpot = (t/step)-50;
    end
    axis([ startSpot, (t/step+10), 0, 1]);
    drawnow;
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

%draw_vaccinated draws a map of the population, coloured according to their
%vaccination choice
function draw_vaccinated(sys)
    n = size(sys.vaccin,1);
    x = 1:n;
    y = 1:n;
    Z = sys.vaccin;
    map = [1 0 0; 0 0 1];
    colormap(map);
    image(x,y,Z,'CDataMapping','scaled');
    colorbar('Ticks',[0,1],'TickLabels',{'Not vacc.','Vacc.'})
end


%draw_age draws a map of the population, coloured according to their age
function draw_age(sys)
    n = size(sys.age,1);
    x = 1:n;
    y = 1:n;
    Z = sys.age;
    image(x,y,Z,'CDataMapping','scaled');
    colormap(winter)
    caxis([0,100]);
    c = colorbar;
    ylabel(c, 'age (in years)','FontSize',14)
end

%draw_state draws a map of the population, coloured according to their state
function draw_state(sys)
    n = size(sys.state,1);
    x = 1:n;
    y = 1:n;
    Z = zeros(n);
    for i = 1:n
        for j = 1:n
            if(sys.state(i,j) == "I")
                Z(i,j) = 0;
            end
            if(sys.state(i,j) == "S")
                Z(i,j) = 1;
            end
            if(sys.state(i,j) == "R")
                Z(i,j) = 2;
            end
        end
    end
    map = [1 0 0; 0 1 0; 0 0 1];
    colormap(map);
    image(x,y,Z,'CDataMapping','scaled');
    colorbar('Ticks',[0,1,2],'TickLabels',{'Infected','Susceptible','Recovered'})
end

%draw_reward draws a map of the population, coloured according to their reward
function draw_reward(sys)
    n = size(sys.r,1);
    x = 1:n;
    y = 1:n;
    Z = sys.r;
    image(x,y,Z,'CDataMapping','scaled');
    map = [1 0 0; 1 0.1 0; 1 0.2 0; 1 0.3 0; 1 0.4 0; 1 0.5 0; 1 0.6 0; 1 0.7 0;
           1 0.8 0; 1 0.9 0; 1 1 0; 0.9 1 0; 0.8 1 0; 0.7 1 0; 0.6 1 0; 0.5 1 0;
           0.4 1 0; 0.3 1 0; 0.2 1 0; 0.1 1 0; 0 1 0];
    colormap(map)
    caxis([0,1]);
    c = colorbar;
    ylabel(c, 'reward (in arbitrary units)','FontSize',14)
end