function [ populations ] = Compute_InterStim_NoiseCorrelations( populations, glopts )
%Compute_NoiseCorrelations computes noise correlation matrix for each
%   given population

populations = arrayfun(@(pop) get_noisecorr_single_pop(pop, glopts), populations);

end

function [ pop ] = get_noisecorr_single_pop(pop, glopts)

  % compute inter-stimulus pseudo-trials for each unit 
  pop = Split_InterStim_PseudoTrials_Population(pop, glopts);

  % get spike counts for of neurons for each pseudo-trial
  spike_counts = arrayfun(@(u) SpikeCounts(u.all_inter_pseudoSpikes), pop.units, ...
      'UniformOutput', false);
  spike_counts = horzcat(spike_counts{:});

  % get correlation for each pair of neurons using z-scored data
  pop.noise_correlations = corrcoef(spike_counts);
  pop.noise_covariances  = cov(spike_counts);
end