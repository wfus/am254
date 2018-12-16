%% Plots the results of scanning rho and alpha for the basis pursuit
% problem, and shows a heat map of the retrieval rate. I do this for both
% the case with the original signal coming from sparse Laplacian and
% coming from sparse Gaussian. The parameters used were:
%   100 samples of alpha from 0.01 to 1
%   100 samples of rho from 0.01 to 1
%   20 trials for every specific alpha and rho.

gaussian_succ = load('../data/basis_pursuit_gaussian.mat');
laplacian_succ = load('../data/basis_pursuit_laplacian.mat');
rhos = (1:100) / 100;
alphas = (1:100) / 100;
N_TRIALS = 20;
gaussian_probs = zeros(length(rhos), length(alphas));
laplacian_probs = zeros(length(rhos), length(alphas));
for i = 1 : length(rhos)
    for j = 1 : length(alphas)
        gaussian_probs(i, j) = gaussian_succ.overall_succ{i}{j};
        laplacian_probs(i, j) = laplacian_succ.overall_succ{i}{j};
    end
end
gaussian_probs = gaussian_probs / N_TRIALS;
gaussian_probs = gaussian_probs.';
laplacian_probs = laplacian_probs / N_TRIALS;
laplacian_probs = laplacian_probs.';

%% Draw the Basis pursuit heatmap for Gaussian
figure
axis_gaussian = axes;
imshow(gaussian_probs, 'InitialMagnification', 'fit',...
                       'XData', 0.01:0.01:1, 'YData', 0.01:0.01:1);
axis on
ax = gca;
ax.YDir = 'normal';
colormap(axis_gaussian, jet);
colorbar;

title('Basis Pursuit Retrieval Probabilty with Laplacian Signal');
xlabel('Undersampling rate \alpha = M / N');
ylabel('Sparsity of original signal \rho');

%% Draw the basis pursuit heatmap for Laplacian
figure
axis_laplacian = axes;
imshow(laplacian_probs, 'InitialMagnification', 'fit',...
                       'XData', 0.01:0.01:1, 'YData', 0.01:0.01:1);
axis on
ax = gca;
ax.YDir = 'normal';
colormap(axis_laplacian, jet);
colorbar;

title('Basis Pursuit Retrieval Probabilty with Gaussian Signal');
xlabel('Undersampling rate \alpha = M / N');
ylabel('Sparsity of original signal \rho');

