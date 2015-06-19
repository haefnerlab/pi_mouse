function glopts = make_global_options(datafile, varargin)
% options = make_options(datafile, 'opt', value, 'opt2', value, ...)
%
% 'options' is a struct of parameters passed in to other functions in
% this project.

glopts = struct(...
    'data', datafile, ...
    'display', false, ...
    'verbose', false, ...
    'behaviors', {{'naive', 'intermediate', 'trained'}}, ...
    'trial_length', 3 ... % in seconds
);
% note on 'behaviors' above: matlab treats cell array values as assignments 
% to multiple indices of a struct array, so we have to wrap a 1x3 cell
% array inside a 1x1 cell array in order to assign it.

% set each odd arg in (name) to the corresponding even arg in (value)
for i=1:2:(length(varargin)-1)
    % a_struct.(a_fieldname_as_a_string) is the somewhat uncommon syntax 
    % for dynamically using the fields of a struct
    glopts.(varargin{i}) = varargin{i+1};
end

end