function [ population ] = Split_InterStim_PseudoTrials_Population( population, glopts )
%Split_InterStim_PseudoTrials_Population Does Split_InterStim_PseudoTrials
%   for each unit in the population
%
% WHERE it is ensured that each unit gets exactly the same number of
% pseudo-trials in each interval so that they may be compared across units
% (e.g. for noise correlations, trials must line up in time).
%
% The problem with just doing Split_InterStim_PseudoTrials on each unit
% separately is that the number of pseudo-trials may be slightly smaller
% for some units than for others if the earliest recorded spike took some
% time to occur (we don't otherwise know how long the inter-stimulus 
% intervals are)

% find earliest spike in the population for each trial
min_time_per_unit_per_trial = arrayfun(...
    @(u) cellfun(@min_or_zero, u.task_interSpikes), population.units, ...
    'UniformOutput', false);

min_time_per_trial = min(horzcat(min_time_per_unit_per_trial{:}), [], 2);

population.units = arrayfun(@(u) Split_InterStim_PseudoTrials(u, glopts, min_time_per_trial), population.units);

end

function [ v ] = min_or_zero(array)

if isempty(array)
    v = 0;
else
    v = min(array);
end

end