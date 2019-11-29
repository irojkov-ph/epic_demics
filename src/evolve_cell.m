% Function t = evolve_cell(t_now, k, l)
% 
% This function evolves one unique cell at the position (k,l) 
% for a time step (exponentially chosen) `dt`. 
% 
% All fields of the cell can change (even the field `vaccinated` can 
% change if for instace the cell "dies")
% 
% More specifically the `state` of the cell evolves following the SIR model
% whose parameter are specified in the begining of the function.
% 
% It returns the evolution of the time, i.e. `t = t_now + dt`.
% 
% 

function [t] = evolve_cell(t_now, k, l)
    
    global system;
    
    if nargin<3 || k<1 || k>size(system.age,1) || l<1 || l>size(system.age,2)
       error('ID:invalid_input','The specified indices are out of range.\n')
    end
    
    n = size(system.age,1);
    
    % If the total rate Q is 0 the time evolves with this dt (see below)
    dt = 1/(n^2);
    
    % Recovery rate (by default different for children and adults)
    if isfield(system.cfg,'gamma') && ~isnan(system.cfg.gamma)
        gamma = system.cfg.gamma;
    else
        child = 0;
        if system.age(k,l)<15, child = 1; end
        gamma = 1/((1-child)*(3+5*rand)/7 + child*(5+5*rand)/7);
    end
    
    % Infection rate (number of infections per node per unit of time)
    % It depends on the local situation (i.e. on the density of infected)
    if isfield(system.cfg,'beta') && ~isnan(system.cfg.beta)
        beta = system.cfg.beta*density_ill(k,l);
    else
        beta = beta_influenza(t_now,'week')*density_ill(k,l);
    end
    
    % Rate at which the vaccine becomes less effective
    if isfield(system.cfg,'alpha') && ~isnan(system.cfg.alpha)
        alpha = system.cfg.alpha;
    else
        alpha = 1/(4*6);
    end
    
    % Rate at which a person dies
    if isfield(system.cfg,'mu') && ~isnan(system.cfg.mu)
        mu = system.cfg.mu;
    else
        mu = mu_age(k,l);
    end
    
    % Zero evenement: nothing happens
    if isfield(system.cfg,'zero') && ~isnan(system.cfg.zero)
        zero = system.cfg.zero;
    else
        zero=1;
    end
    
    state_ = system.state(k,l);
    
    % Defining rates per latice:
    Q_gamma = gamma;
    Q_alpha = alpha;
    Q_mu = mu;
    Q_beta = beta*8*3000/(n*n); % it is slightly larger than Q_alpha at peak
    Q_zero = zero;
    
    % Reward of a person who gets infected
    if isfield(system.cfg,'r_ill') && ~isnan(system.cfg.r_ill)
        r_ill = system.cfg.r_ill;
    else
        r_ill=-10;
    end
    
    % Reward of a person who recovers
    if isfield(system.cfg,'r_recover') && ~isnan(system.cfg.r_recover)
        r_recover = system.cfg.r_recover;
    else
        r_recover = 2;
    end
    
    p = rand;
    
    if(state_ == 'S')
        
        Q = Q_mu + Q_beta + Q_zero;
        
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
        
        Q = Q_gamma + Q_mu + Q_zero;
        
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
        
        Q = Q_alpha + Q_mu + Q_zero;
        
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
        
    dt = -log(1-p)/(Q*n*n);
    
    try 
        update_ages(dt,'week');
    catch
        error('ID:ages_fail','The execution of ''update_ages'' function failed.')
    end
    
    t = t_now + dt;
    
end