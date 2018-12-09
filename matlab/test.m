% run_simu_cs_L1.m
% Compute  the  prob. of  successful  revoery  of  compressive  sensing  problem
% by L1-minimization
% Chuang  Sep 22, 2015
rho = 0.5;
% fraction  of non -zero  elements  of the  signal
trails = [400, 200, 100, 50];
N = [100, 200, 400, 800];
alphas ={(30:49)/50;  (30:49)/50;  (35:45)/50;  (38:45)/50};

% alpha = M/N
k = 1;
tic
    succ_all = cell(length(N), 1);
    for k = 1: length(N)
        n = N(k);
        trail = trails(k);
        alpha = alphas{k};
        succ=zeros(length(alpha ));
        parfor j = 1:length(alpha)
            a = alpha(j);
            s = 0;
            for i=1: trail
                s = s+cs_simulate_l1( n, a, rho );
            end
            succ(j)=s/trail;
            fprintf('%d, %f, %d\n', n, a, s);
        end
    succ_all{k}=succ;
    end
toc
