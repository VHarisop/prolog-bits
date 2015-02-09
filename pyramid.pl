pyramid(N) :- pyramid(N, N-1).

pyramid(0, _) :- nl, !.
pyramid(N, K) :- 
	N1 is N-1, Q is 2 * (K - N1) + 1,
	gaps(N1, ' '), gaps(Q, '*'), gaps(N1, ' '),
	nl, pyramid(N1, K).

gaps(Range, Char) :- foreach(between(1, Range, _), write(Char)).
