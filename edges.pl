/* Author: VHarisop
*
* =================
* EDGES.PL contains the implementation for extracting edges
* from a provided adjacency matrix in the form of
* [  [1, 0, 1, 1],
*    [0, 1, 0, 1],
*    . . .,
* ]
* where 1 corresponds to an edge. 
* The predicate rowEdges produces the adjacency list for a certain
* row (vertex), and could be useful for constructing per-vertex adjacency
* lists. 
*
* Working example (assuming a directed graph):
*
* ?- findEdges([ [0,1,0], [1, 1, 0], [0,0,1] ], Result).
* Result = [(1, 2), (2, 1), (2, 2), (3, 3)].
*
*/

findEdges(Matrix, Result) :-
	allEdges(Matrix, 1, [], Res),
	flatten(Res, Inter),
	reverse(Inter, Result).

allEdges([H|T], Row, Acc, Z) :-
	NewRow is Row + 1,
	rowEdges(Row, H, Res),
	(Res = [] -> allEdges(T, NewRow, Acc, Z);
	 allEdges(T, NewRow, [Res | Acc], Z)).
allEdges([], _, Acc, Acc).

rowEdges(Row, NList, Result) :- 
	edges(NList, 1, Row, [], Result).

edges([H|T], Column, From, Acc, Z) :- 
	NewColumn is Column + 1,
	(H =:= 1 -> 
	edges(T, NewColumn, From, [(From, Column)|Acc], Z) ; 
	edges(T, NewColumn, From, Acc, Z)).
edges([], _, _, Acc, Acc).
