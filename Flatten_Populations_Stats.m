function [ flat_data ] = Flatten_Populations_Stats( populations )
%Flatten_Population_Stats flatten the noise/signal correlation/
%   covariance matrices across pairs of neurons into one 1D vector per stat
%
% (this enables easy use of corrcoef() and the like)


flat_data = struct(...
    'signal_covariances', [], ...
    'signal_correlations', [], ...
    'noise_covariances_inter', [], ...
    'noise_covariances', [], ...
    'noise_correlations_inter', [], ...
    'noise_correlations', []);

for pop=populations
	indices = find(triu(ones(size(pop.signal_covariances)),1));
    flat_data.signal_covariances       = vertcat(flat_data.signal_covariances,       pop.signal_covariances(indices));
    flat_data.signal_correlations      = vertcat(flat_data.signal_correlations,      pop.signal_correlations(indices));
    flat_data.noise_covariances_inter  = vertcat(flat_data.noise_covariances_inter,  pop.noise_covariances_inter(indices));
    flat_data.noise_covariances        = vertcat(flat_data.noise_covariances,        pop.noise_covariances(indices));
    flat_data.noise_correlations_inter = vertcat(flat_data.noise_correlations_inter, pop.noise_correlations_inter(indices));
    flat_data.noise_correlations       = vertcat(flat_data.noise_correlations,       pop.noise_correlations(indices));
end

end