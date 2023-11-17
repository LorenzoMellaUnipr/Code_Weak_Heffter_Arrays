Implemented for Gnu Octave / Matlab

Main file: main_Heffter_Systems.m

To download tbe folder as a .zip, click on the  <> Code  button, and then select Download Zip. After extracting the code, 
it is possible to run the main file main_Heffter_Systems.m


At the beginning of the code of the main it is possible to choose:
	- the dimension n of the array, that can be either 3 or 4;
	- the dimension t of the subgroup of Z_2nk+t
The number of filled cells in each row and column k is set to be 3, and should not be changed.

The code finds all the orthogonal Heffter systems on the set of symbols [1,2nk+t]\J, where J is the 
subgroup of Z_2nk+t of order t. In particular, it computes for each pair of orthogonal systems one possible
representation of the resulting weak Heffter array, that is stored in absolute value in the structure H.
At the moment, the code does not perfectly  distinguish whenever the resulting array is classical
or strictly weak. In any case, given the absolute value of the weak Heffter array, that is H{i} 
(line 38, main_Heffter_Systems.m ), it tries to assign the signs in order to construct the classical Heffter array.
If it succeeds, the classical Heffter array is stored in the structure classical_heffter (line 41, main_Heffter_Systems.m),
otherwise it is stored in possibly_strict_heffter (line 43, main_Heffter_Systems.m).

The output of the code is given by the two structures classical_heffter and possibly_strict_heffter, 
that to summarize are:
	- classical_heffter : a subset of the classical Heffter arrays on the symbol set [1,2nk+t]\J;
	- possibly_strict_heffter: a subset of the weak Heffter arrays on the symbol set [1,2nk+t]\J.
The union of these two structures gives all the possible weak Heffter arrays on the symbol set [1,2nk+t]\J,
where various techniques were employed to avoid as many repetition as possible of the same array.

To verify whether there exists a strictly weak Heffter array, at the moment it is necessary to verify 
by hand if it is possible to assign the signs of the arrays of possibly_strict_heffter. For the set of 
parameters of interest there are not that many arrays in possibly_strict_heffter, so this step
could be easily performed.
