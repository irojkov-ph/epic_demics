% Function [reshaped_sys] = system_reshape() 
%
% This function reshapes the system as it is initialized by the
% `system_init.m` function. The aim of this function is to provide a more
% instinctive way to look at the system.
% 
% `reshaped_sys` is an n x n array of structures which represent people
% in the system and have the following fields:
%       - state:        'S', 'I' or 'R' 
%       - vaccinated:    0 or 1
%       - reward:       a double that represents the reward of the person 
%       - age:          the age of the person
%
% E.g.:
%       - reshaped_sys(i,j) is a structure with 4 values representing the
%         (i,j) person.
%       - reshaped_sys(i,j).age is the age of that person.
% 
% This function will not rewrite the actual `system` variable but will
% create a reshaped copy of it.
%
%

function [reshaped_sys] = system_reshape()
    
    global system

    size_cell = [numel(system.state) 1];

    state = reshape(num2cell(system.state),size_cell);
    vaccinated = reshape(num2cell(system.vaccinated),size_cell);
    reward = reshape(num2cell(system.reward),size_cell);
    age = reshape(num2cell(system.age),size_cell);
    
    reshaped_sys = cell2struct([state,vaccinated,reward,age],{'state','vaccinated','reward','age'},2);

    reshaped_sys = reshape(reshaped_sys,size(system.reward));
    
end