function tests = evolve_cell_test
    
    addpath('../src/')
    [~,~]=evalc('system_init(6)');
    global system
    system.state = ["S"    "S"    "S"    "S"    "S"    "S"; ...
                    "R"    "R"    "S"    "S"    "S"    "S"; ...
                    "S"    "I"    "S"    "S"    "S"    "S"; ...
                    "I"    "I"    "S"    "S"    "S"    "S"; ...
                    "S"    "I"    "S"    "S"    "S"    "S"; ...
                    "S"    "S"    "S"    "I"    "S"    "S"];
    system.vaccinated = [1    1    1    1    1    1; ...
                  1    1    1    1    1    1; ...
                  0    1    1    1    1    1; ...
                  1    1    1    1    1    1; ...
                  1    1    1    1    1    1; ...
                  1    1    1    1    1    1 ];
    system.age = [10    10    10    10    10    10; ...
                  10    10    10    10    10    10; ...
                  80    10    10    10    10    10; ...
                  10    10    10    10    10    10; ...
                  10    10    10    10    10    10; ...
                  10    10    10    10    10    10 ];
    system.reward = [5    5    5    5    5    5; ...
                     5    5    5    5    5    5; ...
                    19    5    5    5    5    5; ...
                     5    5    5    5    5    5; ...
                     5    5    5    5    5    5; ...
                     5    5    5    5    5    5 ];

    tests = functiontests(localfunctions);
end

function test_invalid_input(testCase)
    % no input
    verifyError(testCase, @() evolve_cell(), 'ID:invalid_input');
    % the specified values is out of range
    verifyError(testCase, @() evolve_cell(1,1,9,9), 'ID:invalid_input');
    % time interval 'dt' is negative
    verifyError(testCase, @() evolve_cell(1,-1,3,1), 'ID:invalid_input');
end

function test_good_execution(testCase)
    
    global system

    state = "S";
    vaccinated = 0;
    age = 80;
    reward = 19;
    
    % check if the function executes correctly
    actSolution = evolve_cell(1,0.5,3,1);
    expSolution = 1.5;
    verifyEqual(testCase,actSolution,expSolution)
    
    % check if the function indeed moves the cells
    state_changed = ismember(1,state ~= system.state(3,1));
    vaccin_changed = ismember(1,vaccinated ~=system.vaccinated(3,1));
    age_changed = ismember(1,age ~= system.age(3,1));
    reward_changed = ismember(1,reward ~= system.reward(3,1));
    
    actSolution = state_changed + vaccin_changed + age_changed + reward_changed;
    expSolution = 1;
    
    verifyGreaterThanOrEqual(testCase,actSolution,expSolution)
end