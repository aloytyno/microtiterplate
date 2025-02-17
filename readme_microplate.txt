Notes:
* make sure you add the subdirectories to your path.
* this code works in 2017a
% Copyright 2017 The MathWorks, Inc.
% Developed by Jeff Gruneich, Ph.D., Heather Gorr, Ph.D., Jeremy Huard, M.S.
____________

This set of folders has raw data, finished app, and the steps in between
as an example you can borrow from :
1. Initial visualization and exploration of data (reference folder)
2. Prototyping one workflow on one file (A_Microtiter_Plate_Onefile)
3. Applying this to multiple files (A_microtiter_plate_Final)
4. Deploying the useful parts of this to an app designer app (MicroPlateBroser_v2)


Contents
The top level directory contains:
1. A_Microtiter_Plate_Onefile showing a complete workflow for one file.
2. A_microtiter_plate_Final showing the workflow for many files programmatically.
3. Equations (3 parameter, 4 parameter, 5 parameter) we used the four parameter for curve fitting.
4. A saved session of curve fitting - open this from inside the curve fitting app.

Folders:
1. Data Analytics: example of how to use tables, strings and logical operations to explore 5000 computed rows of data from 625 microwell plate files
2. Experimental Data:  625 8x12 well plate files each representing typical 96-well plate data you get from a plate reader instrument
3. my_functions folder:  is a directory which contains all of the custom functions called by the app, algorithm exploration, final script.

Inside the my_functions folder is a folder showing the intial prototyping to get to an EC50 table
And the finished file for the app built in app designer


____________________

If you get stuck or have questions, please call or email Jeff Gruneich at 
508-647-7597 office
617-775-2173 mobile (if urgent)
jeff.gruneich@mathworks.com

* Note, more information including videos, links to community code, etc. is available at 
https://www.mathworks.com/solutions/biological-sciences.html


