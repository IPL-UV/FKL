clear,
fprintf('Showing FDR results\n')

% Formatting figures
fontname = 'Helvetica';%'Bookman';
fontsize = 24;
fontunits = 'points';
set(0,'DefaultAxesFontName',fontname,'DefaultAxesFontSize',fontsize,'DefaultAxesFontUnits',fontunits,...
    'DefaultTextFontName',fontname,'DefaultTextFontSize',fontsize,'DefaultTextFontUnits',fontunits,...
    'DefaultLineLineWidth',5,'DefaultLineMarkerSize',18,'DefaultLineColor',[0 0 0]);

co = [ 0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250;
    0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840];

name = {'FDR_sex','FDR_sex_race'};

for iii=1:length(name)
    load(name{iii})
    reps = length(res);
    
    for i=1:reps
        %
        dPCA(i,:) = res{i}.PCA.dep;
        aPCA(i,:) = 1-res{i}.PCA.acc;
        %
        dDPCA(i) = res{i}.DPCA.dep;
        aDPCA(i) = 1-res{i}.DPCA.acc;
        %
        dKPCA(i,:) = res{i}.KPCA.dep;
        aKPCA(i,:) = 1-res{i}.KPCA.acc;
        %
        dKDPCA(i) = res{i}.KDPCA.dep;
        aKDPCA(i) = 1-res{i}.KDPCA.acc;
    end
    figure,
    plot(mean(aPCA), mean(dPCA), '-', 'color', co(1,:))
    hold on
    plot(mean(aDPCA), mean(dDPCA), 'x', 'color', co(1,:))
    plot(mean(aKPCA), mean(dKPCA), '-', 'color', co(2,:))
    plot(mean(aKDPCA), mean(dKDPCA), '+', 'color', co(2,:))
    %
    clear dPCA aPCA dDPCA aDPCA dKPCA aKPCA dKDPCA aKDPCA
    for i=1:reps
        %
        dPCA(i,:) = resU{i}.PCA.dep;
        aPCA(i,:) = 1-resU{i}.PCA.acc;
        %
        dDPCA(i) = resU{i}.DPCA.dep;
        aDPCA(i) = 1-resU{i}.DPCA.acc;
        %
        dKPCA(i,:) = resU{i}.KPCA.dep;
        aKPCA(i,:) = 1-resU{i}.KPCA.acc;
        %
        dKDPCA(i) = resU{i}.KDPCA.dep;
        aKDPCA(i) = 1-resU{i}.KDPCA.acc;
    end
    plot(mean(aPCA), mean(dPCA), '-', 'color', co(6,:))
    hold on
    plot(mean(aDPCA), mean(dDPCA), 'x', 'color', co(6,:))
    plot(mean(aKPCA), mean(dKPCA), '-', 'color', co(3,:))
    plot(mean(aKDPCA), mean(dKDPCA), '+', 'color', co(3,:))
    legend('PCA','FDR','KPCA','KFDR','PCA\S','FDR\S','KPCA\S','KFDR\S','Location','northeast')
    grid on
    ylabel('unfairness'), xlabel('classification error')
    set(gca,'yscale','log')
    axis([0.2 0.3 1e-5 1e1])
    h=gcf;
    set(h,'PaperOrientation','landscape');
    set(h,'PaperUnits','normalized');
    set(h,'PaperPosition', [0 0 1 1]);
    print(h,'-dpdf', strcat('figures/',name{iii},'_dep_acc','.pdf'))
    print(h,'-dpdf', strcat('figures/',name{iii},'_dep_acc','.pdf'))
    clear dPCA aPCA dDPCA aDPCA dKPCA aKPCA dKDPCA aKDPCA
end