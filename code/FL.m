% Fair (Linear) Learning
% http://isp.uv.es/
% Adrian Perez-Suay, 2017 (c) Copyright
% Contact: adrian.perez@uv.es

function [res] = FL(tr,ytr,va,yva,Q,te,yte,Qte)

%% parameters
lambdas = logspace(-4,3,7);
d       = size(tr,2);
ntr     = length(ytr);
nva     = length(yva);
nte     = length(yte);
%% LR train
acc_va_wc = zeros(1,length(lambdas));
% fprintf('Training Linear Regression...\n');
C   = tr'*tr;
for i=1:length(lambdas)
    % classical
    wc  = (lambdas(i)*eye(d) + C)\(tr'*ytr);
    acc_va_wc(i) = sum(yva == sign(va*wc))/nva;
end
%% parameter for LR
[~,mm] = max(max(acc_va_wc));
la = lambdas(mm);
wc = (la*eye(d) + C)\(tr'*ytr); % optimal KRR weights
%% FAir Linear regression
mus     = (ntr^2)*logspace(-7,3,25);
acc_wd  = zeros(1,length(mus));
dep_wd  = zeros(1,length(mus));
wds     = cell(1,length(mus));
Hte     = eye(nte) - (1/nte)*(ones(nte)); % centering matrix for the kernel
HQteQteH    = Hte*Qte*Qte'*Hte;
H     = eye(ntr) - (1/ntr)*(ones(ntr)); % centering matrix for the kernel
HQQH    = H*Q*Q'*H;
% fprintf('Fair Linear Learning...\n');
for k=1:length(mus)
    % disparate
    wd  = (la*eye(d) + C + mus(k)*(1/ntr^2)*tr'*HQQH*tr)\(tr'*ytr);
    wds{k} = wd;
    %
    acc_wd(k) = sum(yte == sign(te*wd))/nte;
    dep_wd(k) = (1/nte^2)*trace(HQteQteH*(te*wd)*(te*wd)');
end
acc_wc = sum(yte == sign(te*wc))/nte;
dep_wc = (1/nte^2)*trace(HQteQteH*(te*wc)*(te*wc)');

%% return model and parameters.
res.acc_wc  = acc_wc;
res.dep_wc  = dep_wc;
res.acc_wd  = acc_wd;
res.dep_wd  = dep_wd;
res.mus     = mus;
res.lambda  = la;
res.tr      = tr;
res.ytr     = ytr;
res.Q       = Q;
res.wc      = wc;
res.wd      = wds;

%% plot results

if false
    figure(1),clf,semilogx(mus,acc_wd,'*-')
    hold on, grid on
    semilogx(mus,acc_wc*ones(1,length(acc_wd)),'r--')
    xlabel('mu')
    ylabel('accuracy')
    
    figure(2),clf,semilogx(mus,dep_wd,'*-')
    hold on, grid on
    semilogx(mus,dep_wc*ones(1,length(dep_wd)),'r--'),
    xlabel('mu')
    ylabel('HSIC')
end

end
