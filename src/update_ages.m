% Function status = update_ages(dt,unit)
%
% This fuction updates the age of each cell by an amount `dt` given in "unit".
% The return value is either 1 if the function ended correctly or -1 if it
% did not. 
% 
% 

function status = update_ages(dt,unit)
    status = -1;
    global system
    
    if nargin<2 || size(dt,1)~=1 || size(dt,2)~=1 || ~isnumeric(dt) || ~ischar(unit)
       error('ID:invalid_input',['The function has to take a double `dt` as a parameter \n.'...
                                'As well as a char unit of time (week, hour, day or year; default week)'])
    end
        
    switch unit
        case 'week'
            coeff = 1/(52);
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