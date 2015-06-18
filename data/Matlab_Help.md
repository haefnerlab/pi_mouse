Quality levels: 1&2: excellent single units, 3: decent single units, 4&5: multi units

`quality3_learners.mat` and `quality5_learners.mat` contain:
* `naiveUnits[1:120]`: before learning
* `intermediateUnits[1:117]`: stage 1 learning (licking not grating-specific)
* `trainedUnits[1:150]`: stage 2 learning (licking grating-specific)

Each variable is an array of structures, 1 for each neuron

Neurons that were recorded at the same time have identical values for `mouse_counter` and `series_num`.

__Identifying Neurons__

`mouse_counter`: 	mouse ID: should be: 22, 28, 36, 53, 81
`series_num`:		penetration # (new batch of neurons)
`unit_id`:			neuron
`layer`:			estimated laminar location of neuron based on current source density (possible values: 1,2,4,5,6;  2&3 are grouped together)

*(possibly group: 1-4, 5&6)*

__Tuning Properties__

no spout, presented in rapid succession, each 2sec, in between 0.5s

`sigma`: tuning curve width (fit of sum of 2 Gaussians to high contrast direction data) drifting grating, 2 sec
`bkgrate`: firing rate in between the grating stim (blank screen, like 0% contrast grating) presented for 2 sec
`rates`:			rate per orientation
`orientations`:		orientations
`prefDir`:			preferred direction
`prefOri`:			preferred orientation
`dirFit`:			predicted direction tuning firing rates (by deg: 0...359)
`oriFit`:			predicted orientation firing rates (by deg: 0...179)

__NOTE:__ some animals tuning was done with sinewave grating, task with square wave gratings:
* sine wave for both: `mouse_counter`: 53, 81
* sine wave tuning, square wave task: `mouse_counter`: 22, 28, 36

__Task-related measurements__

`task_trialID`:		[#trials,1]: trial ID, from 1:#number of trials per experiment (usually 60, but sometimes less), 
`task_stimSpikes`:	cell array {#trials,1}
				times of spikes during stimulus presentation
`task_stimLicks`:		times of licks during stimulus presentation
`task_interSpikes`:	times of spikes before stimulus pres
`task_interLicks`:		times of licks before stim pres
`task_prevReward`:	time of the last reward delivery (formerly: prevTrialOffset)
	
*!! exclude inter\* for every trial with task_trialID=1 (beginning of each experiment)*

`task_direction`:		direction of task-relevant stimulus present on this trial
`task_contrast`:		contrast of task-relevant stimulus presented on this trial
`task_rewardedTrial`:	1 or 0 depending on whether trial was rewarded


