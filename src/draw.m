% Function draw(attributes,varargin)
% 
% This function draws the "attributes" in the given list. Varargin gives
% the current time
% 
% It calls the corresponding functions "draw_age()", "draw_vaccinated()",
% "draw_reward()", "draw_state()", "draw_state_density(t)",
% "draw_mean_age(t)", "draw_vaccination_density(t)" defined below

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
                    draw_state_density(varargin{1});
                else
                    error('ID:invalid_input','Missing arguments to draw the densities.')
                end
            case 'mean_age'
                if ~(nargin<2)
                    draw_mean_age(varargin{1});
                else
                    error('ID:invalid_input','Missing arguments to draw mean age.')
                end      
            case 'vaccination_density'
                if ~(nargin<2)
                    draw_vaccination_density(varargin{1});
                else
                    error('ID:invalid_input','Missing arguments to draw vaccination density.')
                end
            case 'max_area_infection'
                if ~(nargin<2)
                    draw_max_area_infection(varargin{1});
                else
                    error('ID:invalid_input','Missing arguments to draw the maximal area of infection.')
                end    
            otherwise
                error('ID:invalid_input',['The attribute',attributes(i),' does not exist or cannot be drawn.'])
        end
    end
end

% Function draw_vaccinated()
% 
% This function draws a map of the population, coloured according to their
% vaccination choice
% 

function draw_vaccinated()

    global system;

    n = size(system.vaccinated,1);
    x = 1:n;
    y = 1:n;
    
    if isempty(findobj('Type', 'Figure', 'Name', 'vaccinated'))
        figure('Name', 'vaccinated');
        
        image(x,y,system.vaccinated,'CDataMapping','scaled','Tag', 'Vaccinated');
        set(gca,'visible','off');
        
        
        colorbar('Ticks',[0,1],'TickLabels',{'Not vacc.','Vacc.'})
        map = [1 0 0; 0 0 1];
        colormap(map);
        caxis([0,1]);
    else
        im = findobj('Type', 'Image', 'Tag', 'Vaccinated');
        set(im, 'CData', system.vaccinated)
    end
end

% Function draw_age()
% 
% This function draws a map of the population, coloured according to their
% age
%


function draw_age()
    global system;

    n = size(system.age,1);
    x = 1:n;
    y = 1:n;
    
    
    if isempty(findobj('Type', 'Figure', 'Name', 'age'))
        h=figure('Name', 'age');
        
        image(x,y,system.age,'CDataMapping','scaled','Tag','Age');
        set(gca,'visible','off');
        colormap(h,winter)
        caxis([0,100]);
        c = colorbar;
        ylabel(c, 'age (in years)','FontSize',14)
    else
        im = findobj('Type', 'Image', 'Tag', 'Age');
        set(im, 'CData', system.age)
    end
end

% Function draw_state()
% 
% This function draws a map of the population, coloured according to their
% state
%


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
        set(gca,'visible','off');
        
        colorbar('Ticks',[0,1,2],'TickLabels',{'Infected','Susceptible','Recovered'})
        colormap(h,map);
        caxis([0,2]);
        
    else
        im = findobj('Type', 'Image', 'Tag', 'State');
        set(im, 'CData', Z)
    end  
end

% Function draw_reward()
% 
% This function draws a map of the population, coloured according to their
% reward
%


function draw_reward()

    global system;

    n = size(system.reward,1);
    x = 1:n;
    y = 1:n;
        
    if isempty(findobj('Type', 'Figure', 'Name', 'reward'))
        figure('Name', 'reward');
        image(x,y,system.reward,'CDataMapping','scaled','Tag','Reward');
        set(gca,'visible','off');
        
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
        if max(max(system.reward))> 0
            set(c,'Ylim',[-10,max(max(system.reward))])
        end
        img = findobj('Type', 'Image', 'Tag', 'Reward');
        set(img,'CData', system.reward)
    end
end

% Function draw_state_density(t)
% 
% This function draws the state densities from inital time up to time t
%

function draw_state_density(t)
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
    
    addpoints(h_I,t,rho_I);
    addpoints(h_S,t,rho_S);
    addpoints(h_R,t,rho_R);
    drawnow;

end

% Function draw_vaccination_density(t)
% 
% This function draws the vaccination densities from inital time up to 
% time t
%

function draw_vaccination_density(t)
    if isempty(findobj('Type', 'Figure', 'Name', 'vaccination_density'))
        figure('Name', 'vaccination_density')
        h_V=animatedline('Tag','Density_V','Color','Green');
        h_NV=animatedline('Tag','Density_NV','Color','Red');
    else
        h_V=findobj('Type', 'AnimatedLine', 'Tag', 'Density_V');
        h_NV=findobj('Type', 'AnimatedLine', 'Tag', 'Density_NV');
    end

    global system
    
    nb_tot = size(system.state,1)^2;
    
    rho_I = sum(sum(system.vaccinated == 1))/nb_tot;
    rho_S = sum(sum(system.vaccinated == 0))/nb_tot;
    
    addpoints(h_V,t,rho_I);
    addpoints(h_NV,t,rho_S);
    drawnow;

end

% Function draw_mean_age(t)
% 
% This function draws the mean age from inital time up to time t
%

function draw_mean_age(t)
    if isempty(findobj('Type', 'Figure', 'Name', 'mean_age'))
        figure('Name', 'mean_age')
        h_MA=animatedline('Tag','Mean_age','Color','Black');
    else
        h_MA=findobj('Type', 'AnimatedLine', 'Tag', 'Mean_age');
    end

    global system
    
    MA = mean(mean(system.age));
    
    addpoints(h_MA,t,MA);
    drawnow;

end

% Function draw_max_area_infection(t)
% 
% This function draws the instanteneous maximal area of the illness 
% (i.e. area of the biggest blob of infected people) from inital time
% up to time t.
%

function draw_max_area_infection(t)
    if isempty(findobj('Type', 'Figure', 'Name', 'max_area_infection'))
        figure('Name', 'max_area_infection')
        h_MAI=animatedline('Tag','max_area_infection','Color','Black');
    else
        h_MAI=findobj('Type', 'AnimatedLine', 'Tag', 'max_area_infection');
    end

    global system
    
    CR = bwlabel(system.age=="I");
    Meas = regionprops(CR,'Area');
    Areas = [Meas.Area];
    MAI = max(Areas);    
    
    addpoints(h_MAI,t,MAI);
    drawnow;

end


