function DrowGraph(Result)
    figure(1);
    for i = 1 : 3
        if i == 3
            subplot(3,1,i);
            plot(Result.time, Result.xTrue(:, i), 'r--', Result.time, Result.xEst(:, i),'b--');
            set(gca, 'fontsize', 10, 'fontname', 'times');
            xlabel('Time [s]','fontsize', 12,'interpreter','latex')
            ylabel('State','fontsize', 12,'interpreter','latex')
            leg=legend('True value','Estimate value','Location','best','fontsize', 12);
            set(leg,'interpreter','latex');
            grid on
        else
            subplot(3,1,i);
            plot(Result.time, Result.xTrue(:, i), 'r--', Result.time, Result.xEst(:, i),'b--');
            set(gca, 'fontsize', 10, 'fontname', 'times');
            ylabel('State','fontsize', 12,'interpreter','latex')
            grid on
        end
    end

    figure(2);
    for i = 1 : 3
        if i == 3
            subplot(3,1,i);
            plot(Result.time, Result.RMSE(:, i),'k','LineWidth',1.0)
            set(gca, 'fontsize', 12, 'fontname', 'times');
            xlabel('Time [s]','fontsize', 15, 'interpreter','latex')
            ylabel('RMSE','fontsize', 15, 'interpreter','latex')
            leg=legend('RMSE','Location','best','fontsize', 12);
            set(leg,'interpreter','latex');
            grid on;
        else
            subplot(3,1,i);
            plot(Result.time, Result.RMSE(:, i),'k','LineWidth',1.0)
            set(gca, 'fontsize', 12, 'fontname', 'times');
            ylabel('RMSE','fontsize', 15, 'interpreter','latex')
            grid on;
        end
    end
    
    % Root Mean Square Error
    RMSE = @(x) sqrt(mean(x.^2));
    fprintf('%10s %10s\n','variable','RMSE(KF)');
    for i = 1 : 3
        vname = sprintf('State');
        fprintf('%10s %10.5f \n',vname,RMSE(Result.xTrue(:, i) - Result.xEst(:, i)));
    end
end