%% Microtiter Plate Analyisis - Single File Workflow
% This file completes the entire analysis of a single 96-well plate file
%
% 1. Import one.csv file from an instrument into a table 
%
% 2. Apply positive and negative controls on each file
% 
% 3. Add file and compound metadata to a table
%
% 4. Curve fit to a four parameter model to sigmoidal curve and fitresults
%
% 5. Turn fitresults into a table for each row
%
% 6. Quality control on the curve fit data from fitresults
%
% 7. Merge the subtables generated at each step into a single table
%
% Copyright 2017 The MathWorks, Inc.
% Developed by Jeff Gruneich, Ph.D., Heather Gorr, Ph.D.

%% LOAD DATA
filename = 'microtiter_data0001.csv';

% Use a custom function to load data into a table (function was generated
% from the Import Tool - note in this case we're using tables)
data = importfile_table(filename);

%% IDENTIFY DATA 
% The data was imported into a table, one of several types of data
% containers. Tables are designed for columnar or tabular data, so
% accessing data can be done easily  by name or by row and column numbers.
% The table also contains metadata accessible through properties.


% Adjust variable names for easier access to table data with english
data.Properties.VariableNames = {'NegControl','Conc1','Conc2','Conc3',...
    'Conc4','Conc5','Conc6','Conc7','Conc8','Conc9','Conc10','PosControl'};

% A benefit of tables is we can use intuitive names to identify the data of
% interest. For example, to identify data from one variable, use dot
% notation: neg = data.NegControl  
% you can explore the utility of tables in the DataAnalytics folder which
% has the results after processing all 625 96 well plate files.

% Here, we want to identify all of the data within the table. We can use
% row,column indexing to identify the subset of data. 
% With tables, you can extract a subset of the data as either a table or as 
% the underlying data type. Using parenthesis creates a table, using curly
% brackets creates an array of the underlying data type.
% data(:,1:12) % returns a table of all rows in columns 1-12
% data{:,1:12} % returns a numeric matrix of all rows in columns 1-12

% In this case, we can also use dot notation to access all variables as a matrix:
rawdata = data.Variables;

%% VISUALIZE THE RAW DATA
figure
bar3(rawdata)

figure
boxplot(rawdata)

figure
waterfall(rawdata)

%figure
%microplateplot(rawdata)
%% APPLY POSITIVE AND NEGATIVE CONTROLS
data = my_plate_controls(data)                                      

%% ASSOCIATE FILE NAMES AND COMPOUND NAMES
plate = my_file_metadata(data, filename)

%% ITERATE THROUGH EACH ROW OF THE PLATE FOR CURVE FIT AND QC DATA
% let's say 1 <---> 1 uM so we're ranging from 1 nM to 1 M, for example
X = log10([0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000, 100000, 1000000]);

% Identify variables of interest (Conc1, Conc2,..)
idx = contains(plate.Properties.VariableNames,'Conc');

for ii = 1:height(plate) 
    % SELECT DATA:
    % Identify data of interest from the table (one row, and all columns 
    % containing 'Conc' in the variable name)
    Y = plate{ii,idx};
    
    % CURVE FIT: pass a preprocessed row of data (Y) to our custom 4
    % parameter fit and get out a curve and associated parameters
    [fitresult, gof] = my_four_parameter_fit(X, Y);                               
    % build up the platefit table table of eight rows (one plate)
    fit_parameters_row(ii,:) = my_fit_parameters(fitresult, gof);
 
    % QUALITY CONTROL: pass EC50 and Hills_Slope into the this custom QC
    % function inspired by the literature and get back a QC table row
    plate_qc(ii,:) = my_qc(fit_parameters_row.EC50(ii), fit_parameters_row.Hills_Slope(ii));                      
                                                    
end
fit_parameters_row
plate_qc

%% MERGE RESULTS FROM EACH SECTION INTO A SINGLE TABLE
plate_result = [plate, fit_parameters_row, plate_qc]
