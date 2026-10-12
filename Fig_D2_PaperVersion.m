%% ########################################################################
%% ################ Constrained Optimal Policy Projections ################
%% ########################################################################
%
% **de Groot, O., F. Mazelis, R. Motto, A. Ristiniemi**
% "A Toolkit for Computing Constrained Optimal Policy Projections (COPPs)"
% This  version: 1.0
%__________________________________________________________________________
%% ########################################################################
%% ##################             Preamble               ##################
%% ########################################################################
%%
clear;
clc;

% Dynare (with the copps package) must be in the MATLAB path.
root = pwd;

cd(fullfile(root, 'Models/SW07'))
dynare Smets_Wouters_2007_GB09 -DSMOOTHER -DFlatPC -DSteepFwd nograph noclearall
plotting.VarsToPlot = {...
    'obs_pinf_4q' , [ -1 ,  4 ]  , 'Inflation (annual, P.P.)'     ; ...
    'ygap'        , [ -9 ,  6 ]  , 'Output gap (P.P.)'            ; ...
    'obs_r_ann'   , [ -8 ,  7]   , 'Interest rate (annual, P.P.)' ; ...
    'qeobs'       , [ -5 ,  50 ] , 'Asset holdings (% of GDP) '   ; ...
    };
plotting.first_date = datetime(1954,7,01); % Set the first date of the data series
plotting.freq       = 'quarter'; % Frequency of data (month/quarter/year)
oo_ = copps.solve(M_, oo_, 'name',                          'Fig_D2', ...
                           'planner_discount_factor',       'beta_ss', ...
                           'loss_function_variables',       {'obs_pinf_4q';'ygap';'dr'}, ...
                           'policy_instruments_and_shocks', {'r' ,'em'}, ...
                           'past_periods',                  219, ... % 2009 March
                           'alpha',                         0.7, ... % 30% of agents are inattentive to announcements (default)
                           'loss_function_weights',         [1,0.25,4], ...
                           'constraint',                    'ON', ...
                           'rate_min',                      0.1, ... % ELB in annual policy rate
                           'policy_rate_steady_state',      'ss_r_ann', ... % Parameter name of annual StSt policy rate
                           't_full',                        78, ... % How far into the future to roll the forecast forward.
                           'plotting',                      plotting);
cd(root)
params = oo_.copps.Fig_D2.params;
copps.plot(oo_.copps.Fig_D2, params);
