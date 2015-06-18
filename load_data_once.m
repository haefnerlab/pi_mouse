function glopts = load_data_once(glopts)
% load_data_once loads data from file specified in glopts.
%   should be used as 'glopts = load_data(glopts)' to prevent reloading
%   again
%
%   See make_global_options

if ischar(glopts.data)
    try
        data = load(glopts.data);
    catch
        data = load(fullfile('data', glopts.data));
    end
else
    data = glopts.data;
end

glopts.data = data;
end