% Top-Level script for testing

% Load data (either quality3 or quality5)
if ~exist('glopts', 'var')
    glopts = Make_Global_Options('display', 'off', 'verbose', true);
end

datafile = 'quality3_units';
data = load(fullfile('data', datafile));
% most analyses done on the population level: extract them here
data = Extract_Populations(data, glopts);

npops = data.naivePopulations;
ipops = data.intermediatePopulations;
tpops = data.trainedPopulations;

%% TEMPORARY FIX for variable trial lengths
npops = Remove_Units_Few_Trials(npops, glopts);
ipops = Remove_Units_Few_Trials(ipops, glopts);
tpops = Remove_Units_Few_Trials(tpops, glopts);

%% noise and signal correlations

% compute noise correlations in inter-trial periods
npops = Compute_InterStim_NoiseCorrelations(npops, glopts);
ipops = Compute_InterStim_NoiseCorrelations(ipops, glopts);
tpops = Compute_InterStim_NoiseCorrelations(tpops, glopts);

% compute noise correlations in inter-trial periods
npops = Compute_Stim_NoiseCorrelations(npops, glopts);
ipops = Compute_Stim_NoiseCorrelations(ipops, glopts);
tpops = Compute_Stim_NoiseCorrelations(tpops, glopts);

% compute stimulus correlations
npops = Compute_SignalCorr_Stim(npops, glopts);
ipops = Compute_SignalCorr_Stim(ipops, glopts);
tpops = Compute_SignalCorr_Stim(tpops, glopts);

%% collapse data from multiple populations into single vector per phase
nflattened = Flatten_Populations_Stats(npops);
iflattened = Flatten_Populations_Stats(ipops);
tflattened = Flatten_Populations_Stats(tpops);

%% Set mode for following 3 sections
stages={'naive','intermediate','trained'};
flat={nflattened,iflattened,tflattened};
for SC={'signal_covariances','signal_correlations'}
  for NC={'noise_covariances','noise_correlations'}
    for i=1:length(stages)
      x=flat{i}.(SC{1}); 
      y=flat{i}.(NC{1});
      include=~isnan(x) & ~isnan(y);
      [cr cp]=corr(x(include), y(include));
      disp([stages{i} ': ' SC{1} ' vs ' NC{1} ' : ' num2str([cr cp])]);
    end
    disp('\n');
  end
end

%% Plotting: Part I noise correlation (inter) vs signal covariances
% this is how I first planned on redoing the plots using corr's and cov's
% for all 3 parts before deciding on the above.
SC = 'COV'; disp(['Plot signal-' SC]); % alternatively 'CORR'
NC = 'CORR'; disp(['Plot noise -' SC]); % alternatively 'CORR'
figure();
ylim = [-1,1];
xlim = [-1000,1000];
% naive populations
subplot(3,1,1);
hold on;
for npop=npops
    indices = logical(triu(ones(size(npop.signal_covariances)),1));
    switch SC
      case 'COV', x=npop.signal_covariances(indices);
      case 'CORR',x=npop.signal_correlations(indices);
    end
    switch NC
      case 'COV', y=npop.noise_covariances(indices);
      case 'CORR',y=npop.noise_correlations(indices);
    end
    scatter(x,y);
end
hold off;
set(gca, 'YLim', ylim);
set(gca, 'XLim', xlim);
[R,P]=corrcoef(nflattened.signal_covariances, nflattened.noise_correlations_inter);
title(sprintf('naive, correlation=%f, p=%f', R(2), P(2)));
% intermediate populations
subplot(3,1,2);
hold on;
for ipop=ipops
    indices = logical(triu(ones(size(ipop.signal_covariances)),1));
    scatter(ipop.signal_covariances(indices), ipop.noise_correlations_inter(indices));
end
hold off;
set(gca, 'YLim', ylim);
set(gca, 'XLim', xlim);
[R,P]=corrcoef(iflattened.signal_covariances, iflattened.noise_correlations_inter);
title(sprintf('intermediate, correlation=%f, p=%f', R(2), P(2)));
ylabel('noise correlation (inter)');
% trained populations
subplot(3,1,3);
hold on;
for tpop=tpops
    indices = logical(triu(ones(size(tpop.signal_covariances)),1));
    scatter(tpop.signal_covariances(indices), tpop.noise_correlations_inter(indices));
