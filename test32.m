function test32()
    a=0.3;
    g= @(x) x.^2;
    mu= @(t) cos(t) .-1;
    L=1;
    T=1;
    h=0.1;
    tau=0.1;
    xs=0:h:L;
    ts=0:tau:T;

    % stable
    zs1 = task3a( a,g,mu,xs,ts);
    % non-stable
    zs2 = task3b( a,g,mu,xs,ts);
    % non-stable
    zs3 = task3c( a,g,mu,xs,ts);
    % stable
    zs4 = task3d( a,g,mu,xs,ts);
    % stable
    zs5 = task3e( a,g,mu,xs,ts);
    zs  = task3_real( a, g, mu, xs, ts );

    [xs,ts] = meshgrid( xs, ts );

    figure(1)
    mesh( xs, ts, zs );
    pause;
    mesh(xs,ts,zs1)
    pause;
    mesh(xs,ts,zs2)
    pause;
    mesh(xs,ts,zs3)
    pause;
    mesh(xs,ts,zs4)
    pause;
    mesh(xs,ts,zs5)


endfunction
