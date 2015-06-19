function [ population ] = Compute_InterStim_NoiseCorrelations( population, glopts )
%Compute_NoiseCorrelations computes noise correlation matrix for population

% compute inter-stimulus pseudo-trials for each unit 
Split_InterStim_PseudoTrials_Population(population, glopts);

% get spike counts for of neurons for each pseudo-trial
spike_counts = arrayfun(@(u) SpikeCounts(u.all_inter_pseudoSpikes), ...
    population.units, 'UniformOutput', false);
spike_counts = horzcat(spike_counts{:});

% get correlation for each pair of neurons using z-scored data
population.noise_correlations = corrcoef(spike_counts);

end