end
hold off;
set(gca, 'YLim', ylim);
set(gca, 'XLim', xlim);
[R,P]=corrcoef(tflattened.signal_covariances, tflattened.noise_correlations_inter);
title(sprintf('trained, correlation=%f, p=%f', R(2), P(2)));
xlabel('signal covariance');


%% Plotting: Part II noise correlation (stim) vs signal covariances
figure();
ylim = [-1,1];
xlim = [-1000,1000];
% naive populations
subplot(3,1,1);
hold on;
for npop=npops
    indices = logical(triu(ones(size(npop.signal_covariances)),1));
    scatter(npop.signal_covariances(indices), npop.noise_correlations(indices));
end
hold off;
set(gca, 'YLim', ylim);
set(gca, 'XLim', xlim);
[R,P]=corrcoef(nflattened.signal_covariances, nflattened.noise_correlations);
title(sprintf('naive, correlation=%f, p=%f', R(2), P(2)));
% intermediate populations
subplot(3,1,2);
hold on;
for ipop=ipops
    indices = logical(triu(ones(size(ipop.signal_covariances)),1));
    scatter(ipop.signal_covariances(indices), ipop.noise_correlations(indices));
end
hold off;
set(gca, 'YLim', ylim);
set(gca, 'XLim', xlim);
[R,P]=corrcoef(iflattened.signal_covariances, iflattened.noise_correlations);
title(sprintf('intermediate, correlation=%f, p=%f', R(2), P(2)));
ylabel('noise correlation (stim)');
% trained populations
subplot(3,1,3);
hold on;
for tpop=tpops
    indices = logical(triu(ones(size(tpop.signal_covariances)),1));
    scatter(tpop.signal_covariances(indices), tpop.noise_correlations(indices));
end
hold off;
set(gca, 'YLim', ylim);
set(gca, 'XLim', xlim);
[R,P]=corrcoef(tflattened.signal_covariances, tflattened.noise_correlations);
title(sprintf('trained, correlation=%f, p=%f', R(2), P(2)));
xlabel('signal covariance');


%% Plotting: Part III noise correlation (inter) vs noise correlation (stim)
figure();
ylim = [-1,1];
xlim = [-1,1];
% naive populations
subplot(3,1,1);
hold on;
for npop=npops
    indices = logical(triu(ones(size(npop.signal_covariances)),1));
    scatter(npop.noise_correlations(indices), npop.noise_correlations_inter(indices));
end
hold off;
set(gca, 'YLim', ylim);
set(gca, 'XLim', xlim);
[R,P]=corrcoef(nflattened.noise_correlations, nflattened.noise_correlations_inter);
title(sprintf('naive, correlation=%f, p=%f', R(2), P(2)));
% intermediate populations
subplot(3,1,2);
hold on;
for ipop=ipops
    indices = logical(triu(ones(size(ipop.signal_covariances)),1));
    scatter(ipop.noise_correlations(indices), ipop.noise_correlations_inter(indices));
end
hold off;
set(gca, 'YLim', ylim);
set(gca, 'XLim', xlim);
[R,P]=corrcoef(iflattened.noise_correlations, iflattened.noise_correlations_inter);
title(sprintf('intermediate, correlation=%f, p=%f', R(2), P(2)));
ylabel('noise correlation (inter)');
% trained populations
subplot(3,1,3);
hold on;
for tpop=tpops
    indices = logical(triu(ones(size(tpop.signal_covariances)),1));
    scatter(tpop.noise_correlations(indices), tpop.noise_correlations_inter(indices));
end
hold off;
set(gca, 'YLim', ylim);
set(gca, 'XLim', xlim);
[R,P]=corrcoef(tflattened.noise_correlations, tflattened.noise_correlations_inter);
title(sprintf('trained, correlation=%f, p=%f', R(2), P(2)));
xlabel('noise correlation (stim)');

%% Clean up workspace

clear xlim ylim indices npop ipop tpop;