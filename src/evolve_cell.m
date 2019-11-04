% Function t = evolve_cell(t_now, dt, k, l)
% 
% This function evolve one unique cell at the position (k,l) 
% for a time interval `dt`. 
% 
% All fields of the cell could evolve (even the field `vaccinated` could 
% change if for instace the cell "die")
% 
% More specifically the `state` of the cell evolves following the SIR model
% whose parameter are specified in the begining of the function.
% 
% It returns the evolution of the time, i.e. `t = t_now + dt`.
% 
% 

function t = evolve_cell(t_now, dt, k, l)

    global system

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
    
    if nargin<4 || k<1 || k>size(system.age,1) || l<1 || l>size(system.age,2)
       error('ID:invalid_input','The specified indices are out of range.\n')
    end
    if dt<=0
       error('ID:invalid_input','The time interval `dt` has to be positiv.\n')
    end
    
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
            system.reward(k,l) = system.reward(k,l) + r_S0;
        end
        
    elseif(state_ == 'I')
        
        p = rand;
        
        if(p<=gamma)
            % the person recovers
            system.reward(k,l) = system.reward(k,l);
            system.state(k,l) = 'R';
        elseif(p>gamma && p<=(gamma+mu))
            % the person dies, we consider a newborn at its place
            system.reward(k,l) = 0;
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
            system.state(k,l) = 'S';
        else
            system.reward(k,l) = system.reward(k,l) + r_I0;
        end
        
    elseif(state_ == 'R')
                
        p = rand;
        
        if(p<=alpha)
            % the person becomes again susceptible
            system.reward(k,l) = system.reward(k,l) + r_back_to_S;
            system.state(k,l) = 'S';
            system.vaccinated(k,l) = false;
        elseif(p>alpha && p<=(alpha+mu))
            % the person dies, we consider a newborn at its place
            system.reward(k,l) = 0;
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
            system.state(k,l) = 'S';
        else
            system.reward(k,l) = system.reward(k,l) + r_R0;
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