function [FileNames,ds] = my_select_microtiter_files() 
%MY_SELECT_MICROTITER_FILES Select which files to use and create a
%datastore to read the files.
%
%   To prototype we used autogenerated code to load one file from a
%   directory.  
%
%   This function uses uigetfile to allow the user to tell MATLAB a number 
%   of files to use at once.
%
%   This also uses a datastore to easily work with multiple files.

%% What files to load?

% Point MATLAB to your *.xlsx files in a directory 
[FileNames,PathName] = uigetfile({'*.csv';'*.xlsx';'*.xls'},'Select Data Files to Use','MultiSelect','on'); 

% If only one file was selected, convert the class of FileName from char to cell 
if ischar(FileNames)
    FileNames={FileNames}; 
end          

% We could use this later if we want to display the full file names including
% the directory information:
% FullFileName = fullfile(PathName,FileNames)

%% Create a datastore for all files selected
% A datastore is well-suited to working with many files or large data. It
% doesn't read all of the data immediately, but rather holds a set of
% pointers and metadata about the files or folders selected. This makes is
% easy to work with the datastore and specify information about the file or
% data before reading. 

% Pass the filenames or directory from UIgetfile to the function.
ds = datastore(FileNames);

% The datastore allows you to preview the data before reading anything into
% memory and adjust how the data will be imported.
% preview(ds)

%% Add variable names to the datastore
% When using a tabular text datastore (for txt and csv files), the file is
% read into MATLAB as a table. Add names to the variables in the datastore
% which will be used in the table.
ds.VariableNames = {'NegControl','Conc1','Conc2','Conc3',...
    'Conc4','Conc5','Conc6','Conc7','Conc8','Conc9','Conc10','PosControl'};

end

% Copyright 2017 The MathWorks, Inc.