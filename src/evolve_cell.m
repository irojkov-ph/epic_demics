function [t,system] = evolve_cell(t_now, dt, sys, k, l)
    
    %ATTENTION NORMALISE THE PROBAS
    
    % recovery rate (fixed)
    gamma=0.5;
    % infection rate (to upload if depends seasonally and depends on the neighbours)
    %beta = beta_0(t_now).*density_ill(sys,k,l);
    beta = 0.5; %for the test
    % death rate (fixed)
    mu=0.5;
    % rate at which the vaccine becomes less effective
    alpha=0;
    
    %rewards
    %nothing happens to a susceptible person
    r_S0=0;
    %nothing happens to a infected person
    r_I0=0;
    %nothing happens to a recovered person
    r_R0=0;
    %the person gets the infection
    r_ill=0;
    %the person from R becomes again susceptible
    r_back_to_S=0;
    
    
    state_ = sys(k,l).state;
    
    if(state_ == 'S')
        
        p = rand;
        
        if(p<=beta)
            % the person gets infected
            %check if correct the reward system
            sys(k,l).reward = sys(k,l).reward + r_ill;
            sys(k,l).state = 'I';
        elseif(p>beta && p<=(beta+mu))
            % the person dies, we consider a newborn at its place
            sys(k,l).reward = 0;
            sys(k,l).age = 0;
            sys(k,l).vaccinated = false;
        elseif(p>(beta+mu) && p<=(beta+mu+epsilon))
            sys(k,l).reward = 0;
            sys(k,l).age = 0;
            sys(k,l).vaccinated = false;
        else
            sys(k,l).reward = sys(k,l).reward + r_S0;
        end
        
    elseif(state_ == 'I')
        
        p = rand;
        
        if(p<=gamma)
            % the person recovers
            sys(k,l).reward = sys(k,l).reward + r_recover;
            sys(k,l).state = 'R';
        elseif(p>gamma && p<=(gamma+mu))
            % the person dies, we consider a newborn at its place
            sys(k,l).reward = 0;
            sys(k,l).age = 0;
            sys(k,l).vaccinated = false;
            sys(k,l).state = 'S';
        else
            sys(k,l).reward = sys(k,l).reward + r_I0;
        end
        
    elseif(state_ == 'R')
                
        p = rand;
        
        if(p<=alpha)
            % the person becomes again susceptible
            sys(k,l).reward = sys(k,l).reward + r_back_to_S;
            sys(k,l).state = 'S';
            sys(k,l).vaccinated = false;
        elseif(p>alpha && p<=(alpha+mu))
            % the person dies, we consider a newborn at its place
            sys(k,l).reward = 0;
            sys(k,l).age = 0;
            sys(k,l).vaccinated = false;
            sys(k,l).state = 'S';
        else
            sys(k,l).reward = sys(k,l).reward + r_R0;
        end
    else
        disp(['Error! There exist no state "', state_ , ' " in this model! It can not be evolved!'])
    end
    
    system = update_ages(sys,dt);
    
    t = t_now + dt;
    
end