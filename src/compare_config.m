function status = compare_config(varargin)
    status = -1;

    default_config.nb_cell = 40;
    default_config.nb_decision_step = 104;
    default_config.dynamic = false;
    default_config.drawsystem = true;
    default_config.todraw = ["state_density";"state";"vaccinated";"reward";"age";"mean_age"];
    default_config.tosave = true;
    
    default_config.gamma = NaN;
    default_config.beta = NaN;
    default_config.alpha = 1/(4*6);
    default_config.zero = 1;
    default_config.mu = NaN;
    
    default_config.r_ill = -10;
    default_config.r_recover = 2;
    default_config.r_vacc = -4;
    
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