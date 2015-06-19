function [ populations ] = Remove_Units_Few_Trials(populations, glopts)
%Remove_Units_Few_Trials some populations have neurons that only show up in
%   a smaller number of trials. This function removes those from the
%   population
%
% NOTE this is a temporary fix. There are 60 trialIDs, and some neurons
% simply go through it more than once and have 120 or 180. So 60 and 180
% are still comparable!

for i=1:length(populations)
    p = populations(i);
    n_units = length(p.units);

    
    n_trials = arrayfun(@(u) length(u.task_trialID), p.units);
    maxed_units = n_trials == max(n_trials);
    
    p.units = p.units(maxed_units);
    populations(i) = p;
    
    if glopts.verbose
        n_kept = sum(maxed_units);
        if n_units ~= n_kept
            fprintf('population m%d s%d: %d of %d units kept\n', ...
                p.mouse_counter, ...
                p.series_number, ...
                n_kept, ...
                n_units);
        end
    end

end

end