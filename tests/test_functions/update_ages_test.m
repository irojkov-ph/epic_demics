function tests = update_ages_test
    [~,~]=evalc('system_init(4)');
    global system
    system.age = [ 1, 2, 3, 4; ...
                  35,37,39,40; ...
                  79,85,89,22; ...
                  97,98,99,102    ];
    tests = functiontests(localfunctions);
end

function test_invalid_input(testCase)
    verifyError(testCase, @() update_ages(), 'ID:invalid_input');
    
    verifyError(testCase, @() update_ages([2 5]), 'ID:invalid_input');
end

function test_good_execution(testCase)
    % test that it indeed increase the ages
    actSolution = update_ages(5);
    expSolution = 1;
    verifyEqual(testCase,actSolution,expSolution)
    
    global system
    actSolution = system.age;
    expSolution = [ 6, 7, 8, 9; ...
                   40,42,44,45; ...
                   84,90,94,27; ...
                   102,103,104,107 ];
    verifyEqual(testCase,actSolution,expSolution)
end