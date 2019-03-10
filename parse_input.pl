
request_input(InputList):-
	ansi_format([bold, fg(cyan)], '[~w@Thriller Paradise]# ', ['dxl']),
	read_line_to_codes(user_input, UserSentenceASCIICodes), 
	format_input(UserSentenceASCIICodes, FilteredList),
	string_to_atom(FilteredList, Atom),
	atomic_list_concat(InputList,' ',Atom).
	
format_input(ASCIIList, FormatedList):-
	format_input(ASCIIList, [], RevFormatedList), !,
	list_reverse(RevFormatedList, FormatedList).

format_input([], X, X):- !.
format_input([H|T], FormatedList, Acc):-
	(H >= 0'a, H =< 0'z;H >= 0'0, H =< 0'9; H == 32),
	format_input(T, [H|FormatedList], Acc).
	
format_input([H|T], FormatedList, Acc):-
	H >= 0'A, H =< 0'Z,
	N is H + 32,
	format_input(T, [N|FormatedList], Acc).
	
format_input([_|T], FormatedList, Acc):-
	format_input(T, FormatedList, Acc).
	

parse_input(InputList,CommandList):-translate(CommandList,InputList,[]),!.
parse_input(_,_):-write("Emmmmm, what are you saying about?"),nl,fail.

translate([Verb,NP]) --> verb(Verb),np(NP).
translate([Verb]) --> verb(Verb).

np(NP)-->det,noun(NP).
np(NP)-->det,noun(NP),prep,det,noun(_).
np(NP)-->det,noun(NP),prep,noun(_).
np(NP)-->noun(NP).

det --> [the].
det --> [a].
det --> [this].
det --> [that].

prep --> [to].
prep --> [into].

verb(show_help)-->[help].
verb(hint)-->[hint].
verb(hint)-->[hints].
verb(hint)-->[show,hint].
verb(look)-->[look].
verb(look)-->[look,around].
verb(inspect)-->[inspect].
verb(inspect)-->[look,into].
verb(show_inventory)-->[inventory].
verb(show_inventory)-->[show,inventory].
verb(show_state)-->[state].
verb(show_state)-->[show,state].
verb(get)-->[get].
verb(get)-->[take].
verb(get)-->[pick].
verb(get)-->[pick,up].
verb(put)-->[put].
verb(put)-->[put,down].
verb(put)-->[take,out].
verb(open)-->[open].
verb(open)-->[unlock].
verb(get_out)-->[get,out].
verb(get_out)-->[go,out].
verb(get_out)-->[move,to].
verb(get_out)-->[go,to].
verb(play)-->[play].
verb(throw_to)-->[throw].
verb(stand)-->[stand].
verb(stand)-->[stand,on].
verb(jump)-->[jump].
verb(fold)-->[fold].

verb(input_psw)-->[input].
verb(input_psw)-->[input,psw].
verb(input_psw)-->[input,password].

verb(dig)-->[dig].
verb(listen_to)-->[listen,to].
verb(listen_to)-->[listen].
verb(end)-->[end].
verb(end)-->[exit].


noun(Object)-->[Object],{position(object(Object, _), _)},!.
noun(Object) --> [Object], {inventory(List), member(Object,List)},!.
noun(PSW)-->[PSW],{atom_number(PSW,_)}.

noun('iron cage')-->[iron,cage].
noun('iron cage')-->[cage].
noun('golden monkey')-->[golden,monkey].
noun('golden monkey')-->[monkey].
noun('pendant lamp')-->[penden, lamp].
noun('pendant lamp')-->[lamp].
noun('cage key')-->[cage,key].
noun('cage key')-->[key].
noun(snow)-->[snow].
noun(room)-->[room].
noun(door)-->[door].
noun('FM27.3')-->[fm273].



