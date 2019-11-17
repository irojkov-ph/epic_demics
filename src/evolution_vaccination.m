function evolution_vaccination()
    global system;
    
    n = size(system.reward,1);
    
    %r_vacc == reward for vaccination
    r_vacc = -4;
    
    
    filter = ones(3);
    number_of_neighbors = conv2(ones(n),filter,'same')-1;
    rewards_of_neighbors = conv2(system.reward,filter,'same')-system.reward;
    rewards_of_neighbors = rewards_of_neighbors ./ number_of_neighbors;
    
    proba_change_state = rand(n);
    
    proba_vaccination = vaccination_probability_1(system.reward-rewards_of_neighbors);
    
    indices_not_vacc = (proba_vaccination>proba_change_state);
    
    system.vaccinated(indices_not_vacc) = not(system.vaccinated(indices_not_vacc));

    system.state((system.state == "S") + (system.vaccinated == 1) > 1) = "R";
    system.reward = system.reward + ((system.state == "S") + (system.vaccinated == 1) > 1)*r_vacc;
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

    
    