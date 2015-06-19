function population = Compute_SignalCorr(population,glopts)

fprimes = arrayfun(@compute_fprime,population.units);

population.signal_covariances = fprimes' * fprimes;