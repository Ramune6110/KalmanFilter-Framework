% ------------------------------------------------
% Date 2020 03/05
% Author Ramune6110
% State Estimation for Random work with KF
% ------------------------------------------------
clear;
close all;
clc;
% Create instance
% Intialize x, z, xEst, PEst Q R
KF   = KF(0, 0, 0, 1, 1, 0.1);
KF.A = 1;
KF.B = 1;
KF.C = 1;
% Save data box
Result.time  = [];
Result.xTrue = [];
Result.xEst  = [];
Result.RMSE  = [];

tic
for i = 1 : KF.nsteps
    % kalmanfilter
    KF = KalmanFilter(KF);
    % Save data
    Result.time  = [Result.time;  KF.time];
    Result.xTrue = [Result.xTrue; KF.xTrue'];
    Result.xEst  = [Result.xEst;  KF.xEst'];
    Result.RMSE  = [Result.RMSE;  KF.Root_mean_square_error];
end
toc;
% Drow the graph
DrowGraph(Result);