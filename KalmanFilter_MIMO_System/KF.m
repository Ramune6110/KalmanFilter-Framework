classdef KF < Dynamics
    methods (Access = public)
        function KF = KF(x, z, xEst, PEst, Q, R)
            KF@Dynamics(x, z, xEst, PEst, Q, R);
        end  
        function KF = KalmanFilter(KF)
            % Filtering Setup
            KF.time     = KF.time + KF.dt;
            KF          = Input(KF);
            KF          = Obzervation(KF);
            % Prediction Step
            KF.Flag_sys = 0;
            KF.xPred    = f(KF, KF.Flag_sys);
            KF.PPred    = KF.A * KF.PEst * KF.A' + KF.B * KF.Q * KF.B';
            % Filtering Step
            KF.Flag_mea = 0;
            KF.K        = KF.PPred * KF.C' / (KF.C * KF.PPred * KF.C' + KF.R);
            KF.zEst     = h(KF, KF.Flag_mea);
            KF.xEst     = KF.xPred + KF.K * (KF.z - KF.zEst);
            KF.PEst     = (eye(size(KF.A)) - KF.K * KF.C) * KF.PPred;
            % Root Mean Square Error
            KF          = RMSE(KF);
        end
    end
end
    