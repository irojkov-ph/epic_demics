function draw(attributes,varargin)
    for i=1:length(attributes)
        switch attributes(i)
            case 'age'
                draw_age();
            case 'vaccinated'
                draw_vaccinated();
            case 'reward'
                draw_reward();
            case 'state'
                draw_state();
            case 'state_density'
                if ~(nargin<2)
                    draw_state_density(varargin{1}/(7*24*60));
                else
                    error('ID:invalid_input','Missing arguments to draw the densities.')
                end
            case 'mean_age'
                if ~(nargin<2)
                    draw_mean_age(varargin{1}/(7*24*60));
                else
                    error('ID:invalid_input','Missing arguments to draw the densities.')
                end
            otherwise
                error('ID:invalid_input',['The attribute',attributes(i),' does not exist or cannot be drawn.'])
        end
    end
end


%draw_vaccinated draws a map of the population, coloured according to their
%vaccination choice
function draw_vaccinated()

    global system;

    n = size(system.vaccinated,1);
    x = 1:n;
    y = 1:n;
    
    if isempty(findobj('Type', 'Figure', 'Name', 'vaccinated'))
        figure('Name', 'vaccinated');
        
        image(x,y,system.vaccinated,'CDataMapping','scaled','Tag', 'Vaccinated');
        
        
        colorbar('Ticks',[0,1],'TickLabels',{'Not vacc.','Vacc.'})
        map = [1 0 0; 0 0 1];
        colormap(map);
        caxis([0,1]);
    else
        im = findobj('Type', 'Image', 'Tag', 'Vaccinated');
        set(im, 'CData', system.vaccinated)
    end
end


%draw_age draws a map of the population, coloured according to their age
function draw_age()
    global system;

    n = size(system.age,1);
    x = 1:n;
    y = 1:n;
    
    
    if isempty(findobj('Type', 'Figure', 'Name', 'age'))
        h=figure('Name', 'age');
        
        image(x,y,system.age,'CDataMapping','scaled','Tag','Age');
        colormap(h,winter)
        caxis([0,100]);
        c = colorbar;
        ylabel(c, 'age (in years)','FontSize',14)
    else
        im = findobj('Type', 'Image', 'Tag', 'Age');
        set(im, 'CData', system.age)
    end
end

%draw_state draws a map of the population, coloured according to their state
function draw_state()
    global system;
    
    n = size(system.state,1);
    x = 1:n;
    y = 1:n;
    
    Z = zeros(n);
    Z(system.state == "I") = 0;
    Z(system.state == "S") = 1;
    Z(system.state == "R") = 2;

    map = [1 0 0; 0 1 0; 0 0 1];
    
    if isempty(findobj('Type', 'Figure', 'Name', 'state'))
        h=figure('Name', 'state');
        
        image(x,y,Z,'CDataMapping','scaled','Tag','State');
        
        colorbar('Ticks',[0,1,2],'TickLabels',{'Infected','Susceptible','Recovered'})
        colormap(h,map);
        caxis([0,2]);
        
    else
        im = findobj('Type', 'Image', 'Tag', 'State');
        set(im, 'CData', Z)
    end  
end

%draw_reward draws a map of the population, coloured according to their reward
function draw_reward()

    global system;

    n = size(system.reward,1);
    x = 1:n;
    y = 1:n;
        
    if isempty(findobj('Type', 'Figure', 'Name', 'reward'))
        figure('Name', 'reward');
        image(x,y,system.reward,'CDataMapping','scaled','Tag','Reward');
        
        c = colorbar('Tag','Reward');
        set(c,'Ylim',[-10,0])
        ylabel(c, 'reward (in arbitrary units)','FontSize',14)
        
        map = [1 0 0; 1 0.1 0; 1 0.2 0; 1 0.3 0; 1 0.4 0; 1 0.5 0; 1 0.6 0; 1 0.7 0;
               1 0.8 0; 1 0.9 0; 1 1 0; 0.9 1 0; 0.8 1 0; 0.7 1 0; 0.6 1 0; 0.5 1 0;
               0.4 1 0; 0.3 1 0; 0.2 1 0; 0.1 1 0; 0 1 0];
        colormap(map)
        
    else
        c = findobj('Type','ColorBar','Tag','Reward');
        if min(min(system.reward))< -10
            set(c,'Ylim',[min(min(system.reward)),0])
        end
        img = findobj('Type', 'Image', 'Tag', 'Reward');
        set(img,'CData', system.reward)
    end
end

function draw_state_density(t_now)
    if isempty(findobj('Type', 'Figure', 'Name', 'state_density'))
        figure('Name', 'state_density')
        h_I=animatedline('Tag','Density_I','Color','Red');
        h_S=animatedline('Tag','Density_S','Color','Green');
        h_R=animatedline('Tag','Density_R','Color','Blue');
    else
        h_I=findobj('Type', 'AnimatedLine', 'Tag', 'Density_I');
        h_S=findobj('Type', 'AnimatedLine', 'Tag', 'Density_S');
        h_R=findobj('Type', 'AnimatedLine', 'Tag', 'Density_R');
    end

    global system
    
    nb_tot = size(system.state,1)^2;
    
    rho_I = sum(sum(system.state == "I"))/nb_tot;
    rho_S = sum(sum(system.state == "S"))/nb_tot;
    rho_R = sum(sum(system.state == "R"))/nb_tot;
    
    addpoints(h_I,t_now,rho_I);
    addpoints(h_S,t_now,rho_S);
    addpoints(h_R,t_now,rho_R);
    drawnow;

end

function draw_mean_age(t_now)
    if isempty(findobj('Type', 'Figure', 'Name', 'mean_age'))
        figure('Name', 'mean_age')
        h_MA=animatedline('Tag','Mean_age','Color','Black');
    else
        h_MA=findobj('Type', 'AnimatedLine', 'Tag', 'Mean_age');
    end

    global system
    
    MA = mean(mean(system.age));
    
    addpoints(h_MA,t_now,MA);
    drawnow;

end


