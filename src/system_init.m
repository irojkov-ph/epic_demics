% Function [status]=system_init(n) 
%
% This function implement the system as an array of structures.
% Each structure sys.`field`(i,j) represent the value of the field `field` 
% for a person from the system which has the position (i,j)
% The fields and their values could be :
%       - state:        "S", "I" or "R" 
%       - vaccinated:    0 or 1
%       - reward:       a double that represents the reward of the persont 
%       - age:          the age of the person
% That means the command sys.age would give you the matrice of ages and
% sys.r matrice of rewards.
% 
% To modify one specific field one can do it just by assigning the value to
% that field, e.g. :
%    - system.age = system.age + 1; % Increase the age of each person by 1
%    - system.age(i,j) = 50;        % Set the age of the (i,j) person to 50
% 
% In ordrer to improve efficiency of the simulation, the `system` is 
% declared as a global variable. Thus this function take as a parameter an 
% integer `n` which defines the size of the square matrix and return a  
% status whenever the global variable is well created (status = 1)
% or not (status = -1).
% 
% 

function [status] = system_init(n)
    status = -1;
    
    % Test input is valid
    n = int8(n);
    if size(n,1)~=1 || size(n,2)~=1
        error('ID:invalid_input','''n'' has to be only one interger.');
    end
    
    global system
    
    % include path for data
    addpath('../data/')

    % Load data in order to create a probability density function 
    pop_table = load('swiss_pop_age_2016.mat');
    x = [0 pop_table.data.age.'];
    x(2)=1e-3;
    Fx = [0 cumsum(pop_table.data.tot_per.')];
    
    % Create the probability distribution of age
    pda = makedist('PiecewiseLinear','x',x,'Fx',Fx);
    
    % Decomment the following line in order to see the probability distribution
    %figure; plot([1:0.001:98],pdf(pda,[1:0.001:98])); 
    
    
    % Creating the age matrix (one can remove `round` if we assume decimal ages)
    age = round(random(pda,n));
    
    % Creating the rewards matrix
    reward = zeros(n);
    
    % Creating the vaccination matrix
    vaccinated = round(rand(n));
    
    % Creating the state matrix
    state = string(ones(n));
    state(:,:) = "S";
    
    
    % Filling the system structure
    system.state = state;
    system.vaccinated = vaccinated;
    system.reward = reward;
    system.age = age;
    
    status = 1;
end

