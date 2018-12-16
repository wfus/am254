%%
% Plots the results of running basis pursuit algorithm on MNIST using
% a random sensing matrix and using a specific sensing matrix that
% was jointly learned using a convolution neural network.
%

a = load('../data/mnist_retrieval_random_sensing.mat');
success = a.succ_random;
alphas = a.alphas_random;

plot(alphas, success)
title('MNIST Basis Pursuit Retrieval (Random Sensing Matrix)')
xlabel('Undersampling ratio \alpha = M / N')
ylabel('Retrieval Success Probability')
