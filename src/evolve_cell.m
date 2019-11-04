function t = evolve_cell(t_now, dt, k, l)
    
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
    %the person gets the infection
    r_ill = -10;
    %the person recovers
    r_recover = 2;

    
    global system
    
    state_ = system.state(k,l);
    
    if(state_ == 'S')
        
        p = rand;
        
        if(p<=beta)
            % the person gets infected
            %check if correct the reward system
            system.reward(k,l) = system.reward(k,l) + r_ill;
            system.state(k,l) = 'I';
        elseif(p>beta && p<=(beta+mu))
            % the person dies, we consider a newborn at its place
            system.reward(k,l) = 0;
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
        elseif(p>(beta+mu) && p<=(beta+mu+epsilon))
            system.reward(k,l) = 0;
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
        else
        end
        
    elseif(state_ == 'I')
        
        p = rand;
        
        if(p<=gamma)
            % the person recovers
            system.reward(k,l) = system.reward(k,l) + r_recover;
            system.state(k,l) = 'R';
        elseif(p>gamma && p<=(gamma+mu))
            % the person dies, we consider a newborn at its place
            system.reward(k,l) = 0;
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
            system.state(k,l) = 'S';
        else
        end
        
    elseif(state_ == 'R')
                
        p = rand;
        
        if(p<=alpha)
            % the person becomes again susceptible
            sys.state(k,l) = 'S';
            sys.vaccinated(k,l) = false;
        elseif(p>alpha && p<=(alpha+mu))
            % the person dies, we consider a newborn at its place
            system.reward(k,l) = 0;
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
            system.state(k,l) = 'S';
        else
        end
    else
        error('ID:no_state',['Error! There exist no state "', state_ , ' " in this model! It can not be evolved!'])
    end
    
    try 
        update_ages(dt);
    catch
        error('ID:ages_fail','The execution of ''update_ages'' function failed.')
    end
    
    t = t_now + dt;
    
end