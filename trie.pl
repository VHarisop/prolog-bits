% make_trie(+WordList, -Trie).
make_trie([Word|WordList], Trie) :-
	make_trielist(Word, Word, WordTrie),
	make_trie(WordList, [WordTrie], Trie).

make_trie([], T, T) :- !.
make_trie([Word|WordList], Trie, FinalTrie) :- 
	insert_word_in_trie(Word, Word, Trie, NewTrie),
	make_trie(WordList, NewTrie, FinalTrie).

% make_trielist(+Word, +Leaf, -WordTrie).
make_trielist(Word, Leaf, WordTrie) :- 
	atom_chars(Word, CharList),
	make_trielist_aux(CharList, Leaf, WordTrie).

make_trielist_aux([X], Leaf, [X, Leaf]) :- !.
make_trielist_aux([X|L], Leaf, [X|[LS]]) :- 
	make_trielist_aux(L, Leaf, LS).

% insert_word_in_trie(+Word, +Leaf, +Trie, -NewTrie).
insert_word_in_trie(Word, Leaf, Trie, NewTrie) :- 
	make_trielist(Word, Leaf, WordTrie),
	insert_wordtrie_in_trie(WordTrie, Trie, NewTrie).

insert_wordtrie_in_trie([H|[T]], 
	[[H, Leaf | BT] | LT], [[H, Leaf | NB] | LT]) :-
	atom(Leaf), 
	!, 
	insert_wordtrie_in_trie(T, BT, NB).

insert_wordtrie_in_trie([H|[T]], [[H|BT] | LT], [[H | NB] | LT]) :-
	!, 
	insert_wordtrie_in_trie(T, BT, NB).

insert_wordtrie_in_trie([H|T], [[HT | BT] | LT], [[HT | BT] | NB]) :-
	!,
	insert_wordtrie_in_trie([H|T], LT, NB).

insert_wordtrie_in_trie(RW, RT, NB) :- 
	append(RT, [RW], NB),
	!.

% search_trie(+Trie, +Word): searches a trie for a given word
search_trie(Trie, Word) :- 
	atom_chars(Word, Chars), 
	search_trie(Trie, Chars, Word), !.

% search_trie/3 finds matching letters until either
% the trie is depleted or the word is found.
search_trie([X], [], X) :- !.
search_trie([T | _], [L | Ls], X) :-
	T = [L | Rest], search_trie(Rest, Ls, X), !.
search_trie([_ | Trie], [L | Ls], X) :-
	search_trie(Trie, [L | Ls], X).
