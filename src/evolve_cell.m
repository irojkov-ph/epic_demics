% Function t = evolve_cell(t_now, k, l)
% 
% This function evolve one unique cell at the position (k,l) 
% for a time step (exponentially chosen) `dt`. 
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

function [t] = evolve_cell(t_now, k, l)
    
    global system;
    
    n = size(system.age,1);
    
    %if nothing happens the time evolves with dt
    dt = 1./(n.^2);
    
    % recovery rate (number of recovery per node per unit of time)
    gamma= .001;
    % infection rate (number of infections per node per unit of time)
    beta = .05;
    % death rate (number of death per node per unit of time)
    mu=0;
    % number of people who loose the effect of vaccine per node per unit of time
    alpha=0;
    
    % those rates, but beta, are independent from the node, then we just sum 
    % them up by multiplying by N^2
    Q_gamma = n*n*gamma;
    Q_mu = n*n*mu;
    Q_alpha = n*n*alpha;
    
    % beta rate depends on the actual system (i.e. on the density of ill)
    Q_beta = beta.*sum(sum(system.beta));%.*beta_0(t_now);
    
    %beta rate for the test
    %Q_beta = n*n*beta;
    
    %rewards
    %the person gets the infection
    r_ill=-10;  
    %the person recovers
    r_recover = 2;
    
    
    if nargin<3 || k<1 || k>size(system.age,1) || l<1 || l>size(system.age,2)
       error('ID:invalid_input','The specified indices are out of range.\n')
    end
    
    state_ = system.state(k,l);
    
    p = rand;
    
    if(state_ == 'S')
        
        Q = Q_mu + Q_beta;
        
        if(Q==0)
            t = t_now + dt;
            return;
        end
        
        p_ill = Q_beta/Q;
        p_death = Q_mu/Q;
        
        if(p<=p_ill)
            % the person gets infected
            system.reward(k,l) = system.reward(k,l) + r_ill;
            system.state(k,l) = 'I';
        elseif(p>p_ill && p<=(p_ill+p_death))
            % the person dies, we consider a newborn at its place keeping
            % the same reward
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
        end
        
    elseif(state_ == 'I')
        
        Q = Q_gamma + Q_mu;
        
        if(Q==0)
            t = t_now + dt;
            return;
        end
        
        p_recover = Q_gamma/Q;
        p_death = Q_mu/Q;
        
        if(p<=p_recover)
            % the person recovers
            system.reward(k,l) = system.reward(k,l) + r_recover;
            system.state(k,l) = 'R';
        elseif(p>p_recover && p<=(p_recover+p_death))
            % the person dies, we consider a newborn at its place keeping
            % the same reward
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
            system.state(k,l) = 'S';
        end
        
    elseif(state_ == 'R')
        
        Q = Q_alpha + Q_mu;
        
        if(Q==0)
            t = t_now + dt;
            return;
        end
        
        p_susc = Q_alpha/Q;
        p_death = Q_mu/Q;
        
        if(p<=p_susc)
            % the person becomes again susceptible
            system.state(k,l) = 'S';
            system.vaccinated(k,l) = false;
        elseif(p>p_susc && p<=(p_susc+p_death))
            % the person dies, we consider a newborn at its place keeping
            % the same reward
            system.age(k,l) = 0;
            system.vaccinated(k,l) = false;
            system.state(k,l) = 'S';
        end
    else
        error('ID:no_state',['Error! There exist no state "', state_ , ' " in this model! It can not be evolved!'])
    end
    
    update_betas(k,l);
    
    epsilon = rand;
    dt = -1./Q.*log(1-epsilon);
    
    try 
        update_ages(dt);
    catch
        error('ID:ages_fail','The execution of ''update_ages'' function failed.')
    end
    
    
    t = t_now + dt;
    
end