function [] = Do_fPrime_Analysis(datafile, glopts)

% function [] = Do_DPrime_Analysis(datafile)
% argument can be filename or data struct itself

if isfield(datafile,'naiveUnits'), data=datafile;
else
  try
    data = load(datafile);
  catch
    % check in the data/ subdirectory
    data = load(fullfile('data', datafile));
  end
end

naive_fprimes = arrayfun(@Compute_FPrime, data.naiveUnits);
intermediate_fprimes = arrayfun(@Compute_FPrime, data.intermediateUnits);
trained_fprimes = arrayfun(@Compute_FPrime, data.trainedUnits);

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
      
      set([ax1,ax2,ax3], 'YLim', [0,5]);
      suptitle('d'' for all neurons across 3 phases');
  end
end

end

