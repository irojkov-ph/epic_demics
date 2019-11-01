function draw(sys,attribute)
    if(attribute == 'age')
        draw_age(sys);
    end
    if(attribute == 'vaccinated')
        draw_vaccinated(sys);
    end
    if(attribute == 'reward')
        draw_reward(sys);
    end
    if(attribute == 'state')
        draw_state(sys);
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