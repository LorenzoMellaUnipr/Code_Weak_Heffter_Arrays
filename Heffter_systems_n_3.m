function H = Heffter_systems_n_3(n,k,t)



v = 2*n*k+t;      % Dimension of the group
Sym = 1:v/2;      % Symbols of an half set
% Minus the subgroup of size t
aux = find(mod(Sym,v/t)==0);
Sym(aux) = [];

Triples = zero_sum_triples(Sym,v); % Zero-sum triples in Sym

% Without loss of generality, we assume that the first row and the first
% column contain the element 1 (or -1)
aux1 = Triples(:,1);
pos = find(aux1==1);
A1 = Triples(pos,:);
pos = find(aux1~=1);
A2 = Triples(pos,:);
A3 = A2;

% When two zero sum triples of A2 are compatibles?
A_int = zeros(size(A2));
for i = 1:size(A2,1)
  for j = i+1:size(A2,1)
    if length(intersect(A2(i,:), A2(j,:)))==0
      A_int(i,j) = 1;
    endif
  endfor
endfor
A_int = A_int+A_int';



found = 0;

noniso = 0;
database = [];
for i1 = 1:size(A1,1)
  b1 = A1(i1,:);                  % First subset of Heffter system
  for i2 = 1:size(A2,1)
    b2 = A2(i2,:);                % Second subset of Heffter system
    G = [b1, b2];
    index2 = find(A_int(i2,:));   % search the third subset between
                                  % the compatible ones
    if length(unique(G)) ==length(G)
      for i3 = 1:size(A3(index2,:),1)
        b3 = A3(index2(i3),:);    % Third subset of Heffter system
        G = [b1, b2,b3];
        index3 = intersect(index2,find(A_int(index2(i3),:)));
        if length(unique(G)) ==length(G)   % G is an Heffter system
          G = [b1; b2;b3];
          found = found+1;
          new_Heffter_System = true;
          if noniso>0      % Is this a new Heffter system, or is it an old one?
            for ijk = 1:length(database)
              Old_Heffter = database{ijk};
              % Check if every row contains the same elements:
              for row_index = 1:size(G,1)
                if max(abs(sort(G(row_index,:)) - sort(Old_Heffter(row_index,:))))==0
                  new_Heffter_System = false;
                endif
              endfor
            endfor
            if (new_Heffter_System == true)
              noniso = noniso+1;
              database{noniso} = G;
            endif
          else
            noniso = noniso+1;
            database{noniso} = G;
          endif
        endif
      endfor
    endif
  endfor
endfor

disp('Heffter systems for these parameters:')
database % These are all the Heffter systems on the set of
         % symbols Sym



% Can we find two Heffter Systems inside of database that are
% orthogonal?

mm = length(database);
num_orthogonal = 0;
H = [];
for i = 1:mm
 A1 = database{i};      % Fix one Heffter system
 for j = i+1:mm
  A2 = database{j};     % And the second one
  orthogonal = true;
  for k1 = 1:size(A1,1)  % And now check if they are orthogonal
   for k2 = 1:size(A2,1)
    if length(intersect(A1(k1,:),A2(k2,:)))>1
     orthogonal = false;
    endif
   endfor
  endfor
  if orthogonal % If they are orthogonal, construct the array
    Heff_array = isHeffter(A1,A2);
    % Before adding the array to the database, check if it is already there
    isnew = true;
    Heff_array1 = Heff_array(:,1);
    [~,idx1] = sort(Heff_array1);
    Heff_array = Heff_array(idx1,:);

    for kk = 1:length(H)
      C = H{kk};
      C1= C(:,1); % As before, check up to a permutation of the rows
      if max(abs(sort(Heff_array1) - sort(C1))) == 0
        [~,idx2] = sort(C1);
        C = C(idx2,:);
      endif

      if norm(C - Heff_array)==0
        isnew = false;
      endif
    endfor
    if isnew
    num_orthogonal = num_orthogonal + 1;
    H{num_orthogonal} = Heff_array;
    endif
  endif
 endfor
endfor
