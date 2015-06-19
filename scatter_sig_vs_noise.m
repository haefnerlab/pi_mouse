% Top-Level script for testing

% Load data (either quality3 or quality5)
glopts = make_global_options('quality3_learners', 'display', 'off');
% glopts = make_global_options('quality5_learners', 'display', 'off');
glopts = load_data_once(glopts);
% most analyses done on the population level: extract them here
glopts = Extract_Populations(glopts);

npops = glopts.data.naivePopulations;
ipops = glopts.data.intermediatePopulations;
tpops = glopts.data.trainedPopulations;

% TEMPORARY FIX for variable trial lengths
npops = Remove_Units_Few_Trials(npops);
ipops = Remove_Units_Few_Trials(ipops);
tpops = Remove_Units_Few_Trials(tpops);

%% noise and signal correlations

% compute noise correlations in inter-trial periods
npops = Compute_InterStim_NoiseCorrelations(npops, glopts);
ipops = Compute_InterStim_NoiseCorrelations(ipops, glopts);
tpops = Compute_InterStim_NoiseCorrelations(tpops, glopts);

% compute stimulus correlations
npops = Compute_SignalCorr_Stim(npops, glopts);
ipops = Compute_SignalCorr_Stim(ipops, glopts);
tpops = Compute_SignalCorr_Stim(tpops, glopts);

%% Plotting
% SCATTER noise vs signal covariances
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
title('naive');
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
title('intermediate');
ylabel('noise correlation');
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
title('trained');
xlabel('signal covariance');