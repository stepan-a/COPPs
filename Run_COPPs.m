
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
dynare Smets_Wouters_2007_GB09 -DSMOOTHER nograph noclearall
plotting.first_date  = datetime(1954,7,01); % Set the first date of the series
plotting.freq        = 'quarter'; % Frequency of data (month/quarter/year)
oo_ = copps.solve(M_, oo_, 'name',                          'projection', ...
                           'planner_discount_factor',       'beta_ss', ...
                           'loss_function_variables',       {'obs_pinf_4q';'ygap';'dr'}, ...
                           'policy_instruments_and_shocks', {'r' ,'em'}, ...
                           'past_periods',                  219, ... % 2009 March
                           'alpha',                         0.7, ... % 30% of agents are inattentive to announcements (default)
                           't_full',                        78, ... % How far into the future to roll the forecast forward.
                           'plotting',                      plotting);
cd(root)
params = oo_.copps.projection.params;
copps.plot(oo_.copps.projection, params);
