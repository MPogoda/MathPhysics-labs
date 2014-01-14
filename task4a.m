% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} = } task2a (@var{k_x}, @var{v_x}, @var{q_x}, @var{f_x}, @var{mu_0}, @var{mu_1}, @var{xs} )
% @end deftypefn
%
% @end table
% Стойкая при k_h \in [0; 1]
function [y] = task4a(v, mu, a, xs, ts )
    h = xs(2) - xs(1);
    tau = ts(2) - ts(1);

    M = length( ts );
    N = length( xs );

    y = zeros( M, N);
    y( :, 1 ) = a;
    #y( 1, : ) = 0;

    k_h = v * tau / h;
    k_p = 2 * mu * tau / (h^2);

    for j = 1:M-1
        for k = 2:N-1
            y( j+1, k ) = y( j, k ) - 0.5*k_h*( y(j, k+1) - y(j, k-1)) + 0.5*k_p*( y(j, k+1)-2*y(j, k)+y(j, k-1));
        endfor
    endfor
endfunction
