function s = evolution_vaccination()
    global system;
    n = size(system.reward,1);
    %r_vacc == reward for vaccination
    r_vacc = -4;
    for i = 2:n-1
        %we iterate over all general cases
        for j = 2:n-1
            if(system.state(i,j) == "S")
                r_i = system.reward(i,j); %individual's reward
                %neighbours' average reward
                r_n = system.reward(i+1,j) + system.reward(i,j+1) + system.reward(i+1,j+1) + ...
                system.reward(i-1,j) + system.reward(i,j-1) + system.reward(i-1,j-1) + ...
                system.reward(i-1,j+1) + system.reward(i+1,j-1);
                r_n  = r_n/8;
                
                p = vaccination_probability_1(r_i - r_n);
                p2 = rand;
                if(p2 < p)
                    system.vaccinated(i,j) = true;
                    system.state(i,j) = "R";
                    system.reward(i,j) = system.vaccinated(i,j) + r_vacc;
                end
            end
        end
        
        %iteration over all borders except corners
        if(system.state(i,1) == "S")
           r_i = system.reward(i,1); %individual's reward
           %neighbours' average reward
           r_n = system.reward(i+1,1) + system.reward(i,2) + system.reward(i+1,2) + ...
           system.reward(i-1,1) + system.reward(i-1,2);
           r_n  = r_n/5;
           
           p = vaccination_probability_1(r_i - r_n);
           p2 = rand;
           if(p2 < p)
                system.vaccinated(i,1) = true;
                system.state(i,1) = "R";
                system.reward(i,1) = system.vaccinated(i,1) + r_vacc;
           end
        end
        if(system.state(i,n) == "S")
           r_i = system.reward(i,n); %individual's reward
           %neighbours' average reward
           r_n = system.reward(i+1,n) + system.reward(i,n-1) + system.reward(i+1,n-1) + ...
           system.reward(i-1,n) + system.reward(i-1,n-1);
           r_n  = r_n/5;
           
           p = vaccination_probability_1(r_i - r_n);
           p2 = rand;
           if(p2 < p)
                system.vaccinated(i,n) = true;
                system.state(i,n) = "R";
                system.reward(i,n) = system.vaccinated(i,n) + r_vacc;
           end
        end
        if(system.state(1,i) == "S")
           r_i = system.reward(1,i); %individual's reward
           %neighbours' average reward
           r_n = system.reward(1,i+1) + system.reward(2,i) + system.reward(2,i+1) + ...
           system.reward(1,i-1) + system.reward(2,i-1);
           r_n  = r_n/5;
           
           p = vaccination_probability_1(r_i - r_n);
           p2 = rand;
           if(p2 < p)
                system.vaccinated(1,i) = true;
                system.state(1,i) = "R";
                system.reward(1,i) = system.vaccinated(1,i) + r_vacc;
           end
        end
        if(system.state(n,i) == "S")
           r_i = system.reward(n,i); %individual's reward
           %neighbours' average reward
           r_n = system.reward(n,i+1) + system.reward(n-1,i) + system.reward(n-1,i+1) + ...
           system.reward(n,i-1) + system.reward(n-1,i-1);
           r_n  = r_n/5;
           
           p = vaccination_probability_1(r_i - r_n);
           p2 = rand;
           if(p2 < p)
                system.vaccinated(n,i) = true;
                system.state(n,i) = "R";
                system.reward(n,i) = system.vaccinated(n,i) + r_vacc;
           end
        end
    end
    
    %corners
    if(system.state(1,1) == "S")
       r_i = system.reward(1,1); %individual's reward
       %neighbours' average reward
       r_n = system.reward(1,2) + system.reward(2,1) + system.reward(2,2);
       r_n  = r_n/3;
      
       p = vaccination_probability_1(r_i - r_n);
       p2 = rand;
       if(p2 < p)
            system.vaccinated(1,1) = true;
            system.state(1,1) = "R";
            system.reward(1,1) = system.vaccinated(1,1) + r_vacc;
       end
    end
    if(system.state(1,n) == "S")
       r_i = system.reward(1,n); %individual's reward
       %neighbours' average reward
       r_n = system.reward(1,n-1) + system.reward(2,n) + system.reward(2,n-1);
       r_n  = r_n/3;
       
       p = vaccination_probability_1(r_i - r_n);
       p2 = rand;
       if(p2 < p)
           system.vaccinated(1,n) = true;
           system.state(1,n) = "R";
           system.reward(1,n) = system.vaccinated(1,n) + r_vacc;
       end
    end
    if(system.state(n,1) == "S")
       r_i = system.reward(n,1); %individual's reward
       %neighbours' average reward
       r_n = system.reward(n,2) + system.reward(n-1,1) + system.reward(n-1,2);
       r_n  = r_n/3;
       
       p = vaccination_probability_1(r_i - r_n);
       p2 = rand;
       if(p2 < p)
           system.vaccinated(n,1) = true;
           system.state(n,1) = "R";
           system.reward(n,1) = system.vaccinated(n,1) + r_vacc;
       end
    end
    if(system.state(n,n) == "S")
       r_i = system.reward(n,n); %individual's reward
       %neighbours' average reward
       r_n = system.reward(n,n-1) + system.reward(n-1,n) + system.reward(n-1,n-1);
       r_n  = r_n/3;
       
       p = vaccination_probability_1(r_i - r_n);
       p2 = rand;
       if(p2 < p)
            system.vaccinated(n,n) = true;
            system.state(n,n) = "R";
            system.reward(n,n) = system.vaccinated(n,n) + r_vacc;
       end
    end    
    s = system;
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

    
    