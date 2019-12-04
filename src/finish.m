% Function status  = finish()
%
% Function which finishes the simulation and saves all drawings 
% in `./data/` folder if  the variable `tosave` is set to true.
% 
% 

function status = finish()
  status = -1;

  global system epic_demics_path

  % Save all the figures and the system in `./logs/` folder
  if system.cfg.tosave
    name = num2str(round(posixtime(datetime('now'))));
    
    save([epic_demics_path,filesep,'logs',filesep,char(system.cfg.name),name,'_system.mat'],'system');
    
    for i=1:length(system.cfg.todraw)
       h=findobj('Type', 'Figure', 'Name', system.cfg.todraw(i));
       saveas(h,[epic_demics_path,filesep,'logs',...
                filesep,char(system.cfg.name),name,'_',char(system.cfg.todraw(i)),'.fig']);
       close(h);
    end
    
    fprintf(['\nThe `system` structure as well as all the \n', ...
             'drawings have been saved in `./data/` . \n']);
  end

  fprintf(['\nThe simulation finished after %d steps(week). \n', ...
           '\nThank you for having reproduced `Epic Demics` \n',...
           '~~~~~~~~~~~~~~~~~~~ END ~~~~~~~~~~~~~~~~~~~~~ \n'],system.cfg.nb_decision_step);

  status = 1;

end