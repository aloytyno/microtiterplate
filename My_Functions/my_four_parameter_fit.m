function [fitresult, gof] = my_four_parameter_fit(X,Y)
%CREATEFIT(X,Y)  This code is autogenerated from the Curve Fitting App
% in the MATLAB curve fitting toolbox.
%
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : X
%      Y Output: Y
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 18-Dec-2016 18:48:26


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( X, Y );

% Set up fittype and options.
ft = fittype( 'max + (min-max)/(1 + (10^x/EC50)^(Hills_Slope))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' ,'TolFun',1e-3);
opts.Display = 'Off';
opts.Lower = [1e-05 0 0 -20];
opts.StartPoint = [1 1 100 0];
opts.Upper = [10000000 10 120 5];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

%% Plot fit with data
% NOTE: if you call this function in an app, comment out this section
% since the app generates its own curve from fitresult and four parameter
% model. You can also speed up the final result over many plates if you do
% not plot.

% figure( 'Name', 'Dose-Response Curve' );
% h = plot( fitresult, xData, yData );
% legend( h, 'raw data for each row', 'Four Parameter Fit', 'Location', 'SouthEast' );
% xlim([-4, 7]);  ylim([-10, 110]); 
% Label axes
% xlabel('log10 [Compound] in uM')
% ylabel ('% Signal')
% grid on;
% hold('on')

% Copyright 2017 The MathWorks, Inc.
