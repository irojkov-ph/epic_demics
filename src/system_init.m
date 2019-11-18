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
    if nargin<1
        error('ID:invalid_input','You have to specify an integer as a parameter.');
    end
    n = int8(n);
    if size(n,1)~=1 || size(n,2)~=1
        error('ID:invalid_input','''n'' has to be only one integer.');
    end
    
    global epic_demics_path
    a=dir();
    tmp = a(1).folder;
    idx = strfind(tmp,'epic_demics');
    epic_demics_path = tmp(1:idx+11);
    
    
    % Clear all global variables named `system` and create a new one
    clear global system
    global system
    
    % Include path for data
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
    
    % add a Patient Zero at a random position
    
    k = floor(rand.*n+1);
    l = floor(rand.*n+1);
    
    state(k,l) = "I";
    
    
    % The data table used was found on the site of the United Nations
    % https://population.un.org/wpp/Download/SpecialAggregates/EconomicTrading/
    % and gives the number of death (in thousands of people) during
    % the periond 1950 - 1955  divided by age classes of 5 years
    
    % For Switzerland data take values from I215 to AB215 in the
    % excel file
    
    % Creating the mortality distribution
    
    % mean population between years 1950 and 1950
    % taken on https://www.populationpyramid.net/switzerland/
    N_Switzerland = (4668088+4970810)/2;
    
    % Mortality calculated as death per day per total number of people
    mortality = xlsread('Mortality_by_age.xlsx','ESTIMATES AND MEDIUM VARIANT','I215:AB215').*1000./(5.*365)./N_Switzerland;
    
    %uncomment if willing to plot the mortality distribution per age
    %class_ages = [4,9,14,19,24,29,34,39,44,49,54,59,64,69,74,79,84,89,94,100];
    %figure
    %scatter(class_ages, mortality)
    %grid on
    
    % Filling the system structure
    system.state = state;
    system.vaccinated = vaccinated;
    system.reward = reward;
    system.age = age;
    system.mortality = mortality;
    
    % Creating the infectivity matrix
    % (needs the system to be already filled to use the function density_ill)
    
    beta = zeros(n);
    for i=1:n
        for j=1:n
            beta(i,j) = density_ill(i,j);
        end
    end
    
    % Filling the system structure of beta
    system.beta = beta;
    
    
    fprintf(['~~~~~~~~~~~~~~~~ Epic Demics ~~~~~~~~~~~~~~~~ \n', ...
        'A project of N.Delmotte, L.Pedrelli, I.Rojkov \n', ...
        'A system of size %d x %d was initialized as a \n', ...
        'global variable named `system`.\n'],n,n);
     
    status = 1;
end

