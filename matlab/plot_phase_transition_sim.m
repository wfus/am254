n_rhos = length(RHOS);
n_alphas = length(ALPHAS);
retrieval_probs = zeros(n_rhos, n_alphas);
for i = 1 : n_rhos
    for j = 1 : n_alphas
        retrieval_probs(i, j) = overall_succ{i}{j};
    end
end
