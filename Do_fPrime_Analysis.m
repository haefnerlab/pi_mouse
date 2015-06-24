function [ data ] = Do_fPrime_Analysis(data, glopts)
% Do_fPrime_Analysis computes fprime for all units and - optionally - plots

if ~isstruct(data)
    data = load(fullfile('data', data));
end

data.naiveUnits = arrayfun(@Compute_FPrime, data.naiveUnits);
data.intermediateUnits = arrayfun(@Compute_FPrime, data.intermediateUnits);
data.trainedUnits = arrayfun(@Compute_FPrime, data.trainedUnits);

naive_fprimes = Get_Property_Array(data.naiveUnits, 'fprime');
intermediate_fprimes = Get_Property_Array(data.intermediateUnits, 'fprime');
trained_fprimes = Get_Property_Array(data.trainedUnits, 'fprime');

if isfield(glopts,'display')
  switch glopts.display
    case 'on'
      disp('mean dprime, naive');
      disp(mean(naive_fprimes));
      
      disp('mean dprime, intermediate');
      disp(mean(intermediate_fprimes));
      
      disp('mean dprime, trained');
      disp(mean(trained_fprimes));
      
      figure();
      ax1 = subplot(1,3,1);
      boxplot(naive_fprimes);
      title('naive');
      
      ax2 = subplot(1,3,2);
      boxplot(intermediate_fprimes);
      title('intermediate');
      
      ax3 = subplot(1,3,3);
      boxplot(trained_fprimes);
      title('trained');
  end
end

end

