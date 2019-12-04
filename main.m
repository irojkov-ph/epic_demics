addpath('src/');

%%
% <<<<<<< LORIS
config.name = 'only_dynamic';
    
config.nb_cell = 100;
config.nb_decision_step = 1000000;
config.vaccination = false;
config.dynamic = true;

config.drawsystem = true;
% "age"; "vaccinated"; "reward"; "state"; "state_density"; "mean_age";
% "vaccination_density"; "local_vaccination_density"; "max_area_infection";
% "distance_from_patient_zero"
config.todraw = ["state"];
config.tosave = true;

% config.patient_zero_coord = [39,39];
% config.p_zero_plus_neighbours = true;

config.gamma = 0;
config.beta = 0;
config.alpha = 0;
config.zero = 0;
config.mu = 0;

% config.r_ill = -10;
% config.r_recover = 2;
% config.r_vacc = -4;

start(config);


%%
% <<<<<<< NICO
% config.zero = 0;
% config.mu = 0.0001;
config.nb_cell = 80;
config.nb_decision_step = 200;
config.todraw = ["state_density";"vaccination_density";"state"];
%config.beta = 4.8;
config.r_ill = -10;
config.r_vacc = -4;
config.alpha = 1/(4*6);
config.p_zero_plus_neighbours = false;
config.patient_zero_coord = [40,40];
start(config);

% for i=1:20
%     try
%         config.nb_cell = 30;
%         config.nb_decision_step = 10;
%         config.zero = 0.1 + 0.05*i;
%         start(config);
%     catch ME
%         global epic_demics_path system
%         name = num2str(round(posixtime(datetime('now'))));
%         save([epic_demics_path,filesep,'logs',filesep,name,'_system_error.mat'],'system');
%         
%         % Write in logs
%         fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
%         fprintf(fileID,['\n ERROR in simulation ',name,'! Here is the log of the error: \n',...
%                         ME.identifier,'\n',ME.message,'\n']);
%         fclose(fileID);
%         
%         close all;
%     end
% end

%% <<<<<<< IVAN
% config.zero = 0;
% config.mu = 0.0001;
config.name = 'test';
config.nb_cell = 80;
config.nb_decision_step = 200;
config.todraw = ["state";"distance_from_patient_zero"];
config.dynamic = true;
config.patient_zero_coord = [40,40];
config.p_zero_plus_neighbours = false;

start(config);


%% Variation of beta
for i=11:20
    try
        config.name = 'var_beta';
        config.nb_cell = 100;
        config.nb_decision_step = 500;
        config.beta = 0.05*(i-1);
        config.todraw = ["state_density";"state";"vaccination_density";"mean_age"];
        start(config);
    catch ME
        global epic_demics_path system
        name = num2str(round(posixtime(datetime('now'))));
        save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');
        
        % Write in logs
        fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
        fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
                        ME.identifier,'\n',ME.message,'\n']);
        fclose(fileID);
        
        close all;
    end
end


%% Long SIR w/o vaccination w/o dynamic
try
    config.name = 'SIR_no_vacc_no_dyn';
    config.nb_cell = 100;
    config.nb_decision_step = 500;
    config.vaccination = false;
    config.dynamic = false;
    config.todraw = ["state";"max_area_infection";"vaccination_density";"state_density";"mean_age"];
    start(config);
catch ME
    global epic_demics_path system
    name = num2str(round(posixtime(datetime('now'))));
    save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

    % Write in logs
    fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
    fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
                    ME.identifier,'\n',ME.message,'\n']);
    fclose(fileID);

    close all;
end

%% Long SIR w vaccination w/o dynamic
try
    config.name = 'SIR_yes_vacc_no_dyn';
    config.nb_cell = 100;
    config.nb_decision_step = 500;
    config.vaccination = true;
    config.dynamic = false;
    config.todraw = ["state";"max_area_infection";"vaccination_density";"state_density";"mean_age"];
    start(config);
catch ME
    global epic_demics_path system
    name = num2str(round(posixtime(datetime('now'))));
    save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

    % Write in logs
    fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
    fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
                    ME.identifier,'\n',ME.message,'\n']);
    fclose(fileID);

    close all;
end

%% Long SIR w/o vaccination w dynamic
try
    config.name = 'SIR_no_vacc_yes_dyn';
    config.nb_cell = 100;
    config.nb_decision_step = 500;
    config.vaccination = false;
    config.dynamic = true;
    config.todraw = ["state";"max_area_infection";"vaccination_density";"state_density";"mean_age"];
    start(config);
