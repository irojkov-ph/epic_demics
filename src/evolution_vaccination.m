function evolution_vaccination()
    global system;
    n = size(system.reward,1);
    %r_vacc == reward for vaccination
    r_vacc = -4;
    for i = 2:n-1
        %we iterate over all general cases
        for j = 2:n-1
            r_i = system.reward(i,j); %individual's reward
            %neighbours' average reward
            r_n = system.reward(i+1,j) + system.reward(i,j+1) + system.reward(i+1,j+1) + ...
            system.reward(i-1,j) + system.reward(i,j-1) + system.reward(i-1,j-1) + ...
            system.reward(i-1,j+1) + system.reward(i+1,j-1);
            r_n  = r_n/8;
            
            p = vaccination_probability_1(r_i - r_n);
            p2 = rand;
            if(p2 < p)
                system.vaccinated(i,j) = not(system.vaccinated(i,j));
            end
        end
        
        %iteration over all borders except corners
        r_i = system.reward(i,1); %individual's reward
        %neighbours' average reward
        r_n = system.reward(i+1,1) + system.reward(i,2) + system.reward(i+1,2) + ...
        system.reward(i-1,1) + system.reward(i-1,2);
        r_n  = r_n/5;
        
        p = vaccination_probability_1(r_i - r_n);
        p2 = rand;
        if(p2 < p)
            system.vaccinated(i,1) = not(system.vaccinated(i,1));
        end
        
        r_i = system.reward(i,n); %individual's reward
        %neighbours' average reward
        r_n = system.reward(i+1,n) + system.reward(i,n-1) + system.reward(i+1,n-1) + ...
        system.reward(i-1,n) + system.reward(i-1,n-1);
        r_n  = r_n/5;
        
        p = vaccination_probability_1(r_i - r_n);
        p2 = rand;
        if(p2 < p)
            system.vaccinated(i,n) = not(system.vaccinated(i,n));
        end
        
        r_i = system.reward(1,i); %individual's reward
        %neighbours' average reward
        r_n = system.reward(1,i+1) + system.reward(2,i) + system.reward(2,i+1) + ...
        system.reward(1,i-1) + system.reward(2,i-1);
        r_n  = r_n/5;
        
        p = vaccination_probability_1(r_i - r_n);
        p2 = rand;
        if(p2 < p)
             system.vaccinated(1,i) = not(system.vaccinated(1,i));
        end
        
        r_i = system.reward(n,i); %individual's reward
        %neighbours' average reward
        r_n = system.reward(n,i+1) + system.reward(n-1,i) + system.reward(n-1,i+1) + ...
        system.reward(n,i-1) + system.reward(n-1,i-1);
        r_n  = r_n/5;
        
        p = vaccination_probability_1(r_i - r_n);
        p2 = rand;
        if(p2 < p)
             system.vaccinated(n,i) = not(system.vaccinated(n,i));
        end   
    end
    
    %corners
    r_i = system.reward(1,1); %individual's reward
    %neighbours' average reward
    r_n = system.reward(1,2) + system.reward(2,1) + system.reward(2,2);
    r_n  = r_n/3;
    
    p = vaccination_probability_1(r_i - r_n);
    p2 = rand;
    if(p2 < p)
        system.vaccinated(1,1) = not(system.vaccinated(1,1));
    end
    
    r_i = system.reward(1,n); %individual's reward
    %neighbours' average reward
    r_n = system.reward(1,n-1) + system.reward(2,n) + system.reward(2,n-1);
    r_n  = r_n/3;
    
    p = vaccination_probability_1(r_i - r_n);
    p2 = rand;
    if(p2 < p)
        system.vaccinated(1,n) = not(system.vaccinated(1,n));
    end
    
    r_i = system.reward(n,1); %individual's reward
    %neighbours' average reward
    r_n = system.reward(n,2) + system.reward(n-1,1) + system.reward(n-1,2);
    r_n  = r_n/3;
    
    p = vaccination_probability_1(r_i - r_n);
    p2 = rand;
    if(p2 < p)
        system.vaccinated(n,1) = not(system.vaccinated(n,1));
    end
    
    r_i = system.reward(n,n); %individual's reward
    %neighbours' average reward
    r_n = system.reward(n,n-1) + system.reward(n-1,n) + system.reward(n-1,n-1);
    r_n  = r_n/3;
    
    p = vaccination_probability_1(r_i - r_n);
    p2 = rand;
    if(p2 < p)
        system.vaccinated(n,n) = not(system.vaccinated(n,n));
    end  
    for i = 1:n
        for j = 1:n
            if((system.state(i,j) == "S") && (system.vaccinated(i,j) == true))
                system.state(i,j) = "R";
                system.reward(i,j) = system.reward(i,j) + r_vacc;
            end
        end
    end
end




%distriution function choice 1
function p=vaccination_probability_1(x)
    a = 2/3;
    delta = 0.1; %p = delta when x = 0
    b = log(1/delta - 1);
    p = 1/(exp(a*x+b)+1);
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

    
    