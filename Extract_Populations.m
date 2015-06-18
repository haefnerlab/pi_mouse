function pops = Extract_Populations(units)

% function pops = Extract_Populations(units)
%
% returns an array of 'population' structs.
% A population is a set of neurons that have been recorded at the same time
% in the same animal. The population struct (initially) has the following
% fields:
% - mouse_counter: mouse_counter of all units in this population
% - series_number: series_number of all units in this population
% - units: struct array of units in this population
%
% This is the first-step in computing population statistics. Other
% functions (e.g. Compute_NoiseCorrelations) take a population as input and
% add new fields to it
% 

pops = struct(...
    'mouse_counter', 0, ...
    'series_number', 0, ...
    'units', []);

n_pops = 0;

mouse_ids = [units.mouse_counter];

for mid=unique(mouse_ids)
    mouse_subset = units([units.mouse_counter] == mid);
    
    series_ids = [mouse_subset.series_num];
    
    for sid=unique(series_ids)
        n_pops = n_pops + 1;
        
        % each == test makes a boolean array, and the .* acts as AND.
        % So, we are getting all indices where mouse_counter is mid AND
        % series_number is sid
        population_indices = logical(([units.mouse_counter] == mid) .* ([units.series_num] == sid));
        
        pops(n_pops).mouse_counter = mid;
        pops(n_pops).series_number = sid;
        pops(n_pops).units = units(population_indices);
    end
end

end