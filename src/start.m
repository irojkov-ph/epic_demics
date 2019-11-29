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
        error('ID:invalid_input',['Input parameters are wrong. \n',...
                                  'main(config) has to take a structure `config` containing configuration parameters.'])
    end
    
    % Clear all global variables
    clear global

    % Set configuration for the system
    if nargin == 1
        compare_config(varargin{1});
    elseif nargin == 0
        compare_config();
    end
       
    global system;
    
    % Number of cells 
    n = system.cfg.nb_cell;
    % Current time  
    t_now = 0;
    % Number of decision steps  
    N = system.cfg.nb_decision_step;
    
    % Dynamics of the agents (false: static, true: dynamic)
    dynamic = system.cfg.dynamic;
    % Drawing condition (false: no drawing, true: drawing the system during evolution)
    drawsystem = system.cfg.drawsystem;
    % Attributes to draw while the system evolves
    % Choose "vaccinated", "age", "reward", "state", "state_density", "mean_age"
    todraw = system.cfg.todraw;
    
    % Initialize the system of size n
    system_init(n);
    
    % Let the system evolve
    t_now = evolve_system(t_now,dynamic,N,drawsystem,todraw);
    
    % Save all the figures and the system in `./logs/` folder
    if system.cfg.tosave
        global epic_demics_path
        name = num2str(round(posixtime(datetime('now'))));
        
        save([epic_demics_path,filesep,'logs',filesep,name,'_system.mat'],'system');
        
        for i=1:length(todraw)
           h=findobj('Type', 'Figure', 'Name', todraw(i));
           saveas(h,[epic_demics_path,filesep,'logs',filesep,name,'_',char(todraw(i)),'.fig']);
           close(h);
        end
        
    end
end

