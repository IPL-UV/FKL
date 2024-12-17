clear, close all
fprintf('Showing FKL results\n')

co = [ 0    0.4470    0.7410;
    0.8500    0.3250    0.0980;
    0.9290    0.6940    0.1250;
    0.4940    0.1840    0.5560;
    0.4660    0.6740    0.1880;
    0.3010    0.7450    0.9330;
    0.6350    0.0780    0.1840];

% Formatting figures
fontname = 'Helvetica';%'Bookman';
fontsize = 24;
fontunits = 'points';
set(0,'DefaultAxesFontName',fontname,'DefaultAxesFontSize',fontsize,'DefaultAxesFontUnits',fontunits,...
    'DefaultTextFontName',fontname,'DefaultTextFontSize',fontsize,'DefaultTextFontUnits',fontunits,...
    'DefaultLineLineWidth',5,'DefaultLineMarkerSize',18,'DefaultLineColor',[0 0 0]);

name = {'FKL_sex','FKL_sex_race'};
for iii=1:length(name)
    load(name{iii})
    reps = length(resK);
    for i=1:reps
        %
        aKRR(i) = 1-resK{i}.acc_wc;      % KRR
        dKRR(i) = resK{i}.dep_wc;        % KRR
        %
        aDKRR(i,:) = 1-resK{i}.acc_wd;   % DKRR
        dDKRR(i,:) = resK{i}.dep_wd;     % DKRR
        %
        aKRRS(i) = 1-resKu{i}.acc_wc;    % KRR\S
        dKRRS(i) = resKu{i}.dep_wc;      % KRR\S
        %
        aDKRRS(i,:) = 1-resKu{i}.acc_wd; % DKRR\S
        dDKRRS(i,:) = resKu{i}.dep_wd;   % DKRR\S
        %
        aLR(i) = 1-resL{i}.acc_wc;       % LR
        dLR(i) = resL{i}.dep_wc;         % LR
        %
        aDLR(i,:) = 1-resL{i}.acc_wd;    % DLR
        dDLR(i,:) = resL{i}.dep_wd;      % DLR
        %
        aLRS(i) = 1-resLu{i}.acc_wc;     % LR\S
        dLRS(i) = resLu{i}.dep_wc;       % LR\S
        %%
        aDLRS(i,:) = 1-resLu{i}.acc_wd;  % DLR\S
        dDLRS(i,:) = resLu{i}.dep_wd;    % DLR\S
    end
    
    %%
    figure,
    hold on, grid on,
    plot(mean(aDKRR),mean(dDKRR),'-','color',co(2,:)),
    %
    plot(mean(aDKRRS),mean(dDKRRS),'--','color',co(3,:)),
    %
    plot(mean(aDLR),mean(dDLR),'-','color',co(1,:)),
    plot(mean(aDLRS),mean(dDLRS),'--','color',co(6,:)),
    %
    plot(mean(aKRR),mean(dKRR),'x','color',co(2,:)),
    plot(mean(aKRRS),mean(dKRRS),'+','color',co(3,:)),
    plot(mean(aLRS),mean(dLRS),'+','color',co(1,:)),
    plot(mean(aLR),mean(dLR),'cx','color',co(6,:)),
    
    set(gca,'yscale','log')
    legend('FKR','FKRR\S','FLR','FLR\S','location','best')
    xlabel('classification error'),ylabel('unfairness')
    h=gcf;
    set(h,'PaperOrientation','landscape');
    set(h,'PaperUnits','normalized');
    set(h,'PaperPosition', [0 0 1 1]);
    print(h,'-dpdf', strcat('figures/',name{iii},'_dep_acc','.pdf'))
    print(h,'-dpdf', strcat('figures/',name{iii},'_dep_acc','.pdf'))
    
end