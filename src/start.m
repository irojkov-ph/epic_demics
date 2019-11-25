% Function start()
% or
% Function start(config)
%
% This function initialize, simulate, plot and save the system. If it takes
% no parameters, it will execute the simulation with default configuration.
%
% If on the otherhand it take a structure `config` as a parameter it will 
% replace default configuration parameters with the same name by the new 
% ones.
%
% (See `compare_config.m` for all existing parameters)
%
% The function returns the final time.
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
        
    global system
    
    %number of cells 
    n = system.cfg.nb_cell;
    %current time  
    t_now = 0;
    %nb of big steps  
    N = system.cfg.nb_decision_step;
    
    %dynamic evolution of the agents
    dynamic = system.cfg.dynamic;
    %to draw an attribute of the system while evolving
    drawsystem = system.cfg.drawsystem;
    %choose between "vaccinated", "age", "reward", "state", "state_density", "mean_age"
    todraw = system.cfg.todraw;
    
    if ~isnumeric(n)|| ~isnumeric(N)
        error ('ID:invalid_input','Input parameters are invalid.')
    end
    
    system_init(n);
        
    t_now = evolve_system(t_now,dynamic,N,drawsystem,todraw);
    
    
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

