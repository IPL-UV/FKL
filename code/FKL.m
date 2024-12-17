% Fair Kernel Learning
% http://isp.uv.es/
% Adrian Perez-Suay, 2017 (c) Copyright
% Contact: adrian.perez@uv.es

function [res] = FKL(tr,ytr,va,yva,Q,te,yte,Qte)

%% parameters
lambdas = logspace(-4,3,7);
sigmas  = logspace(-4,4,10);
ntr     = length(ytr);
nva     = length(yva);
nte     = length(yte);
%% KRR train
acc_va_wc = zeros(length(sigmas),length(lambdas));
% fprintf('Training KRR...\n');
for i=1:length(sigmas)
    K   = rbf(tr,tr,sigmas(i));
    Kva = rbf(va,tr,sigmas(i));
    for j=1:length(lambdas)
        % classical
        wc  = (lambdas(j)*eye(ntr) + K)\(ytr);
        acc_va_wc(i,j) = sum(yva == sign(Kva*wc))/nva;
    end
end
%% parameters for KRR
mm=max(max(acc_va_wc));
[I,J] = find(acc_va_wc==mm);
if length(I)>1
%     warning('more than one maximum')
    I = I(1);J = J(1);
end
si = sigmas(I);
la = lambdas(J);
K  = rbf(tr,tr,si);
wc = (la*eye(ntr) + K)\(ytr); % optimal KRR weights
%% Fair Kernel Regression
H        = eye(ntr) - (1/ntr)*(ones(ntr)); % centering matrix for the kernel
Hte      = eye(nte) - (1/nte)*(ones(nte)); % centering matrix for the kernel
sigmas_q = logspace(-1,2,10); % search maximal dependence parameter
Kwc      = K*wc;
wcK      = wc'*K;
% fprintf('Searching maximum dependence parameter...\n');
hsic = zeros(1,length(sigmas_q));
for i=1:length(sigmas_q)
    Kq  = rbf(Q,Q,sigmas_q(i));
    HKqH = H*Kq*H;
    hsic(i) = (1/ntr^2)*wcK*HKqH*Kwc;
end
% figure,semilogx(sigmas_q,hsic),grid on
[~,ma]  = max(hsic);
sigma_q = sigmas_q(ma);
Kq      = rbf(Q,Q,sigma_q);
HKqH    = H*Kq*H;
Kte     = rbf(te,tr,si);
% Kqte
Kqte  = rbf(Qte,Qte,sigma_q);
HKqteH = Hte*Kqte*Hte;
%
mus     = logspace(-7,3,25);
acc_wd  = zeros(1,length(mus));
dep_wd  = zeros(1,length(mus));
wds     = cell(1,length(mus));
% fprintf('Fair Kernel Learning...\n');
for k=1:length(mus)
    % disparate
    wd  = (la*eye(ntr) + K + mus(k)*HKqH*K)\(ytr);
    wds{k} = wd;
    %
    acc_wd(k) = sum(yte == sign(Kte*wd))/nte;
    dep_wd(k) = (1/nte^2)*wd'*Kte'*HKqteH*Kte*wd;
end
acc_wc = sum(yte == sign(Kte*wc))/nte;
dep_wc = (1/nte^2)*wc'*Kte'*HKqteH*Kte*wc;

%% return model and parameters.
res.acc_wc  = acc_wc;
res.dep_wc  = dep_wc;
res.acc_wd  = acc_wd;
res.dep_wd  = dep_wd;
res.mus     = mus;
res.sigma_q = sigma_q;
res.lambda  = la;
res.sigma   = si;
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