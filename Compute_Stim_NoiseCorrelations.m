function [ populations ] = Compute_Stim_NoiseCorrelations( populations, glopts )
%Compute_Stim_NoiseCorrelations computes noise correlation matrix for each
%   given population DURING stimulus presentation using z-scored response
%   distributions

% start by finding trials with same stimuli
populations = Group_Trials_By_Stimulus(populations, glopts);

for i=1:length(populations)
    
    % get all n_trials x n_neurons arrays of spike times
    all_spike_times = horzcat(populations(i).units.task_stimSpikes);
    spike_counts = SpikeCounts(all_spike_times);
    
    % normalize by 'batches' of z-scoring, where each is the same stimulus
    for s_idx=1:length(populations(i).stimuli)
        stim = populations(i).stimuli(s_idx);
        % get spike counts for all neurons, trials with this stimulus
        batch = spike_counts(stim.trials, :);
        % re-assign z-scored version
        spike_counts(stim.trials, :) = zscore(batch);
    end
    
    
    % get correlation for each pair of neurons using z-scored data
    % (corrcoef expects each row an observation, each col a variable)
    populations(i).noise_correlations = corrcoef(spike_counts);
    populations(i).noise_covariances  = cov(spike_counts);

end

end