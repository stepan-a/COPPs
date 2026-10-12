% Script to create Figure C2 in
% **de Groot, O., F. Mazelis, R. Motto, A. Ristiniemi**
% "A Toolkit for Computing Constrained Optimal Policy Projections (COPPs)"
%% Preamble
clear
% Dynare (with the copps package) must be in the MATLAB path.
root = pwd;

%% Run individual script
% Fig_C2_a (formerly IndividualProjections/Run_COPPs_Fig_C2_a.m)
siggma = 1;
varphi = 5;
phi_pi = 1.5;
phi_y  = 0.125;
theta_p= 3/4;
rho_nu = 0.5;
rho_z  = 0.5;
rho_a  = 0.9;
betta  = 0.99;
eta    = 3.77; %footnote 11, p. 115
alppha = 1/4;
epsilon_p = 9;
epsilon_w = 4.5;
theta_w   = 3/4;
lambda_p = 0.0215;
lambda_w = 0.0037;
W.y_gap = siggma+(varphi+alppha)/(1-alppha);
W.pi_p  = epsilon_p/lambda_p;
W.pi_w  = epsilon_w*(1-alppha)/lambda_w;
cd(fullfile(root, 'Models/GaliNKStickW'))
dynare GaliNKStickW -DSMOOTHER nograph noclearall
oo_ = copps.solve(M_, oo_, 'name',                          'Fig_C2_a', ...
                           'planner_discount_factor',       'betta', ...
                           'loss_function_variables',       {'pi_p';'pi_w';'y_gap'}, ...
                           'policy_instruments_and_shocks', {'r','er'}, ...
                           'past_periods',                  50, ...
                           'alpha',                         1, ...
                           't_loss',                        60, ...
                           'h_policy',                      60, ...
                           'constraint',                    'OFF', ...
                           'rate_min',                      0, ... % ELB in annual policy rate
                           'policy_rate_steady_state',      0, ...
                           'loss_function_weights',         [W.pi_p,W.pi_w,W.y_gap]);
cd(root)
projections_all.simple_rules = oo_.copps.Fig_C2_a.simple_rules;
projections_all.COPPs_C2a = oo_.copps.Fig_C2_a.COPPs;
clear params
%% Set preferences
params.plotting.Data = {projections_all.simple_rules.data   , '-'  , 1 ,[0,0,0], 'Baseline' ; ...
        projections_all.COPPs_C2a.data          , '--'  , 1 ,[0,0,1],'Optimal policy projection'; ...
        };

params.plotting.VarsToPlot = {...
    'pi_p_ann',[-.8,.2] ,'Inflation'  ; ...
    'y_gap'   ,[-.6,.05],'Output gap' ; ...
    'r'       ,[-.3,.1] ,'Policy rate'; ...
    };

params.plotting.P_past   = 4;
params.plotting.P_future = 28;

%% Plot chart
copps.plot(projections_all, params);
