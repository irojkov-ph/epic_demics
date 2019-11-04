function tests = step_test
    tests = functiontests(localfunctions);
end

function test_invalid_input(testCase)
    % no input
    verifyError(testCase, @() step(), 'ID:invalid_input');
    % M is not numeric
    verifyError(testCase, @() step(1,1,"M",1), 'ID:invalid_input');
    % time interval 'dt' is negative
    verifyError(testCase, @() step(1,-1,3,1), 'ID:invalid_input');
end

function test_good_execution(testCase)
    [~,~]=evalc('system_init(5)');

    actSolution = step(1,0.5,7,1);
    expSolution = 1+0.5*7;
    verifyEqual(testCase,actSolution,expSolution)
end