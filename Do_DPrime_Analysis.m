function [] = Do_DPrime_Analysis(datafile)

% function [] = Do_DPrime_Analysis(datafile)
% argument can be filename or data struct itself

if isfield(datafile,'naiveUnits'), data=datafile;
else
  try
    data = load(datafile);
  catch
    % check in the data/ subdirectory
    data = load(fullfile('data', datafile));
  end
end

disp('mean dprime, naive');
naive_dprimes = arrayfun(@compute_dprime, data.naiveUnits);
disp(mean(naive_dprimes));

disp('mean dprime, intermediate');
intermediate_dprimes = arrayfun(@compute_dprime, data.intermediateUnits);
disp(mean(intermediate_dprimes));


disp('mean dprime, trained');
trained_dprimes = arrayfun(@compute_dprime, data.trainedUnits);
disp(mean(trained_dprimes));

figure();
ax1 = subplot(1,3,1);
boxplot(naive_dprimes);
title('naive');

ax2 = subplot(1,3,2);
boxplot(intermediate_dprimes);
title('intermediate');

ax3 = subplot(1,3,3);
boxplot(trained_dprimes);
title('trained');

set([ax1,ax2,ax3], 'YLim', [0,5]);
suptitle('d'' for all neurons across 3 phases');

end

function dprime = compute_dprime(unit)

% split data into two groups by stimulus
directions = unique(unit.task_direction);

A_trials = unit.task_direction == directions(1);
B_trials = unit.task_direction == directions(2);

% get total spike count statistics for each group
get_counts = @(spikes) length(spikes);
A_spike_counts = cellfun(get_counts, unit.task_stimSpikes(A_trials));
B_spike_counts = cellfun(get_counts, unit.task_stimSpikes(B_trials));

% compute dprime = (difference in means) / sqrt(mean variance)
% (see https://en.wikipedia.org/wiki/Sensitivity_index)
% note: taking absolute value, since there we are not interested in
% 'correct' vs 'incorrect' orientations
uA = mean(A_spike_counts);
uB = mean(B_spike_counts);
varA = var(A_spike_counts);
varB = var(B_spike_counts);
dprime = abs(uA-uB) / sqrt(0.5*(varA + varB));

end