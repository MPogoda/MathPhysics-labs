function test2_2()
    function ys = one( xs )
        ys = ones(1, length( xs ) );
    endfunction;

    function ys = zero( xs )
        ys = zeros( 1, length( xs ) );
    endfunction;
%function [y] = task2b(k_x, v_x, q_x, f_x, mu_0, mu_1, xs)
%  $ (k(x) * u_x)_x + v(x) * u_x - q(x) * u = -f(x) $

    k = 3;
    k_x = @(xs) k .* one( xs );

    v = 1;
    v_x = @(xs) v .* one( xs );

    q = 4;
    q_x = @(xs) q .* one( xs );

    f_x = @(xs) zero(xs);

    mu_0 = 1;
    mu_1 = 5;

    l = 2;

    x = 0:0.00001:l;
    y = task2_real( k, v, q, mu_0, mu_1, x );

    xa = 0:0.1:l;
    ya = task2a( k_x, v_x, q_x, f_x, mu_0, mu_1, xa );

    xb = 0:0.1:l;
    yb = task2b( k_x, v_x, q_x, f_x, mu_0, mu_1, xb );

    xc = 0:0.1:l;
    yc = task2c( k_x, v_x, q_x, f_x, mu_0, mu_1, xc );

    x0 = 0:0.1:l;
    y0 = task2_real( k, v, q, mu_0, mu_1, x0 );

    plot( x, y, "-; real solution;", xa, ya, "*; 1;", xb, yb, "+; 2;", xc, yc, "^; 3;");

    diff_a = max( abs( diff( y0 - ya ) ) );
    diff_b = max( abs( diff( y0 - yb ) ) );
    diff_c = max( abs( diff( y0 - yc ) ) );

    [ diff_a, diff_b, diff_c ]
endfunction
