% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} = } task2a (@var{k_x}, @var{v_x}, @var{q_x}, @var{f_x}, @var{mu_0}, @var{mu_1}, @var{xs} )
% @end deftypefn
%
% @end table
% (21) Неявный левый угол
% при k_h < 0 --- абсолютно стойкая
% при K_h > 1 --- условно-стойкая
function [y] = task3b(a, g, mu, xs, ts )
    h = xs(2) - xs(1);
    tau = ts(2) - ts(1);

    M = length( ts );
    N = length( xs );

    y = zeros( M, N);
    y( 1, : ) = g( xs );
    y( :, 1 ) = mu( ts );

    k_h = a * tau / h

    for j = 1:M-1
        for k = 1:N-1
            y( j + 1, k + 1 ) = y( j + 1, k ) - ( y( j + 1, k) - y( j, k) ) / k_h;
        endfor
    endfor
endfunction
