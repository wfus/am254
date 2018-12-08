function [ x_rs ] = solve_l1cs( A,y )
    %Solve  compressive  sensing  problem  by L1-minimization
    % Chuang  Sep 22, 2015
    %    Cast  min |x|_1 s.t. Ax=y to a linear  programing  problem
    %    min \sum_i =1^{2N} c_i
    %    s.t.
    %    [A -A] c =y
    %    c>=0
    [~, n]=size(A);
    f=ones (2*n,1);
    options = optimoptions(@linprog , 'Algorithm', 'dual-simplex', 'Display', 'none');
    c= linprog(f,[],[],[A -A],y, zeros (2*n,1),[],[], options );
    x_rs= c(1:n)-c( (n+1):  end);
end