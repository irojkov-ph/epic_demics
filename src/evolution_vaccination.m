% Function evolution_vaccination()
% 
% This function goes through the whole grid and for each person decides
% whether to change its vaccination state. 
% 
% 
% 
% 



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
    number_of_neighbors_NV = conv2(~system.vaccinated,filter,'same');
    % Mean reward of NOT vaccinated neighbors
    rewards_of_neighbors_NV = conv2(system.reward.*(~system.vaccinated),filter,'same');
    rewards_of_neighbors_NV = rewards_of_neighbors_NV ./ number_of_neighbors_NV;
    % If all neighbours have the same choice this variable is marked true
    are_neighbours_uniform = zeros(n);
    are_neighbours_uniform(number_of_neighbors_NV == 0) = true;
    
    % Number of vaccinated nearest neighbors
    number_of_neighbors_V = conv2(system.vaccinated,filter,'same');
    % Mean reward of vaccinated neighbors
    rewards_of_neighbors_V = conv2(system.reward.*system.vaccinated,filter,'same');
    rewards_of_neighbors_V = rewards_of_neighbors_V ./ number_of_neighbors_V;
    % If all neighbours have the same choice this variable is marked true
    are_neighbours_uniform(number_of_neighbors_V == 0) = true;    
    
    % Number of infected nearest neighbors
%     indices_of_I = (system.state=="I");
%     number_of_neighbors_I = conv2(indices_of_I,filter,'same');    
%     prop_of_neighbors_I = number_of_neighbors_I./number_of_neighbors;
    
    % Uniform distribition to change your state to vaccinated or not
    proba_change_state = rand(n);
    
    % Probability to change the vaccination choice
    proba_vaccination = vaccination_probability_1(((-rewards_of_neighbors_NV+rewards_of_neighbors_V).*system.vaccinated ...
                           + (-rewards_of_neighbors_V+rewards_of_neighbors_NV).*(~system.vaccinated)),n);
    % If all neighbours have the same choice, then we consider that the two
    %choices have equal reward and thus compute the function for \Delta r=0
    proba_vaccination(are_neighbours_uniform == true) = vaccination_probability_1(0,n);

    % Which cells will change in vaccination
    %indices_to_change = (proba_vaccination>proba_change_state.*prop_of_neighbors_NI);
    indices_to_change = (proba_vaccination > proba_change_state);
    
    % Change the vaccinated state of these cells
    system.vaccinated(indices_to_change) = ~(system.vaccinated(indices_to_change));
    
    % Only susceptible and vaccination-choosing people get vaccinated
    system.reward = system.reward + ((system.state == "S") & (system.vaccinated == true)) * r_vacc;
    system.state((system.state == "S") & (system.vaccinated == true)) = "R";
end

%distriution function choice 1
function p=vaccination_probability_1(x,n)
    a = 1;
    delta = 1/(n*n); %p = delta when x = 0
    b = log(1/delta - 1);
    p = 1./(exp(a.*x+b)+1);
end

%distribution function choice 2
function p=vaccination_probability_2(x,n)
    a = 2;
    delta = 1/(n*n); %p = delta when x = 0
    b = 1;
    if(x<=0)
        p = (-x + delta*a)/(-x + a);
    else
        p = 1 - (x + (1-delta)*b)/(x+b);
    end
end
