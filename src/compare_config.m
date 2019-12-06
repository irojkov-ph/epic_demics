% Function status = compare_config(varargin)
% 
% This function compares the given configuration to the default one and 
% sets a default value if a field is missing in the given configuration.
%
% See the table in README.md for further information about rates 
% and rewards used in the simulation.
%
% The function returns a status 1 if the execution is successful,
% 0 otherwise.
%

function status = compare_config(varargin)
    status = -1;

    % Name of the simulation
    default_config.name = '';
    
    % Size of the system and number of steps to simulate
    default_config.nb_cell = 50;
    default_config.nb_decision_step = 50;

    % Vaccination and dynamics of the agents
    default_config.vaccination = true;
    default_config.dynamic = false;
    
    % Drawing condition of the simulation
    % Choices "age", "vaccinated", "reward", "state", "state_density",
    %         "mean_age", "vaccination_density", "local_vaccination_density",
    %         "max_area_infection", "distance_from_patient_zero".
    default_config.drawsystem = true;
    default_config.todraw = ["state";"state_density";"vaccination_density"];

    % Saving condition of the simulation
    default_config.tosave = true;
    
    % Patient zero coordinate
    default_config.patient_zero_coord = NaN;
    
    % Rates used in the simulation
    default_config.beta = NaN;
    default_config.gamma = NaN;
    default_config.alpha = 1/(4*6);
    default_config.mu = NaN;
    default_config.zero = 1;
    
    % Rewards used in the simulation
    default_config.r_ill = -10;
    default_config.r_recover = 2;
    default_config.r_vacc = -4;
    
    % Replace the default configuration field values
    % defined above by the received configuration
    if nargin==1
        fnames = fieldnames(varargin{1});
        for i=1:size(fnames,1)
           default_config = setfield(default_config,fnames{i,1},getfield(varargin{1},fnames{i,1}));
        end
    end
    
    global system
    system.cfg = default_config;
    
    status = 1;
end