rand('seed',123), randn('seed',123)
fprintf('Fair Kernel Learning (sex,race)\n')
if exp==1
    reps = 2;
    n    = 50;
    nva2 = 50;
    nte2 = 50;
elseif exp==2
    reps = 25;
    n    = 7000;
    nva2 = 7000;
    nte2 = 16281;
end
rps = cell(1,reps);
resK = cell(1,reps);
resKu = cell(1,reps);
resL = cell(1,reps);
resLu = cell(1,reps);
for ii=1:reps
    %% set training and validation sets
    load a9a.mat
    rp = randperm(size(X,1));
    rps{ii} = rp;
    X = X(rp,:);
    label_vector = label_vector(rp);
    tr  = X(1:n,:);
    ytr = label_vector(1:n);
    iQ = [67:71 72:73];% race, sex
    Q   = X(1:n,iQ); % Variable to enforce independence
    nva = n+nva2;
    va  = X(n+1:nva,:);
    yva = label_vector(n+1:nva);
    
    %% set test test
    load a9a_test.mat
    te = X(1:nte2,:);
    yte = label_vector(1:nte2);
    Qte = te(1:nte2,iQ);
    %% clear some variables
    clear X label_vector
    
    %% FAIR KERNEL LEARNING
    [resK{ii}] = FKL(tr,ytr,va,yva,Q,te,yte,Qte);
    %% FAIR LINEAR LEARNING
    [resL{ii}] = FL(tr,ytr,va,yva,Q,te,yte,Qte);
    %% avoid sensitive features from training (and train)
    uf = setdiff(1:size(tr,2), iQ);
    utr = tr(:,uf);
    uva = va(:,uf);
    ute = te(:,uf);
    [resKu{ii}] = FKL(utr,ytr,uva,yva,Q,ute,yte,Qte);
    [resLu{ii}] = FL(utr,ytr,uva,yva,Q,ute,yte,Qte);
    save results/FKL_sex_race.mat resK resKu resL resLu
end
