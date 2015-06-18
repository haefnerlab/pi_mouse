function p = ROC(x,y)

% function p = ROC(x,y)
%
% Computes "area under the curve" in ROC analyis
% p=1 implies max(x)<min(y)

nx=length(x);
ny=length(y);
counter=0;
for i=1:nx
  for j=1:ny
    if x(i)<y(j),      counter=counter+1;
    elseif x(i)==y(j), counter=counter+0.5;
    end
  end
end
p=counter/nx/ny;