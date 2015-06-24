% PI_MOUSE
%
% Scripts that generate plots
%   analyze_correlations                    - Top-Level script for testing
%   Do_fPrime_Analysis                      - computes fprime for all units and - optionally - plots
%
% Functions for computing statistics 
%   Compute_FPrime                          - computes delta-mean-response to delta-stimulus
%   Compute_InterStim_NoiseCorrelations     - computes noise correlations and correlations of populations during *inter-stimulus* periods
%   Compute_SignalCorr_Stim                 - computes signal correlations and covariances of populations
%   Compute_Stim_NoiseCorrelations          - computes noise correlations and correlations of populations during *stimulus*
%
% Preprocessing functions
%   Make_Global_Options                     - create the options struct that is passed around everywhere as 'glopts'
%   Extract_Populations                     - groups units into populations for each phase
%   Group_Trials_By_Stimulus                - groups trials by same contrast and direction
%   Remove_Units_Few_Trials                 - remove neurons from a population that don't have full trial data
%   Split_InterStim_PseudoTrials            - splits the 'inter-stimulus' data into non-overlapping chunks ('pseudo' trials)
%   Split_InterStim_PseudoTrials_Population - calls Split_InterStim_PseudoTrials such that all units in the same population get same number of pseudo trials
%
% Helper functions
%   Flatten_Populations_Stats               - flatten all correlation/covariance matrices over multiple populations
%   Get_Property_Array                      - slice out a property in the struct array
%   SpikeCounts                             - count spikes in cell array of spike times per trial
%   unitfun                                 - map a function to the units of populations
%
% Testing/Miscellaneous
%   PI_Toy                                  - toy learning model testing
%   ROC                                     - compute receiver operating characteristic