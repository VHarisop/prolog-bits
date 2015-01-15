pyramid(N) :- pyramid(N, N-1).

pyramid(0, _) :- nl, !.
pyramid(N, K) :- 
	N1 is N-1,
	foreach(between(1, N1, _), write(' ')),
	Q is 2 * (K - N1) + 1,
	foreach(between(1, Q, _), write('*')),
	foreach(between(1, N1, _), write(' ')), 
	nl, pyramid(N1, K).

