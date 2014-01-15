function test53()
    mu = 1;

    function [z] = gf( x, y, t )
        [ys_, xs_, ts_ ] = meshgrid( y, x, t);
        z = cos( xs_ .+ 1 ) .* cos( ys_ .+ 1) .* e .^(-ts_);
    endfunction;

    L1 = 1;
    L2 = 1;
    T = 1;

    u0 = @(x, y) gf( x, y, 0 );
    g0y = @(y, t) gf( 0, y, t );
    g1y = @(y, t) gf( L1, y, t );
    gx0 = @(x, t) gf( x, 0, t );
    gx1 = @(x, t) gf( x, L2, t );

    g = @(x, y, t) gf( x, y,t );

    h1 = 0.1;
    h2 = 0.1;
    tau = 0.1;
    xs = 0:h1:L1;
    ys = 0:h2:L2;
    ts = 0:tau:T;
    zs = gf( xs, ys, ts );

    [zs1] = task5a( mu, u0, gx0, gx1, g0y, g1y, xs, ys, ts);
    [zs2] = task5b( mu, u0, gx0, gx1, g0y, g1y, xs, ys, ts);

    j = 6;

    [ys,xs ] =meshgrid( ys,xs);
    printf("real:")
    figure(1)
    mesh( xs, ys, zs( :, :, j ) );
    pause
    printf("(1):")
    figure(2);
    mesh( xs, ys, zs1( :, :, j ) )
    pause
    printf("(2):")
    figure(3);
    mesh( xs, ys, zs2( :, :, j ) )


    printf("|zs1-zs|= ")
    max(max(max(abs(zs1-zs))))
    printf("|zs2-zs|= ")
    max(max(max(abs(zs2-zs))))

endfunction
