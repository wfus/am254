%% Attempts to try getting a phase transition diagram 
% Looking at the basis pursuit problem with data coming from Laplacian
% with some extra sparsity.
% can we see the phase transition?

TRIALS_PER_RUN = 20;
N = 200;
RHOS = (1:100)/ 100;
ALPHAS = (1:100) / 100;

parfor i = 1 : length(RHOS)
    rho = RHOS(i);
    
    for j = 1 : length(ALPHAS)
        alpha = ALPHAS(j);
        % simulate all of the attempts now for this alpha and rho value
        s = 0;
        for k = 1 : TRIALS_PER_RUN
            s = s + cs_simulate_l1_laplacian(N, alpha, rho);
        end
        fprintf('N=%d, alpha=%f, successes=%d\n', N, alpha, s);
        overall_succ{i}{j} = s;
    end
    fprintf('Rho=%f has completed!', rho);
end