% Function [sys]=system_init() 
%
% This function implement the system as an array of structures.
% Each structure sys.'field'(i,j) represent the value of the field 'field' 
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
%       - sys.age = sys.age + 1;    % Increase the age of each person by 1
%       - sys.age(i,j) = 50;        % Set the age of the (i,j) person to 50
% 
% This function will take as a parameter an integer n which defines the 
% size of the square matrix
% 
% 

function [sys]=system_init(n)
    
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
    sys.state = state;
    sys.vaccinated = vaccinated;
    sys.reward = reward;
    sys.age = age;    

end

