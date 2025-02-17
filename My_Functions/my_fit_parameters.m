function fit_parameters_row = my_fit_parameters(fitresult,gof)
%MY_FIT_PARAMETERS Create tables with the results and goodness-of-fit information
% from the curve fit

% Use methods(fitresult), or methods(gof) and doc to understand what data 
% is in these results provided by curve fitting app. 

%% Create tables from fitresult and gof
% Convert the data to a table
fit_results_table = array2table(coeffvalues(fitresult),...
    'VariableNames', coeffnames(fitresult));

gof_results_table = struct2table(gof);

% Select which variables of the table to pass back in fit_parameters_row
fit_parameters_row = [fit_results_table, gof_results_table(:,{'sse','rsquare'})];


end

% Copyright 2017 The MathWorks, Inc.