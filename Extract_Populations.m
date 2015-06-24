function [ data ] = Extract_Populations(data, glopts)
% Extract_Populations(data) computes populations for each phase.
%   returns a modified data struct with fields {behavior}Populations for each
%   behavior
%
% usage:
% >> data = load('path/to/datafile')
% >> data = Extract_Populations(data)

for behavior=1:length(glopts.behaviors)
    pop_varname = sprintf('%sPopulations', glopts.behaviors{behavior});
    units_varname = sprintf('%sUnits', glopts.behaviors{behavior});
    
    data.(pop_varname) = units_to_pops(data.(units_varname));
end

end

function [ pops ] = units_to_pops(units)
% function pops = units_to_pops(units)
%
% returns an array of 'population' structs.
% A population is a set of neurons that have been recorded at the same time
% in the same animal. The population struct (initially) has the following
% fields:
% - mouse_counter: mouse_counter of all units in this population
% - series_number: series_number of all units in this population
% - size: number of units
% - units: struct array of units in this population
%
% This is the first-step in computing population statistics. Other
% functions (e.g. Compute_NoiseCorrelations) take a population as input and
% add new fields to it
% 

pops = struct(...
    'mouse_counter', 0, ...
    'series_number', 0, ...
    'size', 0, ...
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
        pops(n_pops).size = sum(population_indices);
    end
end
end