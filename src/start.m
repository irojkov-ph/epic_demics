% Function start()
% or
% Function start(config)
%
% This function initializes, simulates, plots and saves the system. 
% If it takes no parameter, it will execute the simulation with default 
% configuration.
% If on the other hand it takes a structure `config` as a parameter,
% it will replace default configuration parameters with the same name 
% by the new ones.
% 
% (See `compare_config.m` for all existing parameters)
% 

function start(varargin)
    
    if nargin > 1 || (nargin==1 && ~isstruct(varargin{1}))
        error('ID:invalid_input',['Input parameters are wrong.',...
                                  '`start(config)` has to take a structure `config` containing configuration parameters.'])
    end
    
    % Clear all global variables
    clear global

    % Set configuration for the system
    if nargin == 1
        compare_config(varargin{1});
    elseif nargin == 0
        compare_config();
    end
    
    % Create a global path for the simulation
    global epic_demics_path
    epic_demics_path = pwd;

    % Create a global structure system
    global system
    
    % Current time  
    t_now = 0;
    % Number of decision steps  
    N = system.cfg.nb_decision_step;
    % Vaccination of the agents (false: no vaccin, true: vaccin)
    vaccination = system.cfg.vaccination;
    % Dynamics of the agents (false: static, true: dynamic)
    dynamic = system.cfg.dynamic;
    % Drawing condition (false: no drawing, true: drawing the system during evolution)
    drawsystem = system.cfg.drawsystem;
    
    % Initialize the system
    system_init();
    
    % Let the system evolve
    t_now = evolve_system(t_now,N,vaccination,dynamic,drawsystem,system.cfg.todraw);
    
    % Finish and save the current simulation 
    finish();

end