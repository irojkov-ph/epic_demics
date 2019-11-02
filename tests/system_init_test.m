% This file 

function tests = system_init_test
    addpath('../src/')
    tests = functiontests(localfunctions);
end

function test_invalid_input(testCase)
    % test no parameters
    verifyError(testCase, @() system_init(), 'ID:invalid_input');
    
    % test wrong parameters
    verifyError(testCase, @() system_init([1 2]), 'ID:invalid_input');
end

function test_good_execution(testCase)
    % test that the function status is equal to 1
    [~,actSolution] = evalc('system_init(5)');
    expSolution = 1;
    verifyEqual(testCase,actSolution,expSolution)
    
    global system
    % verify that the global variable exists
    import matlab.unittest.constraints.IssuesNoWarnings
    verifyThat(testCase,@() exist('system','var') , IssuesNoWarnings)
    
    actSolution = size(system.age);
    verifyEqual(testCase,actSolution,[5,5])
end