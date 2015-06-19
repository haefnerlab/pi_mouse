function population = Compute_SignalCorr_Stim(population,glopts)

for i=1:length(population)
  p=population(i);
  fprimes = arrayfun(@Compute_FPrime,p.units);
  p.signal_covariances = fprimes' * fprimes;
  pop(i)=p;
end

population = pop;