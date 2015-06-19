function population = Compute_SignalCorr(population,glopts)

for i=1:length(population)
  p=population(i);
  fprimes = arrayfun(@compute_fprime,p.units);
  p.signal_covariances = fprimes' * fprimes;
  pop(i)=p;
end

population = pop;