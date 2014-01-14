% -*- texinfo -*-
% @deftypefn {Function File} {[@var{y}] = } task3_real(@var{a}, @var{g}, @var{mu}, @var{xs}, @var{ts} )
% @end deftypefn
%
% @end table
% ts should be vertical
function [y] = task4_real_a(v, mu, a, xs, ts )
    N = length( xs );
    M = length( ts );
    [xs, ts] = meshgrid( xs, ts );

    mask = (xs <= (v .* ts ));

    y = a .* mask;
endfunction;
