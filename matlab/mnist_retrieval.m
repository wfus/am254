%%
% Load in MNIST and make sure that the numbers are doubles
% from the range 0 to 1
mnist = load('data/mnist.mat');
mnist.testX = double(mnist.testX) / 255.0;
mnist.trainX = double(mnist.testX) / 255.0;
mnist.testY = double(mnist.testX) / 255.0;
mnist.trainY = double(mnist.testX) / 255.0;

%%
% Run simulations for the MNIST test set for 100 characters for a certain
% undersampling rate rho using random matrices.

images = mnist.testX;
alphas_random = (10:32) / 50;
NUM_TRIALS = 100;
MNIST_DIM = 784;

parfor j = 1 : length(alphas_random)
    a = alphas_random(j);
    s = 0;
    for i = 1 : NUM_TRIALS
        s = s + cs_simulate_mnist(MNIST_DIM, a, images(i, :).');
    end
    succ_random(j) = s / NUM_TRIALS;
    fprintf('alpha=%f, successes=%d\n', a, s);
end

%%
% Run simulations for the MNIST test set for 100 characters for a certain
% undersampling rate using learned MNIST 

m = load('data/small_mnist_sensing.mat');
sensing_mats = {m.sensematrix4, m.sensematrix8, m.sensematrix12, ... 
                m.sensematrix16, m.sensematrix20, m.sensematrix24};
images = mnist.testX;
NUM_TRIALS = 100;
MNIST_DIM = 784;
NUM_ALPHAS = int32(length(sensing_mats));
% Find the undersampling ratios from the size of each sampling matrix
alphas_fixed = zeros(NUM_ALPHAS);
for i = 1 : NUM_ALPHAS
    alphas_fixed(i) = size(sensing_mats{i}, 1) / MNIST_DIM;
end

parfor j = 1 : NUM_ALPHAS
    s = 0;
    A = double(sensing_mats{j})
    for i = 1 : NUM_TRIALS
        s = s + cs_simulate_mnist_given_A(A, images(i, :).');
    end
    succ_fixed(j) = s / NUM_TRIALS;
    fprintf('alpha=%f, successes=%d\n', alphas_fixed(j), s);
end
