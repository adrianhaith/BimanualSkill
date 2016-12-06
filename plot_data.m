% plot aggregate data across subjects
% plot target jump responses (as position or velocity) as well as basic
% trajectory metrics (path length etc)
%
clear all
load Bimanual_compact

cc = linspace(0,1,7)';
cu = linspace(1,0,7)';
col = [cc 0*cc 0*cu];

%% mean perturbation response across subjects - position
figure(1); clf; hold on
subplot(1,2,1); hold on;
time = dAll.time;
    %plot(time,mean(dAll.Bi.response_small.pos,1),'color','r','linewidth',2)
    shadedErrorBar(time,mean(dAll.Bi.response_small.pos,1),seNaN(dAll.Bi.response_small.pos),{'-','color','r'},1);

%plot(time,mean(dAll.Uni.response_small.pos(:,:,1)),'b','linewidth',2)
%shadedErrorBar(time,mean(dAll.Uni.response_small.pos(:,:,1)),seNaN(dAll.Uni.response_small.pos(:,:,1)),'b-',1);
plot(time,.015*ones(size(time)),'k:')
axis([-100 2000 -.005 .04])
xlabel('Time post-perturbation')
ylabel('Cursor velocity parallel to target jump')

subplot(1,2,2); hold on
    %plot(time,mean(dAll.Bi.response_large.pos,1),'color','m','linewidth',2)
    shadedErrorBar(time,mean(dAll.Bi.response_large.pos,1),seNaN(dAll.Bi.response_large.pos),{'-','color','m'},1);

%plot(time,nanmean(dAll.Uni.response_large.pos(:,:,1)),'b','linewidth',2)
%shadedErrorBar(time,nanmean(dAll.Uni.response_large.pos(:,:,1)),seNaN(dAll.Uni.response_large.pos(:,:,1)),'b-',1);
plot(time,.03*ones(size(time)),'k:')
axis([-100 2000 -.005 .04])
xlabel('Time post-perturbation')
ylabel('Cursor position parallel to target jump')

%% mean perturbation response across subjects - velocity
figure(2); clf; hold on
subplot(1,2,1); hold on;
time = dAll.time(1:end-1);

    %plot(time,mean(dAll.Bi.response_small.vel,1),'color','r','linewidth',2)
    shadedErrorBar(time,mean(dAll.Bi.response_small.vel,1),seNaN(dAll.Bi.response_small.vel),{'-','color','r'},1);

%plot(time,mean(dAll.Uni.response_small.vel(:,:,1)),'b','linewidth',2)
%shadedErrorBar(time,mean(dAll.Uni.response_small.vel(:,:,1)),seNaN(dAll.Uni.response_small.vel(:,:,1)),'b-',1);
axis([0 2000 -.00002 .00012])
xlabel('Time post-perturbation')
ylabel('Cursor velocity parallel to target jump')

subplot(1,2,2); hold on
    %plot(time,mean(dAll.Bi.response_large.vel,1),'color','m','linewidth',2)
    shadedErrorBar(time,mean(dAll.Bi.response_large.vel,1),seNaN(dAll.Bi.response_large.vel),{'-','color','m'},1);

%plot(time,nanmean(dAll.Uni.response_large.vel(:,:,1)),'b','linewidth',2)
%shadedErrorBar(time,nanmean(dAll.Uni.response_large.vel(:,:,1)),seNaN(dAll.Uni.response_large.vel(:,:,1)),'b-',1);
axis([0 2000 -.00002 .00012])
xlabel('Time post-perturbation')
ylabel('Cursor velocity parallel to target jump')


%% trajectory metrics (path length, etc)
figure(3); clf; hold on
subplot(1,3,1); hold on
shadedErrorBar([1:size(dAll.Bi.pathLength,2)],mean(dAll.Bi.pathLength,1),seNaN(dAll.Bi.pathLength),'.-',1);
%shadedErrorBar([1:size(dAll.Uni.pathLength,2)],mean(dAll.Uni.pathLength,1),seNaN(dAll.Uni.pathLength),'k.-',1);
%plot([0 45],mean(mean(dAll.Uni.pathLength))*[1 1],'k')
plot([0 45],[.12 .12],'-','color',.5*[1 1 1])
%plot(repmat([5.5 15.5 25.5]',1,2)+10,[0 2],'k')
%plot(repmat([10.5 20.5 30.5]',1,2)+10,[0 2],'k:')
axis([0 6 0 .7])
xlabel('block')
ylabel('path length')

subplot(1,3,2); hold on
shadedErrorBar([1:size(dAll.Bi.RT,2)],mean(dAll.Bi.RT,1),seNaN(dAll.Bi.RT),'.-',1);
%shadedErrorBar(1:size(dAll.Uni.RT,2),mean(dAll.Uni.RT,1),seNaN(dAll.Uni.RT),'k.-',1);
%plot(dAll.RT(s,:),'.-','linewidth',2)
%plot(dAll.Uni.RT(s,:),'k.-','linewidth',2)
%plot([0 45],mean(mean(dAll.Uni.RT))*[1 1],'k')
%plot(repmat([5.5 15.5 25.5]',1,2)+10,[0 1000],'k')
%plot(repmat([10.5 20.5 30.5]',1,2)+10,[0 1000],'k:')
axis([0 6 0 600])
xlabel('block')
ylabel('RT')

subplot(1,3,3); hold on
shadedErrorBar([1:size(dAll.Bi.pkVel,2)],mean(dAll.Bi.pkVel,1),seNaN(dAll.Bi.pkVel),'.-',1);
%shadedErrorBar(1:size(dAll.Uni.pkVel,2),mean(dAll.Uni.pkVel,1),seNaN(dAll.Uni.pkVel),'k.-',1);
%plot(dAll.pkVel(s,:),'.-','linewidth',2)
%plot(dAll.Uni.pkVel(s,:),'k.-','linewidth',2)
%plot([0 45],mean(mean(dAll.Uni.pkVel))*[1 1],'k')
%plot(repmat([5.5 15.5 25.5]',1,2)+10,[0 1000],'k')
%plot(repmat([10.5 20.5 30.5]',1,2)+10,[0 1000],'k:')
axis([0 6 0 .004])
xlabel('block')
ylabel('peak Vel')