catch ME
    global epic_demics_path system
    name = num2str(round(posixtime(datetime('now'))));
    save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

    % Write in logs
    fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
    fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
                    ME.identifier,'\n',ME.message,'\n']);
    fclose(fileID);

    close all;
end

%% Long SIR w vaccination w dynamic
try
    config.name = 'SIR_yes_vacc_yes_dyn';
    config.nb_cell = 100;
    config.nb_decision_step = 500;
    config.vaccination = true;
    config.dynamic = true;
    config.todraw = ["state";"max_area_infection";"vaccination_density";"state_density";"mean_age"];
    start(config);
catch ME
    global epic_demics_path system
    name = num2str(round(posixtime(datetime('now'))));
    save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

    % Write in logs
    fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
    fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
                    ME.identifier,'\n',ME.message,'\n']);
    fclose(fileID);

    close all;
end


%% Long SIR w/o vaccination w/o dynamic w patient zero in the middle
try
    config.name = 'SIR_no_vacc_no_dyn_w_PZ';
    config.nb_cell = 100;
    config.nb_decision_step = 500;
    config.vaccination = false;
    config.dynamic = false;
    config.patient_zero_coord = [50,50];
    config.todraw = ["state";"max_area_infection";"vaccination_density";"state_density";"mean_age";"age"];
    start(config);
catch ME
    global epic_demics_path system
    name = num2str(round(posixtime(datetime('now'))));
    save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

    % Write in logs
    fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
    fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
                    ME.identifier,'\n',ME.message,'\n']);
    fclose(fileID);

    close all;
end

%% Long SIR w vaccination w/o dynamic w patient zero in the middle
try
    config.name = 'SIR_yes_vacc_no_dyn_w_PZ';
    config.nb_cell = 100;
    config.nb_decision_step = 500;
    config.vaccination = true;
    config.dynamic = false;
    config.patient_zero_coord = [50,50];
    config.todraw = ["state";"max_area_infection";"vaccination_density";"state_density";"mean_age";"age"];
    start(config);
catch ME
    global epic_demics_path system
    name = num2str(round(posixtime(datetime('now'))));
    save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

    % Write in logs
    fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
    fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
                    ME.identifier,'\n',ME.message,'\n']);
    fclose(fileID);

    close all;
end

%% Long SIR w/o vaccination w dynamic w patient zero in the middle
try
    config.name = 'SIR_no_vacc_yes_dyn_w_PZ';
    config.nb_cell = 100;
    config.nb_decision_step = 500;
    config.vaccination = false;
    config.dynamic = true;
    config.patient_zero_coord = [50,50];
    config.todraw = ["state";"max_area_infection";"vaccination_density";"state_density";"mean_age";"age"];
    start(config);
catch ME
    global epic_demics_path system
    name = num2str(round(posixtime(datetime('now'))));
    save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

    % Write in logs
    fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
    fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
                    ME.identifier,'\n',ME.message,'\n']);
    fclose(fileID);

    close all;
end

%% Long SIR w vaccination w dynamic w patient zero in the middle
try
    config.name = 'SIR_yes_vacc_yes_dyn_w_PZ';
    config.nb_cell = 100;
    config.nb_decision_step = 500;
    config.vaccination = true;
    config.dynamic = true;
    config.patient_zero_coord = [50,50];
    config.todraw = ["state";"max_area_infection";"vaccination_density";"state_density";"mean_age";"age"];
    start(config);
catch ME
    global epic_demics_path system
    name = num2str(round(posixtime(datetime('now'))));
    save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

    % Write in logs
    fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
    fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
                    ME.identifier,'\n',ME.message,'\n']);
    fclose(fileID);

    close all;
end

%% Variation of alpha
for i=1:20
    try
        config.name = 'var_alpha';
        config.nb_cell = 100;
        config.nb_decision_step = 500;
        config.alpha = 0.05*(i-1);
        config.todraw = ["state";"max_area_infection";"vaccination_density";"state_density";"mean_age"];
        start(config);
    catch ME
        global epic_demics_path system
        name = num2str(round(posixtime(datetime('now'))));
        save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');
        
        % Write in logs
        fileID = fopen([epic_demics_path,filesep,'logs',config.name,filesep,'errors.txt'],'a+');
        fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
                        ME.identifier,'\n',ME.message,'\n']);
        fclose(fileID);
        
        close all;
    end
end
