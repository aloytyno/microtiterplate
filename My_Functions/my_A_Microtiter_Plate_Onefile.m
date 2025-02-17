function plate_result = my_A_Microtiter_Plate_Onefile( ds )
%MY_A_MICROTITER_PLATE_ONEFILE A function to read and analyze one of multiple plates
%
% This is cut and pasted from the file A_Microtiter_Plate_Onefile.m,
% except we turned that script into a fucnction by adding a function call with 
% arguments at the top row. We also use a datastore to work with many
% files with the same format, instead of reading one file at a time.

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
% Read the data from the datastore as a table using the read function which
% reads one file (or one part of a large file) at a time.
[data,info] = read(ds);
filename = info.Filename;

%% VISUALIZE THE RAW DATA (Comment out when you run a lot of files)
% figure
% bar3(data)
% 
% figure
% boxplot(data)
% 
% figure
% waterfall(data)
% 
% figure
% microplateplot(data)
%% APPLY POSITIVE AND NEGATIVE CONTROLS
data = my_plate_controls(data);                                      

%% ASSOCIATE FILE NAMES AND COMPOUND NAMES
plate = my_file_metadata(data,filename);

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

%% MERGE RESULTS FROM EACH SECTION INTO A SINGLE TABLE
plate_result = [plate, fit_parameters_row, plate_qc];

end
% Copyright 2017 The MathWorks, Inc.
