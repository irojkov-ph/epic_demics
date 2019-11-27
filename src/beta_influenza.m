% Function y=beta_influenza(t,time_units)
% 
% This function returns the value of infectivity y for the influenza
% based on data in Switzerland in years 2017 - 2019. The time has to be 
% given in units ´time_units´.
%

function y = beta_influenza(t,time_units)

    if t<0 || ~isnumeric(t)|| ~isstr(time_units)
        error ('ID:invalid_input','Input parameters for beta_influenza are invalid.')
    end

    
    global influenza_data system
    
    if isempty(influenza_data)
        global epic_demics_path
        influenza_data = load([epic_demics_path,filesep,'data',filesep,'swiss_influenza_2017-2018_2018-2019.mat']);
    end
        
    switch time_units
        case 'week'
            week_number = mod(ceil(t),104);
        case 'hour'
            week_number = mod(ceil(t/(24*7)),104);
        case 'minute'
            week_number = mod(ceil(t/(60*24*7)),104);
        otherwise
            warning('ID:wrong_units',['beta_influeza(t,',time_units,') do not know this type of units.',...
                                      'It will return beta == 1 !'])
            y=1;
            return
    end   
    
    if week_number==0, week_number=1; end
    if week_number <= 52
        y=influenza_data.influenza_data.infect_17_18(week_number)*size(system.age,1)*size(system.age,1);
    elseif week_number > 52
        y=influenza_data.influenza_data.infect_17_18(week_number-52)*size(system.age,1)*size(system.age,1);
    else
        error('ID:wrong_output','Something went wrong in beta_influenza.')
    end
end