addpath('src/');

%% <<<<<<< NICO
% % config.zero = 0;
% % config.mu = 0.0001;
% config.nb_cell = 80;
% config.nb_decision_step = 200;
% config.todraw = ["state_density";"vaccination_density";"state"];
% %config.beta = 4.8;
% config.r_ill = -10;
% config.r_vacc = -4;
% default_config.alpha = 1/(4*6);
% config.p_zero_plus_neighbours = false;
% config.patient_zero_coord = [40,40];
% start(config);

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
% clear config
% config.name = 'test';
% n = 100;
% config.nb_cell = n;
% config.nb_decision_step = 500;
% config.patient_zero_coord = [n/2,n/2];
% config.p_zero_plus_neighbours = false;
% config.beta = 1;
% config.gamma = 2;
% config.todraw = ["state";"max_area_infection";"distance_from_patient_zero"];
% 
% start(config);


%% Variation of beta (1 to 10)
Bet = [0.97];
clear config
for i=1:length(Bet)
    try
        config.name = 'var_beta';
        config.nb_cell = 100;
        config.nb_decision_step = 200;
        config.patient_zero_coord = [50,50];
        config.p_zero_plus_neighbours = false;
        config.beta = Bet(i);
        config.todraw = ["state_density";"state";"vaccination_density";"max_area_infection";"distance_from_patient_zero"];
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

%% Variation of nb_cell (6 to 180 )
% N = [31,33,34,35,37,38,40,41];
% clear config
% for i=1:length(N)
%     try
%         config.name = 'var_nb_cell';
%         config.nb_cell = N(i);
%         config.nb_decision_step = 200;
%         config.patient_zero_coord = [N(i)/2,N(i)/2];
%         config.p_zero_plus_neighbours = false;
%         config.beta = 1;
%         config.todraw = ["state_density";"state";"vaccination_density";"max_area_infection";"distance_from_patient_zero"];
%         start(config);
%     catch ME
%         global epic_demics_path system
%         name = num2str(round(posixtime(datetime('now'))));
%         save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');
        
%         % Write in logs
%         fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
%         fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
%                         ME.identifier,'\n',ME.message,'\n']);
%         fclose(fileID);
        
%         close all;
%     end
% end
% clear N


% %% Long SIR w/o vaccination w/o dynamic
% clear config
% try
%     config.name = 'SIR_no_vacc_no_dyn';
%     config.nb_cell = 100;
%     config.nb_decision_step = 300;
%     config.vaccination = false;
%     config.dynamic = false;
%     config.todraw = ["state";"vaccination_density";"state_density"];
%     start(config);
% catch ME
%     global epic_demics_path system
%     name = num2str(round(posixtime(datetime('now'))));
%     save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

%     % Write in logs
%     fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
%     fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
%                     ME.identifier,'\n',ME.message,'\n']);
%     fclose(fileID);

%     close all;
% end

% %% Long SIR w vaccination w/o dynamic
% clear config
% try
%     config.name = 'SIR_yes_vacc_no_dyn';
%     config.nb_cell = 100;
%     config.nb_decision_step = 300;
%     config.vaccination = true;
%     config.dynamic = false;
%     config.todraw = ["state";"vaccination_density";"state_density"];
%     start(config);
% catch ME
%     global epic_demics_path system
%     name = num2str(round(posixtime(datetime('now'))));
%     save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

%     % Write in logs
%     fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
%     fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
%                     ME.identifier,'\n',ME.message,'\n']);
%     fclose(fileID);

%     close all;
% end

% %% Long SIR w/o vaccination w dynamic
% clear config
% try
%     config.name = 'SIR_no_vacc_yes_dyn';
%     config.nb_cell = 100;
%     config.nb_decision_step = 300;
%     config.vaccination = false;
%     config.dynamic = true;
%     config.todraw = ["state";"vaccination_density";"state_density"];
%     start(config);
% catch ME
%     global epic_demics_path system
%     name = num2str(round(posixtime(datetime('now'))));
%     save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

%     % Write in logs
%     fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
%     fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
%                     ME.identifier,'\n',ME.message,'\n']);
%     fclose(fileID);

%     close all;
% end

% %% Long SIR w vaccination w dynamic
% clear config
% try
%     config.name = 'SIR_yes_vacc_yes_dyn';
%     config.nb_cell = 100;
%     config.nb_decision_step = 300;
%     config.vaccination = true;
%     config.dynamic = true;
%     config.todraw = ["state";"vaccination_density";"state_density"];
%     start(config);
% catch ME
%     global epic_demics_path system
%     name = num2str(round(posixtime(datetime('now'))));
%     save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');

%     % Write in logs
%     fileID = fopen([epic_demics_path,filesep,'logs',filesep,'errors.txt'],'a+');
%     fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
%                     ME.identifier,'\n',ME.message,'\n']);
%     fclose(fileID);

%     close all;
% end

% %% Variation of alpha
% % for i=1:20
% %     try
% %         config.name = 'var_alpha';
% %         config.nb_cell = 100;
% %         config.nb_decision_step = 500;
% %         config.alpha = 0.05*(i-1);
% %         config.todraw = ["state";"max_area_infection";"vaccination_density";"state_density";"mean_age"];
% %         start(config);
% %     catch ME
% %         global epic_demics_path system
% %         name = num2str(round(posixtime(datetime('now'))));
% %         save([epic_demics_path,filesep,'logs',filesep,config.name,name,'_system_error.mat'],'system');
% %         
% %         % Write in logs
% %         fileID = fopen([epic_demics_path,filesep,'logs',config.name,filesep,'errors.txt'],'a+');
% %         fprintf(fileID,['\n ERROR in simulation ',config.name,name,'! Here is the log of the error: \n',...
% %                         ME.identifier,'\n',ME.message,'\n']);
% %         fclose(fileID);
% %         
% %         close all;
% %     end
% % end
