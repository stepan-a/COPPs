  _______   _______   _______   _______   
 |  ___  | |  ___  | |  ___  | |  ___  |  ______ 
 | |   |_| | |   | | | |   | | | |   | | |  ____|
 | |       | |   | | | |___| | | |___| | | |____ 
 | |    _  | |   | | |  _____| |  _____| |____  |
 | |___| | | |___| | | |       | |        ____| |
 |_______| |_______| |_|       |_|       |______|

A Toolkit for Computing Constrained Optimal Policy Projections
Version 1.1

de Groot, Mazelis, Motto, Ristiniemi
ECB Working Paper 2021 No. 2555
https://ideas.repec.org/p/ecb/ecbwps/20212555.html

Copyright (C) de Groot, Mazelis, Motto, Ristiniemi

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation,  version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

--------------------------------------------------------------

For further information, visit https://github.com/COPPsToolkit/COPPs

--------------------------------------------------------------

Requirements:

This version requires a version of Dynare (https://www.dynare.org/download/) that
includes the copps package: the toolkit is part of Dynare, and the scripts call the
MATLAB functions copps.solve and copps.plot. A version compatible with Dynare 5.x
(with the toolkit in the Toolkit folder) is kept in the dynare-5.x branch.

Constrained optimal policy projections are computed in two steps:

  1. Run Dynare on the model, with the smoother (calib_smoother), e.g.

       dynare GaliNK3 -DSMOOTHER nograph noclearall

  2. Call copps.solve, which stores the results in oo_.copps.<name>, e.g.

       oo_ = copps.solve(M_, oo_, 'name', 'commitment', ...
                         'planner_discount_factor', 'beta', ...
                         'loss_function_variables', {'pinf';'og'}, ...
                         'policy_instruments_and_shocks', {'r','er'}, ...
                         'past_periods', 50);
       copps.plot(oo_.copps.commitment, oo_.copps.commitment.params);

The options of copps.solve are the parameters of the toolkit described in the manual
(params.<Field>), written in lower case with underscores:

  PastPeriods                 past_periods
  PolicyInstrumentsAndShocks  policy_instruments_and_shocks
  LossFunctionVariables       loss_function_variables
  PlannerDiscountFactor       planner_discount_factor
  LossFunctionWeights         loss_function_weights
  PolicyType                  policy_type
  T_loss, H_policy, T_full    t_loss, h_policy, t_full
  D_term                      d_term
  TYPE                        type
  alpha                       alpha
  N_planning                  n_planning
  beta1, beta2                beta1, beta2
  Constraint                  constraint
  RateMin                     rate_min
  PolicyRateStSt              policy_rate_steady_state
  RateDevMin, RateDevMax      rate_dev_min, rate_dev_max
  QeMin, QeMax                qe_min, qe_max
  QeDevMin, QeDevMax          qe_dev_min, qe_dev_max
  MaxIter, Update, Crit       max_iter, update, crit
  PlotConstraints, Smoothing  plot_constraints, smoothing
  plotting                    plotting

ModelDirectory, ModelFilename and DynareOptions are not needed anymore: Dynare is run
before calling copps.solve. The meaning and the default values of the options are
unchanged.

--------------------------------------------------------------

Content:


A. Files

1: 	License agreement, see LICENSE.txt

2: 	A manual that describes how to produce COPPs with new models and additional options, see COPPs_Manual_v1p1.pdf. 

3:	Run_COPPs.m can be copied to be used as a template. It provides a simple example that runs optimal policy projections for the Smets and Wouters model without constraints. 

4: 	Replication files for all figures in the working paper. 
	Open the script Fig_XY_PaperVersion.m related to chart XY and execute. The Matlab paths to the optimization toolbox and Dynare need to be set manually. 

5: 	Replication file for Table D.1 in the working paper on computational times. 
	Open the script Tab_1.m and execute.

6: 	Change log, see CHANGELOG.txt


B. Folders

1:	Models contains several folders with dynare mod-files and related datafiles, which are drawn on in the computation of COPPs. 

2:	MiscReplication provides the mod-files that compute optimal policy via the Lagrangian approach.

The individual projections, formerly in the IndividualProjections folder, are now computed directly in the replication scripts (each one is named after the former script, e.g. oo_.copps.Fig_2_a). 

