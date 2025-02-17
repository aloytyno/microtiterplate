% This is a simple script to explore the data after we've analyzed
% all 625 files with our scripts.  Using tables on strings and logical
% values to get insights into the data.

finaltable = importfinaltable('All_results.xlsx','Sheet2',2,5001);

%%  Visualize
figure
subplot(2,2,1); histogram(log10(finaltable.EC50));  title('EC50'), xlim ([-4,5])
subplot(2,2,3); histogram(finaltable.Hills_Slope);  title('Hills Slope')
subplot(2,2,[2,4]); scatter(log10(finaltable.EC50), finaltable.Hills_Slope);
title('Hills Slope vs. EC50'); xlim ([-4,5])
%% Add color to reliable and unreliable results
Trues = finaltable(finaltable.Reliable ==1,:)
Falses = finaltable(finaltable.Reliable == 0,:)
figure
scatter(log10(Trues.EC50), Trues.Hills_Slope, 'Marker','.')
hold on
scatter(log10(Falses.EC50), Falses.Hills_Slope, 'MarkerEdgeColor',[1 0 0],...
    'Marker','*')
% Create xlabel
xlabel('Log10(EC50)');

% Create ylabel
ylabel('Hills Slope');
xlim ([-3,5])
ylim ([0.5, 3.5])
legend('show')

%% Use Search Terms to Parse Tables Easily, for example

result = finaltable(finaltable.EC50 < 0.1 ...
    & contains(finaltable.FileName,'15')...
    & finaltable.Reliable ==1,:)

 
%% Copyright 2017 The MathWorks, Inc.

