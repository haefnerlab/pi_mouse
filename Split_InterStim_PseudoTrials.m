function [ unit ] = Split_InterStim_PseudoTrials(unit, glopts, min_times)
% Split_InterStim_PseudoTrials splits the 'inter-stimulus' data into chunks
%   with lengths as defined by glopts.trial_length.
%
% if min_times is given, spikes with t<min not counted, OR extra zero-spike
% bins are filled in as necessary to reach tmin
%
% returns modified 'unit' which has a new fields:
% - task_inter_pseudoSpikes: trialsx1 cell array of pseudotrialsx1 cell 
%   arrays of arrays of spike times
% - all_inter_pseudoSpikes: concatenation of all task_inter_pseudoSpikes
%   (the 'task' is the same in all: gray screen)

n_trials = length(unit.task_interSpikes);

unit.task_inter_pseudoSpikes = cell(n_trials,1);

if nargin < 3
    min_times = cellfun(@min_or_zero, unit.task_interSpikes);
end

% call split_single_interval on each trial
% (note: cellfun won't work here because arrays are different sizes...?)
for i=1:n_trials
    spikes = unit.task_interSpikes{i};
    unit.task_inter_pseudoSpikes{i} = ...
        split_single_interval(spikes, glopts, min_times(i));
end

unit.all_inter_pseudoSpikes = vertcat(unit.task_inter_pseudoSpikes{:});

end

function [ slices ] = split_single_interval(spike_times, glopts, min_time)
% spike times in range (-inf, 0], we want to split into T-second-long
% 'pseudo trials' (where length of trial T is in glopts).
%
% returns a cell array of arrays of spike times where each array is a
% pseudo-trial
%
% for example, if spike times are [-14, -12.5, -11, -10.5, -10, -7] and
% glopts.trial_length is 3, then slices will be
% {[], [], [-7], [-11, -10.5, -10], [-14, -12.5]}
%
% NOTE that the last array of spike times may not represent a full-length
% trial since we don't know if the total inter-stimulus length is a 
% multiple of glopts.trial_length

% note: interstimulus trials go backwards in time

n_pseudo_trials = ceil(abs(min_time) / glopts.trial_length);

slices = cell(n_pseudo_trials, 1);

for trial_no = 1:n_pseudo_trials
    start_time = -trial_no * glopts.trial_length;
    end_time = start_time + glopts.trial_length;
    
    lo_index = find(spike_times >= start_time, 1, 'first');
    hi_index = find(spike_times < end_time, 1, 'last');
    
    slices{trial_no} = spike_times(lo_index:hi_index);
end

end

function [ v ] = min_or_zero(array)

if isempty(array)
    v = 0;
else
    v = min(array);
end

end