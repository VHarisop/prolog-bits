prolog-bits
===========

Prolog code snippets to make your life easier.

words.pl
===========

For one of my university courses, I had to do lexical analysis on sentences in order to perform corrections.
This involved splitting a text file (more generally, a stream) to words-for-correction while maintaining other
things such as punctuation, digits etc.
The predicate parseSentence/2 accepts a list of atom codes and performs this split, creating a list with tuples
where the presence of a word is indicated by the 2nd element of the tuple.
