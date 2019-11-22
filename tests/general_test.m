% The aim of this script is to execute a general test of merely all
% functions present in the `./src` folder. You just have to execute the
% following lines.
%

a=dir();
tmp = a(1).folder;
idx = strfind(tmp,'epic_demics');
global_path = tmp(1:idx+11);

addpath([global_path,filesep,'tests',filesep,'test_functions'])
addpath([global_path,filesep,'src'])

all_test_func = {dir([global_path,filesep,'tests',filesep,'test_functions']).name}.';
all_test_func = all_test_func(3:11);
all_test_result = {};

for i=1:size(all_test_func,1)
    all_test_result{i} = runtests(all_test_func{i,1}); 
    pause(0.2)
end

success = sum(cellfun(@(x) x.Passed,all_test_result)); 
failed = sum(cellfun(@(x) x.Failed,all_test_result));
incomplete = sum(cellfun(@(x) x.Incomplete,all_test_result));

fprintf('Among %d tests: %d Passed, %d Failed, %d Incomplete\n',size(all_test_func,1),success,failed,incomplete)

