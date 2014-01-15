% -*- texinfo -*-
% @deftypefn {Function File} {[@var{y}] = } task3_real(@var{a}, @var{g}, @var{mu}, @var{xs}, @var{ts} )
% @end deftypefn
%
% @end table
% ts should be vertical
function [y] = task3_real_slow( a, g, mu, xs, ts )
    N = length( xs );
    M = length( ts );

    y = zeros( M, N );
    for i = 1:M
        for j = 1:N
            if xs(j) >= (a * ts(i))
                y(i, j) = g( xs(j) - a * ts(i) );
            else
                y(i, j) = mu( ts(i) - xs(j)/a);
            endif
        endfor
    endfor
endfunction;
