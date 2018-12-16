function [ succ ] = cs_simulate_l1_laplacian(N, alpha, rho)
    %Run a trail of L1  minimization
    % Chuang  Sep  22 ,2015
    % N      - dimension  of the  signal
    % alpha  - M/N, where M is the  number  of  measurements
    % rho    - fraction  of non -zero  elements  of the  signal
    % If the  error  is less  then 1e-3, then  return 1 other  wise  return 0
    M=round(N * alpha);
    N_nonzero=round(N * rho);
    r_perm=randperm(N, N_nonzero);
    x_true=zeros(N,1);
    
    % samples from gaussian
    % x_true(r_perm )=randn(N_nonzero ,1);
    
    % samples from laplacian
    x_true(r_perm ) = laprnd(N_nonzero, 1, 0, 1);
    
    
    A=randn(M,N) * sqrt(1/N);
    y=A * x_true;
    x_est = solve_l1cs(A, y);
    e=norm(x_est -x_true );
    if e < 1e-3
        succ = 1;
    else
        succ = 0;
    end
end