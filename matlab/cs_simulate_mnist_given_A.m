function [succ] = cs_simulate_mnist_given_A(A, x_true)
    % Run a trail of L1  minimization
    % N      - dimension  of the  signal
    % alpha  - M/N, where M is the  number  of  measurements
    % x      - the actual signal
    % If the  error  is less  then 1e-3, then  return 1 other  wise  return 0
    y = A * x_true;
    x_est = solve_l1cs(A, y);
    e = norm(x_est - x_true);
    if e < 1e-3
        succ = 1;
    else
        succ = 0;
    end
end