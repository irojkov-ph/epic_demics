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

function [t] = evolve_cell(t_now, dt, k, l)
    
    global system;

    if nargin<4 || k<1 || k>size(system.age,1) || l<1 || l>size(system.age,2)
       error('ID:invalid_input','The specified indices are out of range.\n')
    end
    if dt<=0
       error('ID:invalid_input','The time interval `dt` has to be positiv.\n')
    end

    %ATTENTION NORMALISE THE PROBAS
    
    % recovery rate (fixed) -----------------------------------> 3-5 days adults and 3-10 days children
    child = 0;
    if system.age(k,l)<15, child = 1; end
    gamma = 1/((1-child)*(3+2*rand)/7 + child*(3+7*rand)/7);
    % infection rate (to upload if depends seasonally and depends on the neighbours)
    %beta = density_ill(k,l);
    %beta = beta_0(t_now).*density_ill(k,l);
    %beta = .6; %for the test
    beta = beta_influenza(t_now,'week');    
    % death rate (fixed)
    mu = 0;
    % rate at which the vaccine becomes less effective --------> 6 months
    alpha = 1/(6*4);
    
    % REWARDS:
    % the person gets the infection
    r_ill=-10;  
    % the person recovers
    r_recover = 2;
    
    state_ = system.state(k,l);
    
    if(state_ == 'S')
        
        p = rand;
        
        if(p<=beta)
            % the person gets infected
            %check if correct the reward system
            system.reward(k,l) = system.reward(k,l) + r_ill;
            system.state(k,l) = 'I';
        elseif(p>beta && p<=(beta+mu))
            % the person dies, we consider a newborn at its place keeping
            % the same reward
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
        end
        
    elseif(state_ == 'I')
        
        p = rand;
        
        if(p<=gamma)
            % the person recovers
            system.reward(k,l) = system.reward(k,l) + r_recover;
            system.state(k,l) = 'R';
        elseif(p>gamma && p<=(gamma+mu))
            % the person dies, we consider a newborn at its place keeping
            % the same reward
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
            system.state(k,l) = 'S';
        end
        
    elseif(state_ == 'R')
                
        p = rand;
        
        if(p<=alpha)
            % the person becomes again susceptible
            system.state(k,l) = 'S';
            system.vaccinated(k,l) = false;
        elseif(p>alpha && p<=(alpha+mu))
            % the person dies, we consider a newborn at its place keeping
            % the same reward
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
            system.state(k,l) = 'S';
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