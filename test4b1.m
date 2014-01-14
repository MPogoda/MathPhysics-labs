function test4b1()
    v = -1;
    mu = 0.05;
    k = @(x, t) 1 .+ x;
    #v, mu, k, u0, g0, g1, xs, ts )
    u0 = @(x) e .^(-10 .* x);
    g0 = @(t) e .^(0.05 .*((t.^3)/3) .+ (-1 - 0.05/4) .* t);
    g1 = @(t) e .^(-10 .- t + 0.05 .* ((t.^3)/3) .+(-1-0.05/4).*t);
    L = 1;
    T = 1;
    h = 0.1;
    tau = 0.01;
    xs = 0:h:L;
    ts = 0:tau:T;

    u = @(x, t) e .^( -10 .* x .- t .* x .+ 0.05 .* (t.^3)./3 .+ (-1-0.05/4).*t);

    figure(1)
    [zs] = task4b( v, mu, k, u0, g0, g1, xs, ts );
    mesh( xs, ts, zs );
    figure(2)

    [xs,ts] = meshgrid( xs, ts);
    zs1 = u(xs, ts);
    mesh( xs, ts, zs1 );

    max( max( abs( zs1 - zs ) ) )
endfunction
