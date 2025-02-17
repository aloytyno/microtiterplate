function data = my_file_metadata(data, filename)
%MY_FILE_METADATA Add metadata about the plate to the table 
%   Determine the file name and compound number and add this information as 
%   variables to the table

%% Determine number of rows in the table
numRows = height(data);

%% Add file name and compound number 
% Determine file name and extension and create a string
[~,name,ext] = fileparts(filename);
fname = string([name,ext]);
% Create a new variable in the table for the file names
data.FileName = repmat(fname,numRows,1);

% Determine the compound number from the file name and convert to numeric
filenum = extractBetween(fname,'data','.csv');
filenum = double(filenum);  
data.CompoundNumber = (filenum-1)*numRows + (1:numRows)';

%% Rearrange columns
% The new variables are automatically added as the last variables in the
% table. Adjust the order of the variables so these are the first ones
data = data(:,[end-1, end, 1:end-2]);

end
% Copyright 2017 The MathWorks, Inc.
