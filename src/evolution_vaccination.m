function evolution_vaccination()
    global system;
    
    n = size(system.reward,1);
    
    % r_vacc == reward for vaccination
    r_vacc = -4;
    
    % Filter for the convolution
    filter = ones(3);
    
    % Number of nearest neighbors
%     number_of_neighbors = conv2(ones(n),filter,'same')-1;
    
    % Number of NOT vaccinated nearest neighbors
    number_of_neighbors_NV = conv2(~system.vaccinated,filter,'same')-(~system.vaccinated);
    % Mean reward of NOT vaccinated neighbors
    rewards_of_neighbors_NV = conv2(system.reward.*system.vaccinated,filter,'same')-system.reward.*system.vaccinated;
    rewards_of_neighbors_NV = rewards_of_neighbors_NV ./ number_of_neighbors_NV;
    
    % Number of vaccinated nearest neighbors
    number_of_neighbors_V = conv2(system.vaccinated,filter,'same')-(system.vaccinated);
    % Mean reward of vaccinated neighbors
    rewards_of_neighbors_V = conv2(system.reward.*(~system.vaccinated),filter,'same')-system.reward.*(~system.vaccinated);
    rewards_of_neighbors_V = rewards_of_neighbors_V ./ number_of_neighbors_V;
    
    % Uniform distribition to change your state to vaccinated or not
    proba_change_state = rand(n);
    % Probability to change the vaccination choice
    proba_vaccination = vaccination_probability_1(rewards_of_neighbors_V-rewards_of_neighbors_NV);
    
    % Which cells will change in vaccination
    indices_to_change = (proba_vaccination>proba_change_state);
    
    % Change the vaccinated state of these cells
    system.vaccinated(indices_to_change) = not(system.vaccinated(indices_to_change));

    system.state((system.state == "S") & indices_to_change) = "R";
    system.reward = system.reward + ((system.state == "S") & indices_to_change) * r_vacc;
end

%distriution function choice 1
function p=vaccination_probability_1(x)
    a = 2/3;
    delta = 0.1; %p = delta when x = 0
    b = log(1/delta - 1);
    p = 1./(exp(a*x+b)+1);
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
