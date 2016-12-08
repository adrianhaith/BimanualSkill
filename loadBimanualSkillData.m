% loads raw data from all subjects into a series of .mat data files (one
% per subject)
%
% This example loads a single 'chunk' (block of 5 trials)
clear all
subjnames = {'S1'}; % add more subjects to this list
Nsubj = length(subjnames);

for subj = 1:Nsubj
    clear data
    disp(['Subj ',num2str(subj),'/',num2str(Nsubj),' : ',subjnames{subj}]);
    disp('    Loading Subject Data...');
    data.Bi = loadSubjData(['Data/',subjnames{subj}],{'B1','B2','B3','B4','B5'}); % load one chunk - loadSubjData(Subjname, {blocknames}); load in chunks of 5 based on target jumps

    %data.Uni = loadSubjData(['Data/',subjnames{subj},'/D5'],{'U1','U2','U3','U4','U5'}); % Unimanual chunk
    
    %data.nojmp.Bi = loadSubjData([subjnames{subj},'/D1'],{'B0'}); % data from a block that didn't include target jumps

    % process data (smooth etc, rotate, get RT, etc.)
    disp('    Processing Data...')
        data.Bi = processData(data.Bi);
        %data.Uni = processData(data.Uni);
        %data.nojmp.Bi = processData(data.nojmp.Bi);

    % split into jump types - save this into a different data structure d
    disp('    Splitting data by jump type...')
        d.Bi{subj} = splitDatabyJump(data.Bi);
        %d{subj}.Uni = splitDatabyJump(data.Uni);

    % store no jump trials in a separate data structure to store separately
    %Bi_nojmp{subj} = data.nojmp.Uni1;
    
    % save data from this subject in a separate file
    fname = fullfile(['BimanualSkillData_S',num2str(subj)]);
    save(fname,'data')
end
    
d_full = d;
d.Bi = compactify_data(d_full.Bi);

save BimanualSkillData d_full %Uni_nojmp
save Bimanual_compact d
disp('All Done')