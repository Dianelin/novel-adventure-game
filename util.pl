
append([],X,X).
append([H|T1],X,[H|T2]):-append(T1,X,T2).

remove_list([],X,X).
remove_list([H|T1],X,T2):-remove(H,X,T3), remove_list(T1,T3,T2).

remove(ITEM,[ITEM|T],T).
remove(ITEM,[H|T1],[H|T2]):-dif(ITEM,H), remove(ITEM,T1,T2).
remove(_,List,List).

list_reverse(List, NewList):- list_reverse(List, [], NewList).
list_reverse([], X, X).
list_reverse([H|T], X, NewList):- list_reverse(T, [H|X], NewList).


output([]):-nl,!.
output([H|T]):- write(H),nl,output(T).

output_list([]):-write("."),nl,!.
output_list([H|T]):-write(H),write(" "),output_list(T).

			


