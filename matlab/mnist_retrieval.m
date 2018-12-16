%%
% Load in MNIST and make sure that the numbers are doubles
% from the range 0 to 1
mnist = load('mnist.mat');
mnist.testX = double(mnist.testX) / 255.0;
mnist.trainX = double(mnist.testX) / 255.0;
mnist.testY = double(mnist.testX) / 255.0;
mnist.trainY = double(mnist.testX) / 255.0;

%%
% Run simulations for the MNIST test set for 100 characters for a certain
% undersampling rate rho using random matrices.

alphas = (20:49) / 50;
NUM_TRIALS = 100;
MNIST_DIM = 784;

parfor j = 1 : length(alphas)
    a = alphas(j);
    s = 0;
    for i = 1 : NUM_TRIALS
        s = s + cs_simulate_mnist(MNIST_DIM, a, mnist.testX(i, :).');
    end
    succ(j) = s / NUM_TRIALS;
    fprintf('alpha=%f, successes=%d\n', a, s);
end