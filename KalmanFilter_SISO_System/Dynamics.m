classdef Dynamics
    properties (Access = public)
        % Setup Time 
        time    = 0    % Start Time
        endtime = 20   % End Time
        dt      = 0.1  % sampling Time
    end
    properties (Access = public)
        Q        % The Process Covariance matrix
        R        % The Measurment Covariance matrix
        A        % Process matrix A
        B        % Process matrix B
        C        % Mesurment matrix  
        xTrue    % State quantities
        z        % Measurment quantities
        xEst     % State estimation
        PEst     % The Covariance Matrix estimation  
        zEst     % Measurment estimation
        nsteps   % Iteration Steps
        Flag_sys % Swicth xTrue 1 or xEst 0
        Flag_mea % Switch xTrue 1 or xPred 0
    end
    properties (Access = public)
        % Root Mean Square Error
        Root_mean_square_error
    end
    properties (Access = protected)
        xPred  % Prior State estimation
        PPred  % The Prior Covariance Matrix estimation
        K      % Kalman Gain  
    end
    %Initialize
    methods (Access = public)
        function this = Dynamics(xTrue, z, xEst, PEst, Q, R)
            switch nargin
                case 6
                    this.xTrue  = xTrue;
                    this.z      = z;
                    this.xEst   = xEst;
                    this.PEst   = PEst;
                    this.Q      = Q;
                    this.R      = R;
                    this.nsteps = ceil((this.endtime - this.time) / this.dt);
                otherwise
                    disp('Error');
            end
        end
        function this = RMSE(this)
            this.Root_mean_square_error = sqrt(mean(this.xTrue(1) - this.xEst(1))^2);
        end
    end
    methods (Access = protected)
        % System model
        function x = f(this, Flag)
            v = randn(size(this.B, 2), size(this.B, 2)) * sqrtm(this.Q);
            switch Flag
                case 1
                    x = this.A * this.xTrue + this.B * v;
                case 0
                    x = this.A * this.xEst + this.B * v;
            end
        end
        % Obzervation model
        function z = h(this, Flag)
            switch Flag
                case 1
                    z = this.C * this.xTrue;
                case 0
                    z = this.C * this.xPred;
            end
        end
        % Obzervation
        function this = Obzervation(this)
            this.Flag_sys = 1; 
            this.xTrue    = f(this, this.Flag_sys);
            this.Flag_mea = 1; 
            this.z        = h(this, this.Flag_mea) + randn(size(this.C, 1), size(this.C, 1)) * sqrtm(this.R);
        end
    end
end