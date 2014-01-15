function test51()
    mu = @(x, y, t) ones( length(x), length(y), length(t));

    function [z] = gf( x, y, t )
        [xs_, ys_, ts_ ] = meshgrid( x, y, t);
        #printf("TUT");
        #size(ts_)
        #size(xs_)
        #size(ys_)
        z = e .^ ( xs_ .^ 2 .+ ys_ .^ 2 .+ ts_ .^ 2);
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
    tau = 0.0025;
    xs = 0:h1:L1;
    ys = 0:h2:L2;
    ts = 0:tau:T;

    [zs] = task5( mu, u0, gx0, gx1, g0y, g1y, xs, ys, ts);

    zs1 = gf( xs, ys, ts );

size(xs)
size(ys)
size(ts)
    size(zs)
    size(zs1)

size( zs( :, :, 1 ) )
zs( :, :, 30 ) - zs1( :, :, 30 )
#    mesh( xs, ts, zs );
#    figure(2)
#    [zs2] = task4_real_a( v, mu, a, xs, ts);
#    mesh( xs, ts, zs2 );
#    max(max(zs-zs2))
endfunction
