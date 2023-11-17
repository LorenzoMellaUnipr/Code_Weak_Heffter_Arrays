function H = isHeffter(A,B)
     % Constructs the array having the Heffter systems A and B
     % as rows and columns
 n = size(A,1);

 H = zeros(n);
 G = sort(A(:));
 for i = 1:length(G)
  posA = find(A==G(i));
  posB = find(B==G(i));
  rigA = mod(posA,n);
  rigB = mod(posB,n);
  if rigA==0
   rigA=n;
  endif
  if rigB ==0
   rigB=n;
  endif
  H(rigA,rigB) = G(i);
 endfor

