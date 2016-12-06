% compile raw data into more manageable form
% extract target jump responses from target jump trials

clear all
load BimanualSkillData

% data structures:
%       d{subject}.Bi{chunk}{perturbation}
%           1 'chunk' on day 1, 2 chunks on subsequent days
%           perturbation types: [-3cm -1.5cm 0cm 1.5cm 3cm never];
%               'never' includes trials that are never perturbed in any block
%

%% Basic performance - No-jump trials
for subj = 1:length(d)
    Nday = 4;

    Nbin = 40; % number of trials to bin together

        % null path length
        dAll.Bi.pathLength(subj,:) = binData(d{subj}.Bi{6}.pathlength,Nbin);
        dAll.Bi.pathLength_null(subj,:) = binData(d{subj}.Bi{6}.pathlength_null,Nbin);
        dAll.Bi.pathLength_ratio(subj,:) = binData(d{subj}.Bi{6}.pathlength_null./d{subj}.Bi{6}.pathlength,Nbin);
        dAll.Bi.movDur(subj,:) = binData(d{subj}.Bi{6}.movtime,Nbin);
        dAll.Bi.RT(subj,:) = binData(d{subj}.Bi{6}.RT,Nbin)-100;
        dAll.Bi.pkVel(subj,:) = binData(d{subj}.Bi{6}.pkVel,Nbin);

        %{
        dAll.Uni.pathLength(subj,:) = binData(d{subj}.Uni{6}.pathlength,Nbin);
        dAll.Uni.pathLength_null(subj,:) = binData(d{subj}.Uni{6}.pathlength_null,Nbin);
        dAll.Uni.pathLength_ratio(subj,:) = binData(d{subj}.Uni{6}.pathlength_null./d{subj}.Bi{6}.pathlength,Nbin);
        dAll.Uni.movDur(subj,:) = binData(d{subj}.Uni{6}.movtime,Nbin);
        dAll.Uni.RT(subj,:) = binData(d{subj}.Uni{6}.RT,Nbin)-100; 
        dAll.Uni.pkVel(subj,:) = binData(d{subj}.Uni{6}.pkVel,Nbin);
        %}

    % bimanual no-jump data
    %{
    dAll.BiNoJmp.pathLength(subj,:) = Bi_nojmp{subj}.pathlength;
    dAll.BiNoJmp.movDur(subj,:) = Bi_nojmp{subj}.movtime;
    dAll.BiNoJmp.RT(subj,:) = Bi_nojmp{subj}.RT;
    dAll.BiNoJmp.pkVel(subj,:) = Bi_nojmp{subj}.pkVel;
    %}
    
    %-- Perturbation response------------------------
    dt = 1000/130;

    % Bimanual
        r = getResponses([-d{subj}.Bi{1}.CrX_post ; d{subj}.Bi{5}.CrX_post],.03,dt);
        dAll.Bi.response_large.pos(subj,:) = r.pos;
        dAll.Bi.response_large.vel(subj,:) = r.vel;
        dAll.time = r.time;
        
        r = getResponses([-d{subj}.Bi{2}.CrX_post ; d{subj}.Bi{4}.CrX_post],.015,dt);
        dAll.Bi.response_small.pos(subj,:) = r.pos;
        dAll.Bi.response_small.vel(subj,:) = r.vel;
                
        r = getResponses(d{subj}.Bi{3}.CrX_post,0,dt);
        dAll.Bi.response_nojmp.pos(subj,:) = r.pos;
        dAll.Bi.response_nojmp.vel(subj,:) = r.vel;
    % unimanual
    %{
        r = getResponses([-d{subj}.Uni{c}{1}.CrX_post ; d{subj}.Uni{c}{5}.CrX_post],.03,dt);
        dAll.Uni.response_large.pos(subj,:,c) = r.pos;
        dAll.Uni.response_large.vel(subj,:,c) = r.vel;
        
        r = getResponses([-d{subj}.Uni{c}{2}.CrX_post ; d{subj}.Uni{c}{4}.CrX_post],.015,dt);
        dAll.Uni.response_small.pos(subj,:,c) = r.pos;
        dAll.Uni.response_small.vel(subj,:,c) = r.vel;
        
        r = getResponses(d{subj}.Uni{c}{3}.CrX_post,0,dt);
        dAll.Uni.response_nojmp.pos(subj,:,c) = r.pos;
        dAll.Uni.response_nojmp.vel(subj,:,c) = r.vel;
    %}
    % average response over a time window
    rng = 51:70; % range to examine feedback response


        for pert = 1:5
            %average response in a window
            dAll.Bi.pResponseAv(pert,subj) = nanmean(nanmean(diff(d{subj}.Bi{pert}.CrX_post(:,rng)'))');
            %dAll.Uni.pResponseAv(pert,subj) = nanmean(nanmean(diff(d{subj}.Uni{pert}.CrX_post(:,rng)'))');
            
            % peak response and latency
            [dAll.Bi.peakResponse_large(subj), dAll.Bi.peakResponse_lat_large(subj)] = max(nanmean(dAll.Bi.response_large.vel(subj,:)));
            [dAll.Bi.peakResponse_small(subj), dAll.Bi.peakResponse_lat_small(subj)] = max(nanmean(dAll.Bi.response_small.vel(subj,:)));
            [dAll.Bi.peakResponse_nojmp(subj), dAll.Bi.peakResponse_lat_nojmp(subj)] = max(nanmean(dAll.Bi.response_nojmp.vel(subj,:)));
        end

    
%{
        for pert = 1:5
            [dAll.Uni.peakResponse_large(subj), dAll.Uni.peakResponse_lat_large(subj)] = max(nanmean(dAll.Uni.response_large.vel(subj,:)));
            [dAll.Uni.peakResponse_small(subj), dAll.Uni.peakResponse_lat_small(subj)] = max(nanmean(dAll.Uni.response_small.vel(subj,:)));
            [dAll.Uni.peakResponse_nojmp(subj), dAll.Uni.peakResponse_lat_nojmp(subj)] = max(nanmean(dAll.Uni.response_nojmp.vel(subj,:)));
        end
%}
    
end

save Bimanual_compact dAll

