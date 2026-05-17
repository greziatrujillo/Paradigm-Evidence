%Author: Grezia Trujillo
%Date: 22 May 2026
%Project: Logic paradigm solution to Sun and Moon problem E
%Purpose of the project: Sun and Moon problem will be solved using
%logic paradigm to compare with the functional paradigm solution

%Check for alignment
align(X, D, Y):-
    0 is (X + D) mod Y.

%Verify eclipse when both align
eclipse(X, Ds, Ys, Dm, Ym):-
    align(X, Ds, Ys),
    align(X, Dm, Ym).

%Recursively search for X
%base case for when the input x is the result
search(X, Ds, Ys, Dm, Ym, X):-
    eclipse(X, Ds, Ys, Dm, Ym).

%If input x is not correct, recursively search for correct x
search(X, Ds, Ys, Dm, Ym, Res):-
    X1 is X + 1,
    search(X1, Ds, Ys, Dm, Ym, Res).