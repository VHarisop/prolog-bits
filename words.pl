/* Author: VHarisop <https://github.com/VHarisop>
*
*  =============================================
*  WORDS.PL reads from a file or a stream into
*  atom codes, and then creates a multilist Pd.
*  Pd has elements in the forms (Ls, Type) where
*  Type can be:
*   - word (indicator of words) or 
*   - rest (for other purposes)
*  Ls: a code list that contains a word if Type
*  has been set accordingly
*
*  Useful for word parsing/filtering, text splitting etc.
*/

/* ?- open('example.txt', read, R), read_stream_to_codes(R, C), parseSentence(C, Pd) */

parseSentence(L, Pd) :- parseSentence(L, [], Aux), reverse(Aux, Pd).

parseSentence([], Acc, Acc).
parseSentence(L, Acc, Tr) :- makeword(L, W, Rest), parseSentence(Rest, [(W, word)|Acc], Tr).
parseSentence(L, Acc, Tr) :- makerest(L, R, Rest), parseSentence(Rest, [(R, rest)|Acc], Tr).

makeword(L, W, Rest) :- L = [H|_], char_type(H, alpha), wlist(L, [], Aux, Rest), reverse(Aux, W).
makerest(L, R, Rest) :- L = [H|_], \+ char_type(H, alpha), rlist(L, [], Aux, Rest), reverse(Aux, R).

rlist([], Acc, Acc, []).
rlist([H|T], Acc, Acc, [H|T]) :- char_type(H, alpha).
rlist([H|T], Acc, R, Rest) :- \+ char_type(H, alpha), rlist(T, [H|Acc], R, Rest).

wlist([], Acc, Acc, []).
wlist([H|T], Acc, Acc, [H|T]) :- \+ char_type(H, alpha).
wlist([H|T], Acc, R, Rest) :- char_type(H, alpha), wlist(T, [H|Acc], R, Rest).
