% Fair Dimensionality Reduction
% http://isp.uv.es/
% Adrian Perez-Suay, 2017 (c) Copyright
% Contact: adrian.perez@uv.es

function [res] = FDR(X,ytr,Q,te,yte,Qte)
%% dimensions and number of features parameters
[N,d] = size(X);
nf = size(Q,2);
nte = length(yte);
%% PCA
[V,D] = eig(cov(X));
D = diag(D);
[D, ind] = sort(D,'descend');
D = diag(D);
V = V(:,ind);
H = eye(N) - (1/N)*ones(N);
Hte = eye(nte) - (1/nte)*ones(nte);
HKqH = H*Q*Q'*H;
%% Fair (Linear) PCA: invariant in x-axis
[VD,DD] = eigs(X'*X*X'*X,X'*(HKqH)*X+1e-7*eye(d),nf);
% fprintf('Searching maximum dependence parameter...\n');
sigmas_q = logspace(-5,3,15); % search maximal dependence parameter
hsic = zeros(1,length(sigmas_q));
for i=1:length(sigmas_q)
    K = rbf(X,X,sigmas_q(i));
    hsic(i) = (1/N^2)*trace(K*HKqH);
end
% figure,semilogx(sigmas_q,hsic),grid on
[~,ma]  = max(hsic);
sigma = sigmas_q(ma);
res.sigma = sigma;
%% Kernel PCA
K = rbf(X,X,sigma);
Kte = rbf(te,X,sigma);
[VK,DK] = eig(H*K*H);
DK = diag(DK);
[DK,  ind] = sort(DK,'descend');
DK = diag(DK);
VK = VK(:,ind);
%% Fair Kernel Dimensionality Reduction: invariant in x-axis
[VDK,DDK] = eigs(K*H*K*H*K,K*HKqH*K+1e-7*eye(N),nf);
HKqteH = Hte*Qte*Qte'*Hte;
res.PCA.dep = zeros(1,d);
res.PCA.acc = zeros(1,d);
for i=1:d
    knn = knnclassify(te*V(:,1:i),X*V(:,1:i),ytr);
    res.PCA.dep(i)   = (1/nte^2)*trace(V(:,1:i)'*te'*(HKqteH)*te*V(:,1:i));
    res.PCA.acc(i)   = sum(yte == knn)/nte;
end
%
knn = knnclassify(te*VD(:,1:nf),X*VD(:,1:nf),ytr);
res.DPCA.dep = (1/nte^2)*trace(VD(:,1:nf)'*te'*(HKqteH)*te*VD(:,1:nf));
res.DPCA.acc = sum(yte == knn)/nte;
%
res.KPCA.dep = zeros(1,d);
res.KPCA.acc = zeros(1,d);
for i=1:size(VK,2)
    knn = knnclassify(Kte*VK(:,1:i),K*VK(:,1:i),ytr);
    res.KPCA.dep(i)   = (1/nte^2)*trace(VK(:,1:i)'*Kte'*HKqteH*Kte*VK(:,1:i));
    res.KPCA.acc(i)   = sum(yte == knn)/nte;
end
%
knn = knnclassify(Kte*VDK(:,1:nf),K*VDK(:,1:nf),ytr);
res.KDPCA.dep = (1/nte^2)*trace(VDK(:,1:nf)'*Kte'*HKqteH*Kte*VDK(:,1:nf));
res.KDPCA.acc = sum(yte == knn)/nte;

end
