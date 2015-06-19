function [ population ] = Compute_SignalCorr_Stim(population,glopts)

for i=1:length(population)
  p=population(i);
  p.units = arrayfun(@Compute_FPrime,p.units);
  fprimes = Get_Property_Array(p.units, 'fprime');
  p.signal_covariances = fprimes' * fprimes;
  population(i)=p;
end

end