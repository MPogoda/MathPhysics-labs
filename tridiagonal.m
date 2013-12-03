% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} = } tridiagonal( @var{As}, @var{Bs}, @var{Ys}, @var{Fs} )
% Solve linear system that has tridiagonal form.
%
% Arguements:
% @table @samp
% @item @var{As}
% Items from above the diagonal.
%
% @item @var{Bs}
% Items from below the diagonal.
%
% @item @var{Cs}
% Items from diagonal.
%
% @item @var{Fs}
% Vector of free values.
%
% @end table
%
% Returns:
% @table @samp
%
% @item @var{y}
% Vector of y coordinates.
%
% @end table
function [y] = tridiagonal( As, Bs, Cs, Fs )
    N = length( As );

    a = zeros(1,N);
    b = zeros(1,N);
    a(1) = -As(1)/Cs(1);
    b(1) = Fs(1)/Cs(1);
    for i = 1:(N-1)
        a(i+1) = -As(i) / (Cs(i) + Bs(i)*a(i));
        b(i+1) = (-Bs(i)*b(i)+Fs(i)) / (Cs(i)+Bs(i)*a(i));
    endfor;

    y = zeros(1,N);
    y(N) = (-Bs(N)*b(N)+Fs(N)) / (Cs(N)+Bs(N)*a(N));

    for i=N-1:-1:1
        y(i) = a(i+1)*y(i+1)+b(i+1);
    endfor;
endfunction;
