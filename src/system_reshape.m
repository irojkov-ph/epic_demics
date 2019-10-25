% Function [reshaped_sys]=system_reshape(sys) 
%
% This function reshape the system as it is initialized by the
% `system_init.m` function. The aim of this function is to provide a more
% instinctive way to look at the system.
% 
% `reshaped_sys` is an n x n array of structures which represent people
% in the system and have the following fields:
%       - state:        'S', 'I' or 'R' 
%       - vaccin:    0 or 1
%       - reward:       a double that represents the reward of the persont 
%       - age:          the age of the person
%
% E.g.:
%       - reshaped_sys(i,j) is a structure with 4 values representing the
%         (i,j) person.
%       - reshaped_sys(i,j).age is the age of that person.
% 


function [reshaped_sys]=system_reshape(sys)
    
    size_cell = [numel(sys.state) 1];

    state = reshape(num2cell(sys.state),size_cell);
    vaccin = reshape(num2cell(sys.vaccin),size_cell);
    r = reshape(num2cell(sys.r),size_cell);
    age = reshape(num2cell(sys.age),size_cell);
    
    reshaped_sys = cell2struct([state,vaccin,r,age],{'state','vaccin','r','age'},2);

    reshaped_sys = reshape(reshaped_sys,size(sys.r));
    
end