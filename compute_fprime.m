function fprime = compute_fprime(unit)

% split data into two groups by stimulus
directions = unique(unit.task_direction);

A_trials = unit.task_direction == directions(1);
B_trials = unit.task_direction == directions(2);

% get total spike count statistics for each group
get_counts = @(spikes) length(spikes);
A_spike_counts = cellfun(get_counts, unit.task_stimSpikes(A_trials));
B_spike_counts = cellfun(get_counts, unit.task_stimSpikes(B_trials));

uA = mean(A_spike_counts);
uB = mean(B_spike_counts);
varA = var(A_spike_counts);
varB = var(B_spike_counts);
fprime = uA-uB;

end