function nc = Compute_SignalCorr_Stim(data)

fields={'naive','intermediate','trained'};

for behavior=1:3
  units=data.(fields{behavior});
  pops=Extract_Populations(units);
  
  for i_pop=1:length(pops)
    nn=length(pops{i_pop};
    if nn>1
      resp=units(pops{i_pop}).task_stimSpikes
      c=corr(pops{i_pop}