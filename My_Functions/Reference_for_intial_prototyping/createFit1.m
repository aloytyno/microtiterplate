function [fitresult, gof] = createFit1(X, Y)
%CREATEFIT1(X,Y)
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

%  Auto-generated by MATLAB on 22-May-2017 12:43:48


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( X, Y );

% Set up fittype and options.
ft = fittype( 'max + (min-max)/(1 + (10^x/EC50)^(Hills_Slope))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1e-06 0.0001 0 -10];
opts.StartPoint = [1 1 80 0];
opts.Upper = [10000000 10 120 110];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'Y vs. X', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel X
ylabel Y
grid on


