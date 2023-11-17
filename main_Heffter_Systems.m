% This code constructs the Relative Heffter systems with
% respect to the parameters specified below.
% Moreover, it constructs the array containing the two orthogonal
% Heffter systems. Finally, it also tries to construct the
% classical heffters, in order to reduce the possible spectrum
% of the strictly weak Heffter arrays.

% The output of the code is a subset of the classical Heffters
% that can be constructed with the set of parameters, and
% the set of stricly weak Heffter arrays (if they exists) with
% a possibly empty subset of the remaining classical Heffter arrays.

clear all
close all
clc



n = 4;            % Dimension of the array
                  % (implemented for n in {3,4})
t = 6;            % Dimension of the subgroup

k = 3;            % Number of filled cells (the current implementation
                  % works exclusively for k = 3)
if n==3
  H = Heffter_systems_n_3(n,k,t);

elseif n==4
  H = Heffter_systems_n_4(n,k,t);

endif

jj = 0;
  j = 0;
  classical_heffter = [];
  possibly_strict_heffter = [];
  for i = 1:length(H)
    [A,B] = test_strictly_weak1(H{i},2*n*k+t);
    if norm(A - ones(n))==0
      jj = jj+1;
      classical_heffter{jj} = B;
    else
      j = j+1;
      possibly_strict_heffter{j} = abs(B);
    endif
  endfor

  classical_heffter
  possibly_strict_heffter
