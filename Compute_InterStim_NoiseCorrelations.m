function [ population ] = Compute_InterStim_NoiseCorrelations( population, glopts )
%Compute_NoiseCorrelations computes noise correlation matrix for population

for i=1:length(population)
  p=population(i);

  % compute inter-stimulus pseudo-trials for each unit 
  p = Split_InterStim_PseudoTrials_Population(p, glopts);

  % get spike counts for of neurons for each pseudo-trial
  spike_counts = arrayfun(@(u) SpikeCounts(u.all_inter_pseudoSpikes), ...
    p.units, 'UniformOutput', false);
  spike_counts = horzcat(spike_counts{:});

  % get correlation for each pair of neurons using z-scored data
  p.noise_correlations = corrcoef(spike_counts);
  p.noise_covariances  = cov(spike_counts);

  pop(i)=p;
end

population = pop;