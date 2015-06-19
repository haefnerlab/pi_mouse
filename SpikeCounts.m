function [ counts ] = SpikeCounts( trials )
%SpikeCounts count spikes in each trial (trials is cell array of spike times)

counts = cellfun(@length, trials);

% easy as that.

end

