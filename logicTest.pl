%Tests for the logic program
?- search(7, 3, 10, 1, 2, Res).
Res = 7.

?- search(1, 3, 10, 1, 2, Res).
Res = 7.

?- search(1, 1, 2, 9, 3, Res).
Res = 9.

?- search(1, 1, 2, 4, 5 Res).
Res = 11.

?- search(1, 2, 3, 4, 5, Res).
Res = 1.

