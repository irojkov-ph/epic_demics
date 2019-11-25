function mu = mu_age(k,l)
    % Gives the mortality rate mu at a certain age
    
    global mortality_data;
    
    if isempty(mortality_data)
        global epic_demics_path
        data = load([epic_demics_path,filesep,'data',filesep,'swiss_mortality_data_2016-2018.mat']);
               
        % Mortality calculated as death per total number of people (w.r.t. age)
        % in Switzerland for 2016 (2017 and 2018 are also available)
        mortality_data = data.mortality_data.mort_rate_2016;
    end
    
    global system;
    
    age = floor(system.age(k,l));
    
    if(age>98)
        %if the person is older than 98 we put a large value to
        %mortalit.y
        mu = 1;
    else
        mu = mortality_data(age+1)*size(system.age,1)*size(system.age,1)/52;
    end
end