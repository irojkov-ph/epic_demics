% Function [status]=system_init() 
%
% This function implements the system as an array of structures.
% Each structure system.`field`(i,j) represents the value of the field `field` 
% for a person from the system which is in the position (i,j).  
% The fields and their values could be :
%       - state:        "S", "I" or "R" 
%       - vaccinated:    0 or 1
%       - reward:       a double that represents the reward of the person 
%       - age:          the age of the person
% That means the command sys.age will give the matrix of ages and
% sys.r the matrix of rewards.
% 
% To modify one specific field one can do it just by assigning the value to
% that field, i.e. :
%    - system.age = system.age + 1; % Increase the age of each person by 1
%    - system.age(i,j) = 50;        % Set the age of the (i,j) person to 50
% 
% This function takes no parameters and returns a status giving whether
% the global variable `system` was well created (status = 1)
% or not (status = -1).
% 
% 

function status = system_init()
    status = -1;
    
    global system

    if ~isnumeric(system.cfg.nb_cell) && system.cfg.nb_cell < 0
        error('ID:invalid_input','''nb_cell'' from the configuration parameters has to be integer.');
    end
    
    n = round(system.cfg.nb_cell);

    % Loading data in order to create a probability density function 
    pop_table = load('swiss_pop_age_2016.mat');
    x = [0 pop_table.data.age.'];
    x(2)=1e-3;
    Fx = [0 cumsum(pop_table.data.tot_per.')];
    
    % Creating the probability distribution of age
    pda = makedist('PiecewiseLinear','x',x,'Fx',Fx);

    % Decomment the following line in order to see the probability distribution
    %figure; plot([1:0.001:98],pdf(pda,[1:0.001:98])); 
    
    % Creating the age matrix (one can remove `round` if we assume decimal ages)
    age = round(random(pda,n));
    
    % Creating the rewards matrix
    reward = zeros(n);
    reward2 = zeros(n);
    
    % Creating the vaccination matrix
    vaccinated = zeros(n);
    
    % Creating the state matrix
    state = string(ones(n));
    state(:,:) = "S";
    
    % Adding a Patient Zero at a random position

    k = floor(rand.*n+1);
    l = floor(rand.*n+1);
    if ~isnan(system.cfg.patient_zero_coord) && isnumeric(system.cfg.patient_zero_coord)
        coord = round(system.cfg.patient_zero_coord);
        coord = coord(:);
        if coord(1)>0 && coord(1)<n+1 && coord(2)>0 && coord(2)<n+1
            k=coord(1);
            l=coord(2);
            system.cfg.patient_zero_coord = [k,l]; 
        else
            system.cfg.patient_zero_coord = NaN;
        end
    else
        system.cfg.patient_zero_coord = NaN;
    end
    state(k,l) = "I";

    % Filling the system structure
    system.state = state;
    system.vaccinated = vaccinated;
    system.reward = reward;
    system.age = age;
    system.reward2 = reward2;
    
    fprintf(['~~~~~~~~~~~~~~~~ Epic Demics ~~~~~~~~~~~~~~~~ \n', ...
        'A project of N.Delmotte, L.Pedrelli, I.Rojkov \n', ...
        'A system of size %d x %d was initialized as a \n', ...
        'global variable named `system`.\n'],n,n);
     
    status = 1;
end

