function dAll = compactify_data(d)
% generates a more compact data structure, with each subject as a row

for subj = 1:length(d)
    Nday = 4;

    Nbin = 40; % number of trials to bin together

        % null path length
        dAll.pathLength(subj,:) = binData(d{subj}{6}.pathlength,Nbin);
        dAll.pathLength_null(subj,:) = binData(d{subj}{6}.pathlength_null,Nbin);
        dAll.pathLength_ratio(subj,:) = binData(d{subj}{6}.pathlength_null./d{subj}{6}.pathlength,Nbin);
        dAll.movDur(subj,:) = binData(d{subj}{6}.movtime,Nbin);
        dAll.RT(subj,:) = binData(d{subj}{6}.RT,Nbin)-100;
        dAll.pkVel(subj,:) = binData(d{subj}{6}.pkVel,Nbin);

    %-- Perturbation response------------------------
    dt = 1000/130;

        r = getResponses([-d{subj}{1}.CrX_post ; d{subj}{5}.CrX_post],.03,dt);
        dAll.response_large.pos(subj,:) = r.pos;
        dAll.response_large.vel(subj,:) = r.vel;
        dAll.time = r.time;
        
        r = getResponses([-d{subj}{2}.CrX_post ; d{subj}{4}.CrX_post],.015,dt);
        dAll.response_small.pos(subj,:) = r.pos;
        dAll.response_small.vel(subj,:) = r.vel;
                
        r = getResponses(d{subj}{3}.CrX_post,0,dt);
        dAll.response_nojmp.pos(subj,:) = r.pos;
        dAll.response_nojmp.vel(subj,:) = r.vel;

    % average response over a time window
    rng = 51:70; % range to examine feedback response


        for pert = 1:5
            %average response in a window
            dAll.pResponseAv(pert,subj) = nanmean(nanmean(diff(d{subj}{pert}.CrX_post(:,rng)'))');
            
            % peak response and latency
            [dAll.peakResponse_large(subj), dAll.peakResponse_lat_large(subj)] = max(nanmean(dAll.response_large.vel(subj,:)));
            [dAll.peakResponse_small(subj), dAll.peakResponse_lat_small(subj)] = max(nanmean(dAll.response_small.vel(subj,:)));
            [dAll.peakResponse_nojmp(subj), dAll.peakResponse_lat_nojmp(subj)] = max(nanmean(dAll.response_nojmp.vel(subj,:)));
        end
end