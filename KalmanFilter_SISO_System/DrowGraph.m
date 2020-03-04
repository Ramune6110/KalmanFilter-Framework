function DrowGraph(Result)
    figure(1);
    plot(Result.time, Result.xTrue(:, 1), 'r--', Result.time, Result.xEst(:, 1),'b--');
    set(gca, 'fontsize', 10, 'fontname', 'times');
    xlabel('Time [s]','fontsize', 12,'interpreter','latex')
    ylabel('State','fontsize', 12,'interpreter','latex')
    leg=legend('True value','Estimate value','Location','best','fontsize', 12);
    set(leg,'interpreter','latex');
    grid on
    
    figure(2);
    plot(Result.time, Result.RMSE(:, 1),'k','LineWidth',1.0)
    set(gca, 'fontsize', 12, 'fontname', 'times');
    xlabel('Time [s]','fontsize', 15, 'interpreter','latex')
    ylabel('RMSE','fontsize', 15, 'interpreter','latex')
    leg=legend('RMSE','Location','best','fontsize', 12);
    set(leg,'interpreter','latex');
    grid on;
    
    % Root Mean Square Error
    RMSE = @(x) sqrt(mean(x.^2));
    fprintf('%10s %10s\n','variable','RMSE(KF)');
    vname = sprintf('State');
    fprintf('%10s %10.5f \n',vname,RMSE(Result.xTrue(:, 1) - Result.xEst(:, 1)));
end