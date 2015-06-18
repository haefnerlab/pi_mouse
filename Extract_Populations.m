function pops = Extract_Populations(units)

% function pops = Extract_Populations(units)
%
% returns list of arrays of units that have been recorded at the same time
% in the same animal
% 

pops = {};

mouse_ids = [units.mouse_counter];

for mid=unique(mouse_ids)
    mouse_subset = units([units.mouse_counter] == mid);
    
    series_ids = [mouse_subset.series_num];
    
    for sid=unique(series_ids)
        % each == test makes a boolean array, and the .* acts as AND.
        % So, we are FINDing all indices where mouse_counter is mid AND
        % series_number is sid
        mouse_series_ids = find(([units.mouse_counter] == mid) .* ([units.series_num] == sid));
        pops = cell_append(pops, mouse_series_ids);
    end
end

end

function cell_array = cell_append(cell_array, value)
    cell_array{length(cell_array)+1} = value;
end
