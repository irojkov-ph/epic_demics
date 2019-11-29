addpath('src/');

% config.zero = 0;
% config.mu = 0.0001;
config.nb_decision_step = 1000;
config.todraw = ["state_density";"vaccination_density";"state"];
%config.beta = 4.8;
config.r_ill = -10;
config.r_vacc = -4;
default_config.alpha = 1/(4*6);
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