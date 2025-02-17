function [topleads, finaltable] = my_export_microplate_results(finaltable)
%MY_EXPORT_MICROPLATE_RESULTS  Exports the results to a spreadsheet
%
%   This sorts the rows of the final table by EC50 and then by row 23,
%   writes to the second tab of a a spreadsheet, then selects the top 13%
%   (approximately one top compound per plate) and writes this to the first
%   tab of a spreadsheet.
% 

% Sort the data in the table 
finaltable = sortrows(finaltable,'EC50');
finaltable = sortrows(finaltable, -23);
% Write all data to Sheet2
writetable(finaltable,'Final_Microplate_Results.xlsx','Sheet',2);

% Determine top leads and write the data to Sheet1
topleads = finaltable(1:(0.13*height(finaltable)) , {'FileName', 'CompoundNumber', 'EC50', 'Reliable'});
writetable(topleads,'Final_Microplate_Results.xlsx','Sheet',1);

end

% Copyright 2017 The MathWorks, Inc.