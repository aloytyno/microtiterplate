%% Typical workflow to automate analysis of spreadsheet files
% This will take us through automation of analysis of a spreadsheet file.
% This is intended to represent a snapshot in time for how you might get
% started with MATLAB.  We'd still need to do another loop for each file.

% Subsequent to this, one might go on to do more to complete a workflow:
% See script for one file in the Reference Folder, which is turned into a
% function and then called by the script for Many files. Which is then
% borrowed and deployed into the app designer code in the reference folder
% to show how a researcher with limited programming skills can build their
% own custom workflows or software.

% (C) 2017 The MathWorks Inc.  Developed by Jeffrey Gruneich, PhD 

%% Load
Data = importfile1('microtiter_data0001.csv', 1, 8);

%% Visualize
figure
bar3(Data)

figure
boxplot(Data)

figure
waterfall(Data)

%% Analyze
% fit a curve for each row
X = -3:1:6 % e.g. 10^-3 uM to 10^6 uM serial dilutions
Y = Data(1,2:11)

plot(X,Y)

% create your own customized plot with plot tools
createfigure1(X,Y)

%% Curve Fit
% generate code to curve fit from the curve fitting app
[fitresult, gof] = createFit1(X, Y)

% Use methods(fitresult) or search 'curve fit coefficients' in documentation
fitresult.EC50

% Verify EC50 is working
log10(fitresult.EC50)   

% See that we can pull out the parameters from the curve fit easily
coeffvalues(fitresult)
coeffnames(fitresult)'

% build a table from those parameters so we can automate easier
EC50_Table = array2table(coeffvalues(fitresult),'VariableNames',coeffnames(fitresult)')
%% Automate the key steps of our workflow above for each plate
% figure  % try uncommenting this and turn off new figure in createFit1 

[numrrows,numcolumns] = size(Data); % we can make this more flexible than just 8x12
for ii = 1:numrows
    Y = Data(ii,2:11)
    [fitresult, gof] = createFit1(X, Y);
    EC50_Table(ii,:) = array2table(coeffvalues(fitresult),'VariableNames',coeffnames(fitresult)')
    hold on
end

%% Write results to screen
EC50_Table

%% Write results to a file
writetable(EC50_Table, 'EC50_Table.xls')
winopen('EC50_Table.xls')


