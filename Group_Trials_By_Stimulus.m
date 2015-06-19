function [ populations ] = Group_Trials_By_Stimulus(populations, glopts)
%Group_Trials_By_Stimulus groups trials by same contrast and direction
%
% returns modified populations with 'stimuli' field, which is a struct
% array where fields are 
% - contrast: between 0 and 1
% - direction: between 0 and 360
% - trials: indexes into task_* fields that all have the same contrast and
%           direction

for i=1:length(populations)
    u = populations(i).units(1); % any unit in a population (should) have the same stimulus as all the others
    directions = unique(u.task_direction);
    contrasts = unique(u.task_contrast);
    
    populations(i).stimuli = struct(...
        'contrast', 0, ...
        'direction', 0, ...
        'trials', []);
    n_stimuli = 1;
    for c_idx=1:length(contrasts)
        for d_idx=1:length(directions)
            c = contrasts(c_idx);
            d = directions(d_idx);
            
            populations(i).stimuli(n_stimuli).contrast = c;
            populations(i).stimuli(n_stimuli).direction = d;
            
            % each == test makes a boolean array, and the .* acts as AND.
            % So, we are getting all indices where contrast is c AND
            % direction is d
            indices = logical((u.task_direction == d) .* (u.task_contrast == c));
            populations(i).stimuli(n_stimuli).trials = find(indices);
            n_stimuli = n_stimuli + 1;
        end
    end
end

end