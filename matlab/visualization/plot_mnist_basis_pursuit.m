%%
% Plots the results of running basis pursuit algorithm on MNIST using
% a random sensing matrix and using a specific sensing matrix that
% was jointly learned using a convolution neural network.
%

a = load('../data/mnist_retrieval_alphas.mat');
success_random = a.succ_random;
alphas_random = a.alphas_random;
success_fixed = a.succ_fixed;
alphas_fixed = a.alphas_fixed;

% Draw the actual plot
hold on
plot(alphas_random, success_random)
plot(alphas_fixed, success_fixed)

title('MNIST Basis Pursuit Retrieval (Random Sensing Matrix)')
xlabel('Undersampling ratio \alpha = M / N')
ylabel('Retrieval Success Probability')
legend('Random Sensing Matrix', 'Learned Sensing Matrix');
hold off

