function [B,G] = test_strictly_weak1(A,v)
% tries to construct a classical Heffter array starting from A;
% the output is the result of this guess: if the array B is an
% all-one matrix, then the array G is a classical Heffter array.


% we give an assigned value (+1 or -1) to each entry of the array A when
% reading the elements along the rows, or along the columns, in order to have
% zero sum.


assigned = zeros(size(A,1),size(A,2));
 n = size(A,1);
 m = size(A,2);
 for i = 1:n
  [val,pos] = max(A(i,:)); % Finds the element whose sign has to change
  non_empty_positions = find(A(i,:));
  assigned_row(i,non_empty_positions) = 1;
  if mod(sum(A(i,:)),v)~= 0
   assigned_row(i,pos) = -1; % and change it (after checking that it is necessary
                             % to have a+b = c )
  endif
 endfor
A = A';
 for i = 1:m
  [val,pos] = max(A(i,:));
  non_empty_positions = find(A(i,:));
  assigned_col(i,non_empty_positions) = 1;
  if mod(sum(A(i,:)),v)~= 0
   assigned_col(i,pos) = -1;
  endif
 endfor

 assigned_col = assigned_col';
 A = A';
 % ... and do the same for the columns
 for i =1:m
  for j = 1:n
   if assigned_row(i,j) ~=assigned_col(i,j) % if two elements have different signs,
                                            % change the signs in the whole column
    assigned_col(:,j) = -assigned_col(:,j);
   endif
  endfor
 endfor

 B = (A.*assigned_row)==(A.*assigned_col);
aux1 = sum(B.*(A~=0),2);
aux2 = sum(B,1);
g1 = find(aux1==0);
g2 = find(aux2==0);
for j = 1:length(g1)
 assigned_row(g1(j),:) = -assigned_row(g1(j),:);
endfor
B = (A.*assigned_row)==(A.*assigned_col);
aux2 = sum(B.*(A~=0),2);
g2 = find(aux2==0);
for j = 1:length(g2)
 assigned_row(:,g2(j)) = -assigned_row(:,g2(j));
endfor

% if the two arrays are still different, then the array is not a classical Heffter
B = (A.*assigned_row)==(A.*assigned_col);
G = (A.*assigned_row);
