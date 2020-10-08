% ------------------------------------------------------------------------
%    Rotation Based Iterative Gaussianization (RBIG)

%    Gaussianization Matlab toolbox based on the paper: 
%
%    "Iterative Gaussianization: from ICA to Random Rotations" 
%    IEEE Trans. Neur. Nets. 2010
%    by Laparra, Camps and Malo
% ------------------------------------------------------------------------
%
% The toolbox included in this zip file contains 4 basic functions:

%

% - RBIG.m    : It is the main function. 
%               It learns the Gaussianization trasnform for a given dataset 
%               as
 explained in the paper

%

% - apply_RBIG: It applies the transformation learned by RBIG.m over a

%               new data
 set
%

% - inv_RBIG  : It inverts the transformation learned by RBIG.m

%

% - RBIG_probability: it obtains the probability of data assuming that

%                     it follows the distribution learned with RBIG.m 
%
% In order to use ICA as rotation in the algorithm it is necessary 
% to download the fastICA software, available from:

% http://www.cis.hut.fi/projects/ica/fastica/code/FastICA_2.5.zip
%
% There is also a demo function "using_RBIG_example.m". This functions

% is an example of how to use the above functions for PDF estimation 
% and data synthesis 
%
% Copyright & Disclaimer
% 
% The programs are granted free of charge for research and education 
% purposes only. Scientific results produced using the software provided 
% shall acknowledge the use of the implementation provided by us. If you 
% plan to use it for non-scientific purposes, don't hesitate to contact us.
% 
% Because the programs are licensed free of charge, there is no warranty 
% for the program, to the extent permitted by applicable law. except when 
% otherwise stated in writing the copyright holders and/or other parties 
% provide the program "as is" without warranty of any kind, either 
% expressed or implied, including, but not limited to, the implied 
% warranties of merchantability and fitness for a particular purpose. the 
% entire risk as to the quality and performance of the program is with 
% you. should the program prove defective, you assume the cost of all 
% necessary servicing, repair or correction.
% 
% In no event unless required by applicable law or agreed to in writing 
% will any copyright holder, or any other party who may modify and/or 
% redistribute the program, be liable to you for damages, including any 
% general, special, incidental or consequential damages arising out of the 
% use or inability to use the program (including but not limited to loss 
% of data or data being rendered inaccurate or losses sustained by you or 
% third parties or a failure of the program to operate with any other 
% programs), even if such holder or other party has been advised of the 
% possibility of such damages.
