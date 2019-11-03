function tests = displacement_test
    addpath('../src/')
    [~,~]=evalc('system_init(6)');
    global system
    system.state = ["S"    "S"    "S"    "S"    "S"    "S"; ...
                    "R"    "R"    "S"    "S"    "S"    "S"; ...
                    "S"    "I"    "S"    "S"    "S"    "S"; ...
                    "I"    "I"    "S"    "S"    "S"    "S"; ...
                    "S"    "I"    "S"    "S"    "S"    "S"; ...
                    "S"    "S"    "S"    "I"    "S"    "A"];
    tests = functiontests(localfunctions);
end

function test_invalid_input(testCase)
    % the specified state do not exist
    verifyError(testCase, @() displacement(6,6), 'ID:no_state');
    % the specified values is out of range
    verifyWarning(testCase, @() displacement(), 'ID:invalid_input');
    verifyWarning(testCase, @() displacement(9,9), 'ID:invalid_input');
end

function test_good_execution(testCase)
    global system
    
    % check if the function executes correctly
    actSolution = displacement(3,1);
    expSolution = 1;
    verifyEqual(testCase,actSolution,expSolution)
    
    % check if the function indeed moves the cells
    prevSolution = ["S"    "S"    "S"    "S"    "S"    "S"; ...
                    "R"    "R"    "S"    "S"    "S"    "S"; ...
                    "S"    "I"    "S"    "S"    "S"    "S"; ...
                    "I"    "I"    "S"    "S"    "S"    "S"; ...
                    "S"    "I"    "S"    "S"    "S"    "S"; ...
                    "S"    "S"    "S"    "I"    "S"    "I"];
    actSolution = system.state;
    expSolution = ismember(1,actSolution~=prevSolution);
    % we need to do that because the displacement is probabilistic
    while ~expSolution
        status = displacement(3,1);
        actSolution = system.state;
        expSolution = ismember(1,actSolution~=prevSolution);
    end
    verifyEqual(testCase,expSolution,true)
end