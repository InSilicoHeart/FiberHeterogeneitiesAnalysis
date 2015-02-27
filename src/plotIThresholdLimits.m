function plotIThresholdLimits(pathToSave)

close all;


if(~isempty(dir([pathToSave '/status.mat'])))
    sim_stat = load([pathToSave '/status.mat']);

    if(isfield(sim_stat,'minIStim') && isfield(sim_stat,'maxIStim'))
        minIStim=sim_stat.minIStim;
        maxIStim=sim_stat.maxIStim;
        IStep = sim_stat.IStep;
        Istim_str = ['Istim/Istim_' num2str(minIStim)];
        a=load([pathToSave '/' Istim_str '/post/IThreshold_prc0_00000151.var']);
        b=load([pathToSave '/' Istim_str '/post/IThreshold_prc0_00000176.var']);
        c=load([pathToSave '/' Istim_str '/post/IThreshold_prc0_00000201.var']);
        d=load([pathToSave '/' Istim_str '/post/IThreshold_prc0_00000226.var']);
        e=load([pathToSave '/' Istim_str '/post/IThreshold_prc0_00000251.var']);

        f=figure;
        subplot(2,1,1)
        plot(a(:,1),a(:,2),b(:,1),b(:,2),c(:,1),c(:,2),d(:,1),d(:,2),e(:,1),e(:,2))
        title(num2str(minIStim))

        Istim_str = ['Istim/Istim_' num2str(maxIStim)];
        a=load([pathToSave '/' Istim_str '/post/IThreshold_prc0_00000151.var']);
        b=load([pathToSave '/' Istim_str '/post/IThreshold_prc0_00000176.var']);
        c=load([pathToSave '/' Istim_str '/post/IThreshold_prc0_00000201.var']);
        d=load([pathToSave '/' Istim_str '/post/IThreshold_prc0_00000226.var']);
        e=load([pathToSave '/' Istim_str '/post/IThreshold_prc0_00000251.var']);

        subplot(2,1,2)
        plot(a(:,1),a(:,2),b(:,1),b(:,2),c(:,1),c(:,2),d(:,1),d(:,2),e(:,1),e(:,2))
        title(num2str(maxIStim))

        saveas(f,[pathToSave '/Istim.pdf'])
    end
end
