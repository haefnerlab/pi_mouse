function [ props ] = Get_Property_Array( struct_array, prop, cell_output )
%GET_PROPERTY_ARRAY returns an array that slices prop in the struct array
%    

if nargin < 3, cell_output = false; end

if cell_output
    props = { struct_array.(prop) };
else
    props = [ struct_array.(prop) ];
end

end

