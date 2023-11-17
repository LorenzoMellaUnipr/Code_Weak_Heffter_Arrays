function Triples= zero_sum_triples(A,v)

 % find the zero sum triples in the set A, modulo v

 A1 = A;
 A2 = [-A];
 A3 = A-v;
Triples=  [];
for i = 1:length(A)
  el1 = A(i);
  for j = i+1:length(A)
   el2 = A(j);
   t = -(el1 + el2);
   if ~isempty(find(A2 == t))
      pos =   find(A2 == t);
      Triples = [Triples; [el1 el2 A1(pos)] ];
   elseif ~isempty(find(A3==t))
      pos =   find(A3 == t);
      Triples = [Triples; [el1 el2 A1(pos)] ];
   endif
  endfor
endfor
