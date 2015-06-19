function [ populations ] = unitfun(units_function, populations, varargin )
%UNITFUN apply a function to the units of a struct array of populations

for i=1:length(populations)
    populations(i).units = arrayfun(units_function, populations(i).units, varargin{:});
end

end

