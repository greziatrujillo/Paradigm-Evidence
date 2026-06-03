%Author: Grezia Trujillo
%Date: 04 june 2026
%Project: Logic solution to shortest path in binary matrix
%Purpose of the project: Pathfinding problem will be solved using
%DFS to compare with the functional (BFS) solution. 

%establish grid cell(row, column, value)
cell(0, 0, 0).
cell(0, 1, 0).
cell(0, 2, 0).
cell(1, 0, 1).
cell(1, 1, 1).
cell(1, 2, 0).
cell(2, 0, 1).
cell(2, 1, 1).
cell(2, 2, 0).

%establish 8 directions
dir(-1, -1).
dir(-1, 0).
dir(-1, 1).
dir(0, -1).
dir(1, -1).
dir(1, 0).
dir(1, 1).
dir(0, 1).

%relationship for valid positions
valid_pos(R,C):-
    cell(R,C,Val),
    Val \= 1.

%relationship of neighbors
neighbors(pos(R, C), pos(NR, NC)):-
    dir(Dr,Dc),
    NR is R + Dr,
    NC is C + Dc,
    valid_pos(NR,NC).

%-------------------------------------
%explore possible paths
%base case: current cell is destination
path(Dest,Dest,_,[Dest]).

%continue to recursively search
path(Curr,Dest,Vis,[Curr|Path]):-
    neighbors(Curr,NewCurr),
    \+ member(NewCurr,Vis),
    path(NewCurr,Dest,[NewCurr|Vis],Path).

%find the actual distance
shortest_path(Orig,Dest,Path,Dist) :-
    path(Orig,Dest,[Orig],Path),
    length(Path,Dist).