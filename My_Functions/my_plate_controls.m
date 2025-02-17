function data = my_plate_controls(data)
%MY_PLATE_CONTROLS Scale the data based on negative and positive control.
%
% We need to do two operations to our raw data - a negative control and the
% positive control - and pass back the pre-processed array for further
% analysis
%
%% Apply the negative and positive controls
% NEGATIVE CONTROL: Subtract the mean of the first column of experimental data 
% from the value in each well in all the wells
data.Variables = data.Variables - mean(data.NegControl);

% POSITIVE CONTROL: Scale (normalize) each row so that the Postitive Control 
% is 100
data.Variables = data.Variables ./ data.PosControl*100;
    
end


% Copyright 2017 The MathWorks, Inc.
