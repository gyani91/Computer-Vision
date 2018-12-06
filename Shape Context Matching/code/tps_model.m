function [w_x w_y E] = tps_model(X,Y,lambda)
    % This function computes the weights w_i and a_1, a_x anf a_y for both
    % f_x and f_y.
    %
    % INPUTS:
    % points in the template shape, X
    % corresponding points in the target shape, Y
    % regularization parameter, lambda
    %
    % OUTPUTS : 
    % parameters (wi and ai), w_x and w_y
    % total bending energy, E
    
    N = size(X,1);
    t = dist2(X,X);
    U = t.*log(t);
    U(isnan(U)) = 0;
    P = [ones(N,1), X];
    A = [U+lambda*eye(N), P; P', zeros(3,3)];
    v_x = Y(:,1) ; v_y = Y(:,2);
    b_x = [v_x;0;0;0] ; b_y = [v_y;0;0;0];

    w_x = A\b_x;
    w_y = A\b_y;

    E = w_x(1:N)'*U*w_x(1:N) + w_y(1:N)'*U*w_y(1:N);
end

