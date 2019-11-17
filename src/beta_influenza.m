function y = beta_influenza(t,time_units)

    if t<0 || ~isnumeric(t)|| ~isstr(time_units)
        error ('ID:invalid_input','Input parameters for beta_influenza are invalid.')
    end

    %ATTENTION the function should be such that max beta_0 <= 1 and min >=0
    global influenza_data
    
    if isempty(influenza_data)
        global epic_demics_path
        influenza_data = load([epic_demics_path,filesep,'data',filesep,'swiss_influenza_2017-2018_2018-2019.mat']);
    end
        
    switch time_units
        case 'week'
            week_number = mod(ceil(t),104);
            if week_number==0, week_number=1; end
            if week_number <= 52
                y=influenza_data.influenza_data.infect_17_18(week_number);
            elseif week_number > 52
                y=influenza_data.influenza_data.infect_17_18(week_number-52);
            else
                error('ID:wrong_output','Something went wrong in beta_influenza.')
            end
        otherwise
            warning('ID:wrong_units',['beta_influeza(t,',time_units,') do not know this type of units.',...
                                      'It will return beta == 1 !'])
            y=1;
    end   
end