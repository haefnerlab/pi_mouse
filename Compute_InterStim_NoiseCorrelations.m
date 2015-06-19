function [ populations ] = Compute_InterStim_NoiseCorrelations( populations, glopts )
%Compute_InterStim_NoiseCorrelations computes noise correlation matrix for each
%   given population

for i=1:length(populations)
    
    % compute inter-stimulus pseudo-trials for each unit 
    populations(i) = Split_InterStim_PseudoTrials_Population(populations(i), glopts);

    % get spike counts for of neurons for each pseudo-trial
    spike_counts = arrayfun(@(u) SpikeCounts(u.all_inter_pseudoSpikes), ...
        populations(i).units, 'UniformOutput', false);
    spike_counts = horzcat(spike_counts{:});

    % get correlation for each pair of neurons using z-scored data
    populations(i).noise_correlations_inter = corrcoef(spike_counts);
    populations(i).noise_covariances_inter  = cov(spike_counts);

end

end