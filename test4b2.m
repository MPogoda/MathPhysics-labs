function test4b2()
    v = 2;
    mu = 0.2;
    k = @(x, t) 2 .* x;
    u0 = @(x) e .^(-x);
    g0 = @(t) e .^(0.2 .* t);
    g1 = @(t) e .^(0.2 .* t .- 1);
    L = 1;
    T = 1;
    h = 0.1;
    tau = 0.01;
    xs = 0:h:L;
    ts = 0:tau:T;

    u = @(x, t) e .^( -x .+ 0.2 .*t);

    figure(1)
    [zs] = task4b( v, mu, k, u0, g0, g1, xs, ts );
    mesh( xs, ts, zs );
pause;

    [xs,ts] = meshgrid( xs, ts);
    zs1 = u(xs, ts);
    mesh( xs, ts, zs1 );

    max( max( abs( zs1 -zs ) ) )
endfunction
