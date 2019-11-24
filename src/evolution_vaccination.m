function evolution_vaccination()
    global system;
    
    n = size(system.reward,1);
    
    % r_vacc == reward for vaccination
    if isfield(system.cfg,'r_vacc') && ~isnan(system.cfg.r_vacc)
        r_vacc = system.cfg.r_vacc;
    else
        r_vacc = -4;
    end
    
    % Filter for the convolution
    filter = ones(3);
    
    % Number of nearest neighbors
    number_of_neighbors = conv2(ones(n),filter,'same')-1;
    
    % Number of NOT vaccinated nearest neighbors
    number_of_neighbors_NV = conv2(~system.vaccinated,filter,'same')-(~system.vaccinated);
    % Mean reward of NOT vaccinated neighbors
    rewards_of_neighbors_NV = conv2(system.reward.*(~system.vaccinated),filter,'same')-system.reward.*(~system.vaccinated);
    rewards_of_neighbors_NV = rewards_of_neighbors_NV ./ number_of_neighbors_NV;
    rewards_of_neighbors_NV (isnan(rewards_of_neighbors_NV)) = 0;
    
    % Number of vaccinated nearest neighbors
    number_of_neighbors_V = conv2(system.vaccinated,filter,'same')-(system.vaccinated);
    % Mean reward of vaccinated neighbors
    rewards_of_neighbors_V = conv2(system.reward.*system.vaccinated,filter,'same')-system.reward.*system.vaccinated;
    rewards_of_neighbors_V = rewards_of_neighbors_V ./ number_of_neighbors_V;
    rewards_of_neighbors_V (isnan(rewards_of_neighbors_V)) = 0;
    
    % Number of infected nearest neighbors
    indices_of_I = system.state=="I";
    number_of_neighbors_I = conv2(indices_of_I,filter,'same')-(indices_of_I);    
    prop_of_neighbors_I = 1 - number_of_neighbors_I ./ number_of_neighbors;
    
    % Uniform distribition to change your state to vaccinated or not
    proba_change_state = rand(n);
    
    % Probability to change the vaccination choice
    proba_vaccination = vaccination_probability_1((rewards_of_neighbors_NV-rewards_of_neighbors_V).*system.vaccinated ...
                            + (rewards_of_neighbors_V-rewards_of_neighbors_NV).*(~system.vaccinated));

    % Which cells will change in vaccination
    indices_to_change = (proba_vaccination.*prop_of_neighbors_I<proba_change_state);
%     indices_to_change = (proba_vaccination < proba_change_state);
    
    % Change the vaccinated state of these cells
    system.vaccinated(indices_to_change) = ~(system.vaccinated(indices_to_change));
    
    system.reward = system.reward + ((system.state == "S") & indices_to_change) * r_vacc;
    system.state((system.state == "S") & indices_to_change) = "R";
end

%distriution function choice 1
function p=vaccination_probability_1(x)
    a = 2/3;
    delta = 0.99; %p = delta when x = 0
    b = log(1/delta - 1);
    p = 1./(exp(a.*x+b)+1);
end

%distribution function choice 2
function p=vaccination_probability_2(x)
    a = 2;
    delta = 0.1; %p = delta when x = 0
    b = 1;
    if(x<=0)
        p = (-x + delta*a)/(-x + a);
    else
        p = 1 - (x + (1-delta)*b)/(x+b);
    end
end
