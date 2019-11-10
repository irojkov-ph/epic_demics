% The aim of this script is to execute a general test of merely all
% functions present in the `./src` folder. You just have to execute the
% following lines.
%

addpath('./test_functions/')
addpath('../src/')

all_test_func = {dir('./test_functions/').name}.';
all_test_func = all_test_func(3:11);

for i=1:size(all_test_func,1)
    runtests(all_test_func{i,1}); 
    pause(0.5)
end