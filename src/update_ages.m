% Function status = update_ages(dt)
%
% This fuction updates the age of each cell by an amount `dt`.
% The return value is either 1 if the function ended correctly or -1 if it
% does not. 
% 
% 

function status = update_ages(dt,unit)
    status = -1;
    global system
    
    if nargin<2 || size(dt,1)~=1 || size(dt,2)~=1 || ~isnumeric(dt) || ~ischar(unit)
       error('ID:invalid_input',['The function has to take a double `dt` as a parameter \n.'...
                                'As well as a char unit of time (minute, hour, day or year; default minute)'])
    end
        
    switch unit
        case 'minute'
            coeff = 1/(365*24*60);
        case 'hour'
            coeff = 1/(365*24);
        case 'day'
            coeff = 1/(365);
        case 'year'
            coeff = 1;
        otherwise
            coeff = 1/(365*24*60);
    end
    
    system.age = system.age + coeff*dt;
    
    status = 1;
end