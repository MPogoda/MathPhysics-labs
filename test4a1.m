function test4a1()
    v = 1;
    mu = 0.05;
    a = 1;
    L = 1;
    T = 1;
    h = 0.1;
    tau = 0.1;
    xs = 0:h:L;
    ts = 0:tau:T;

    [zs] = task4a( v, mu, a, xs, ts);
    mesh( xs, ts, zs );
    pause;
    [zs2] = task4_real_a( v, mu, a, xs, ts);
    mesh( xs, ts, zs2 );
    max(max(zs-zs2))
endfunction
