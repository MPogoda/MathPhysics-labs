function test4a3()
    v = 3;
    mu = 0.05;
    a = 0.2;
    L = 1;
    T = 1;
    h = 0.1;
    tau = 0.01;
    xs = 0:h:L;
    ts = 0:tau:T;

    figure(1)
    [zs] = task4a( v, mu, a, xs, ts);
    mesh( xs, ts, zs );
    figure(2)
    [zs2] = task4_real_a( v, mu, a, xs, ts);
    mesh( xs, ts, zs2 );
    max(max(zs-zs2))
endfunction
