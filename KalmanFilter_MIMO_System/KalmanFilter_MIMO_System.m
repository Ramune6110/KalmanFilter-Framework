% ------------------------------------------------
% Date 2020 03/05 
% Author Ramune6110
% State Estimation for MIMO System with KF
% ------------------------------------------------
clear;
close all;
clc;
% Create instance
% Intialize x, z, xEst, PEst Q R
KF   = KF([0; 0; 0], [0, 0, 0], [0; 0; 0], eye(3), 1, 0.1);
KF.A = [1.1269 -0.4940 0.1129; 1 0 0; 0 1 0];
KF.B = [-0.3832; 0.5919; 0.5191];
KF.C = [1 0 0];
KF.H = [-0.3832; 0.5919; 0.5191];
% Save data box
Result.time  = [];
Result.xTrue = [];
Result.xEst  = [];
Result.RMSE  = [];

tic
for i = 1 : KF.nsteps
    % KalmanFilter
    KF = KalmanFilter(KF);
    % Save data
    Result.time  = [Result.time;  KF.time];
    Result.xTrue = [Result.xTrue; KF.xTrue'];
    Result.xEst  = [Result.xEst;  KF.xEst'];
    Result.RMSE  = [Result.RMSE;  KF.Root_mean_square_error'];
end
toc;
% Drow a graph offline
DrowGraph(Result);