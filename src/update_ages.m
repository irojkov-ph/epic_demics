% Function status = update_ages(dt)
%
% This fuction updates the age of each cell by an amount `dt`.
% The return value is either 1 if the function ended correctly or -1 if it
% does not. 
% 
% 

function status = update_ages(dt)
    status = -1;
    global system
    
    if nargin<1 || size(dt,1)~=1 || size(dt,2)~=1 || ~isnumeric(dt)
       error('ID:invalid_input','The function has to take a double `dt` as a parameter.')
    end
    
    
    system.age = system.age + dt;
    
    status = 1;
end