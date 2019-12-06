addpath(['.',filesep,'src',filesep]);

%% Default simulation
start();

%% SIRS without vaccination
% clear config
% config.name = 'SIRS_no_vaccin';
% config.vaccination = false;
% start(config);

%% SIRS with dynamical agents
% clear config
% config.name = 'SIRS_no_vaccin';
% config.dynamic = true;
% start(config);

%% SIRS with a constant infection rate and a patient Zero
% clear config
% config.name = 'SIRS_const_beta_patient_zero';
% config.patient_zero_coord = [25,25];
% config.beta = 0.75;
% config.todraw = ["state";"state_density";"vaccination_density";"distance_from_patient_zero"];
% start(config);

%% SIRS on a bigger system and for a longer period
% clear config
% config.name = 'SIRS_bigger_and_longer';
% config.nb_cell = 200;
% config.nb_decision_step = 1000;
% config.todraw = ["state";"state_density";"vaccination_density";"local_vaccination_density"];
% start(config)

%% For a custom simulation, please refer to the compare_config.m file where you'll find all possible parameter you can change.