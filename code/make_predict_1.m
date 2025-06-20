% Load config file
run('./config.m');

% Set up the parallel cluster
% Set up the parallel cluster and specify the profile explicitly
c = parcluster('cluster');  % Specify the cluster name depends on HPC matlab profile explicitly 
c.AdditionalProperties.AccountName = 'account'; %add account name
c.saveProfile; 
parpool(c,32); % Start parallel pool with 32 workers

%%%% 1: Set up for Loop  %%%%
[trainSpace, trainTime, trainPreds, trainAqs, num_points] =  ...
    extract_components(training, inp_base_model_names, time_var);

%%%% 2: Generate PPD's; loop over models and years %%%%

% Train the model (done once)
[W, RP, wvar, sigW, Zs, Zt, piZ, mse] = train(trainAqs, trainSpace, trainTime, trainPreds, ...
    scale_space_w, scale_time_w, scale_space_rp, scale_time_rp, scale_space_wvar, ...
    lambda_w, lambda_rp, time_var, seed, bne_mode, sample_n);

% Parallel loop over temporal context and day context
parfor idx = 1:length(temporal_context) * length(day_context)
    % Calculate current temporal and day indices
    [t_idx, j_idx] = ind2sub([length(temporal_context), length(day_context)], idx);
    t = temporal_context(t_idx);
    j = day_context(j_idx);
    
    if j < 10
        spacer = '_00';
    elseif j > 9 && j < 100
        spacer = '_0';
    else
        spacer = '_';
    end
    
    % Read target data
    target = readtable(append(target_name_1, num2str(t), spacer, num2str(j), target_name_2));

    % Generate and write PPD summary
    predict(W, RP, sigW, wvar, Zs, Zt, piZ, target, 10, 'summarize ppd', inp_base_model_names, ...
        scale_space_w, scale_time_w, scale_space_rp, scale_time_rp, scale_space_wvar, time_var, sample_n, ...
        fullfile(exp_folder_path, expid, 'out/'), ...
        append(output_name, num2str(t), spacer, num2str(j)));
end

% Optionally close the pool at the end
delete(gcp('nocreate'));
