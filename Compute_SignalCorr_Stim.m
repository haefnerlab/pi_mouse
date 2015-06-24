function [ populations ] = Compute_SignalCorr_Stim(populations, glopts)
%Compute_SignalCorr_Stim computes signal correlations and covariances of populations

populations = unitfun(@Compute_FPrime, populations);

for i=1:length(populations)
  fprimes = Get_Property_Array(populations(i).units, 'fprime');
  sig_cov = fprimes' * fprimes;
  populations(i).signal_covariances = sig_cov;
  populations(i).signal_correlations = corrcov(sig_cov);
end

end