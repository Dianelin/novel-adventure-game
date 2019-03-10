:- use_module(library(time)).
:-consult(util).
:-consult(plot).
:-consult(parse_input).

:-dynamic
door/3,
position/2,
locate/1,
inventory/1,
hp/1,
fp/1,
total_weight/1,
game_over/1,
on_chair/1,
not_pickable/1,
contain/2.

inventory([]).
locate(warehouse).
hp(100).
fp(100).
total_weight(0).
game_over(false).

on_chair(false).


% rooms
room(warehouse).
room('machine room').
room('frozen room').
room('choose room').

% doors
door(warehouse, 'machine room', unlocked).
door('machine room', 'frozen room', locked).
door('frozen room','choose room', locked).
door('choose room','exit',locked).

% positions, objects, characters
position(object('walkman','A [walkman] is on the ground.'), warehouse).
position(object('chair','A small wooden [chair] is in the middle of the room'), 'machine room').
position(object('doll','On the chair sits a [doll] in a black suit.'), 'machine room').
position(object('paper',"A [paper] was held in the doll's hand."),'machine room').
position(object('pendant lamp','There is a suspended fluorescent [lamp], about a meter long,
embedded in a plastic case, suspended from the ceiling by two wires.'),'machine room').
position(object('iron cage','On the ground placed a locked iron [cage], with an anesthetized golden [monkey] caged in it.'),'machine room').
position(object('golden monkey','An anesthetized golden [monkey] is caged in the iron cage.'),'iron cage').
position(object('cage key','The [key] fall from somewhthe of the lamp.'),'pendant lamp').
position(object('machine','A running machine is placed near the door.  There is a countdown timer at the top of the machine,
 which is set to five minutes and already running. Next to the timer, there is a meter with kilograms on it and the pointer is pointing to zero.'),'machine room').
position(object('newspaper',"A [newspaper] is stuck on the wall."),'frozen room').

position(object('tv',"There are a TV sets against the wall."),'choose room').
position(object('table',"A table is placed in the middle of the room."),'choose room').
position(object('door key',"On the table is a [key]."),'choose room').
position(object('pipe',"On the corner is an upright pipe, about a meter out of the ground."),'choose room').

contain('iron cage','golden monkey').

weight(doll,1.5).
weight(newspaper,0.1).
weight('pendant lamp',8).
weight(chair,5).
weight('iron cage', 7.5).
weight('golden monkey',5).
weight(walkman,0.5).

not_pickable(machine).
not_pickable('pendant lamp').
not_pickable(tv).
not_pickable(table).
not_pickable('pipe').

pickable(Object):-not(not_pickable(Object)),position(object(Object,_),_) .
 
		  
play:-start_info,
	  help_info,
	  loop.

loop:-repeat,
	  request_input(InputList),
	  parse_input(InputList,CommandList),
	  execute(CommandList),
	  end_condition(CommandList),!.

execute([end]):- !.
execute(OutputList):- Command =.. OutputList, call(Command), !.

end_condition([end]):-output(['Successfully exit the Thriller Paradise!']),!.
end_condition(_):-game_over(true),output(['Game over!']),!.
end_condition(_):-hp(HP),HP==0,output(["Your health point is 0.","Game over!"]),!.
end_condition(_):-fp(FP),FP==0,output(["You can't move and finally died because your physical point is 0.","Game over!"]),!.

show_help:-help_info.

hint:-locate(Room),hint_info(Room).

show_inventory:-inventory(ObjectList),!,write(ObjectList),nl.

show_state:-hp(HP),fp(FP),write("Current HP: "),write(HP),nl,
			write("Current FP: "),write(FP),nl.

look:-locate(Room),info(Room),!,position(object(_,Info),Room),output([Info]),fail.
look:-output(["Emmmmm... It seems there're not anything useful!"]).

inspect('golden monkey'):-locate('machine room'),
						  contain('iron cage','golden monkey'),
						  output(["The monkey is locked in the iron cage... "]),!.
						  

inspect('golden monkey'):-locate('choose room'),
						output(["The monkey waked and when he opened his mouse, you got a new key.",
						"[You used the key to open the door. You survived, as well as the monkey.]",
						"[Happy ending!]"]),
						retract(game_over(false)),asserta(game_over(true)),!.
		  
inspect(Object):-inventory(List),
				member(Object,List),
				info(Object), !.


inspect(Object):-locate(Room),
				position(object(Object,_),Room),
				info(Object), !.

inspect(Object):-output_list(["It seems the",Object,"is not in this space..."]),!.		  

get('pendant lamp'):-on_chair(false),output(["Emmmm... It's too high too get the lamp..."]),!.
get('pendant lamp'):-on_chair(true),
					fp(FP),
					NFP is FP-20,
					retract(fp(FP)),
					asserta(fp(NFP)),
					retract(position(object('pendant lamp',_),'machine room')),
					asserta(position(object('pendant lamp','The lamp is on the ground.'),'machine room')),
					retract(not_pickable('pendant lamp')),
					retract(on_chair(true)),
					retract(position(object('cage key',Info),_)),
					asserta(position(object('cage key',Info),'machine room')),
					output(["You jumped and pull the lamp down...",
					"When you pull the lamp, a key hidden in the lamp fallen into the ground.",
					"The lamp is on the ground now so that the room fall into darkness...",
					"You are now on the ground."]),
					show_state,!.
				 

get('machine'):-output(["What are you thinking about? The machine is fixed to the ground!"]),!.

get('golden monkey'):-contain('iron cage','golden monkey'),
					  output(["The monkey is caged so you can't get it."]),!.

get(key):-locate('machine room'),get('cage key'),!.
get(key):-locate('choose room'),get('door key'),!.
get(key):-output(["There is no key avaliable."]),!.

get(Object):-locate(Room),
			position(object(Object,Info),Room),
			pickable(Object),
			inventory(Oldlist),
			append([Object],Oldlist,Newlist),
			retract(inventory(Oldlist)),
			asserta(inventory(Newlist)),
			retract(position(object(Object,Info),Room)),
			asserta(position(object(Object,Info),none)),
			output_list([Object,"is now in your inventory."]),!.

get(Object):-locate(Room),
			 position(object(Object,_),Room),
			 output_list(["You can't get",Object,".","It's fixed or too heavy."]),!.

get(Object):-output_list(["The",Object,"doesn't exist."]),!.

put(Object):-inventory(Oldlist),
			member(Object,Oldlist),
			remove(Object,Oldlist,Newlist),
			retract(inventory(Oldlist)),
			asserta(inventory(Newlist)),
			locate(Room),
			position(object(Object,Info),none),
			retract(position(object(Object,Info),none)),
			asserta(position(object(Object,Info),Room)),
			output_list([Object,"is now not in your inventory."]),!.
			
put(Object):-output_list(["The",Object,"is not in your inventory!"]),!.

get_out:-locate(Room),
		door(Room,NextRoom,unlocked),!,
		retract(locate(Room)),
		asserta(locate(NextRoom)),
		room_entrance_action(NextRoom),
		look,!.

get_out:-locate(Room),
		door(Room,_,locked),
		output(["Oh! The door is locked!"]),!.

get_out:-output(["There's no way to get out!"]),!.

room_entrance_action('machine room'):-timer,output(["You are now in the machine room."]).

room_entrance_action('frozen room'):-frozen_room_plot, output(["You are now in a frozen room."]).

room_entrance_action('choose room'):-choose_room_plot, output(["You are now in the choose room."]).

timer:-alarm(300, time_out, _, [remove(true)]).

time_out:-locate('machine room'),
		  door('machine room', 'frozen room', locked),
		  output(["Five minutes used up and the machine stoped running...",
		  "You have no way to get out so that finally, you died because of the toxin...",
		  "Bad ending..."]),
		  retract(game_over(false)),
		  asserta(game_over(true)),
		  sleep(6),
		  halt.


play(walkman):- locate(warehouse),
			    position(object(walkman,_),warehouse),
				warehouse_plot,!.
				
play(walkman):- locate(warehouse),
				inventory(List),
				member(walkman,List),
				warehouse_plot,!.

play(doll):-locate('machine room'),
			position(object(doll,_),'machine room'),
			machine_room_plot,!.
			
play(doll):-inventory(List),
			member(doll,List),
			machine_room_plot,!.
			
stand(chair):-locate('machine room'),
			  (position(object('chair',_), 'machine room');inventory(List),member(chair,List)),
			  retract(on_chair(false)),
			  asserta(on_chair(true)),
			  output(["[You are now standing on the chair.]"]),!.

jump:-locate('machine room'),on_chair(true),get('pendant lamp'),!.

jump:-locate('machine room'),on_chair(false),output(["You jumped but still can't get the lamp..."]),!.

jump:-output(["You jumped but maked no sense."]),!.
						  

throw_to(key):-locate('choose room'),
			   inventory(List),
			   member(key,List),
			   put(key),
			   retract(position(object(key,_),_)),
			   output(["The doll's voice sounded:'Admirable choice, Arthur. Don't worry. Death is the soul's exaltation.'"]),
			   final_branch,!.

throw_to('iron cage'):-locate('machine room'),
					   inventory(List),
					   member('iron cage',List),
					   contain('iron cage','golden monkey'),
					   crash('iron cage'),
					   crash('golden monkey'),
					   output(["The iron cage and the monkey were both crashed."]),
					   machine_condition,!.
					   
throw_to('iron cage'):-locate('machine room'),
					   inventory(List),
					   member('iron cage',List),
					   crash('iron cage'),
					   machine_condition,!.			

				
throw_to(Object):-locate('machine room'),
				inventory(List),
				member(Object,List),
				pickable(Object),
				crash(Object),
				machine_condition,!.
				
throw_to(Object):-locate('machine room'),
				 not_pickable(Object),
				 output_list(["The",Object,"is fixed and you can't throw it to the machine."]),!.
				 

throw_to(_):-output(["You can't throw it! You must get it first and then throw it!"]),!.

				
crash(Object):- weight(Object,W),
				total_weight(TW),
				NW is W+TW,
				retract(total_weight(TW)),
				asserta(total_weight(NW)),
				retract(position(object(Object,_),_)),
				inventory(List),
				remove(Object,List,Newlist),
				retract(inventory(List)),
				asserta(inventory(Newlist)),!.
				

machine_condition:-total_weight(TW),
				   TW>=15,
				   retract(door('machine room', 'frozen room', locked)),
				   asserta(door('machine room', 'frozen room', unlocked)),
				   output_list(["Current weight is",TW]),
				   output(["The door automaticlly opened.","You can use 'get out' to move to the next room!"]),!.
				   
machine_condition:-total_weight(TW),
				   output_list(["Current weight is",TW]),
				   output(["Not enough... But there's not much time left..."]),!.
				   
open('iron cage'):-inventory(List),
				   member('cage key',List),
				   retract(contain('iron cage',_)),
				   retract(position(object('golden monkey',_),_)),
				   asserta(position(object('golden monkey',"The monkey is now on the ground rather than in the cage."),'machine room')),
				   output(["The cage is unlocked. You can either get the cage or the monkey now."]),!.
				   
open('iron cage'):-output(["You don't have the cage key!"]).

open(door):-locate('choose room'),
			inventory(List),
			member(key,List),
			output(["The doll's voice sounded,'Mean and hypocritical Arthur seager, your soul will never be redeemed...'",
			"[The door opened and you get out. But actually it is a way to death...]","[Bad ending...]"]),
			retract(game_over(false)),asserta(game_over(true)).
open(door):-locate('choose room'),output(["Please get the key first."]).
				   
dig(snow):-hp(HP),fp(FP),
		   NHP is HP-20, NFP is FP-20,
		   retract(hp(HP)),retract(fp(FP)),
		   asserta(hp(NHP)),asserta(fp(NFP)),
		   output(["You digged the snow for a while, but didn't find the paper in this 1/10 region.",
		   "But you got harmed as a result of the frozen environment."]),
		   show_state,!.
				   
fold(newspaper):-locate('frozen room'),
				position(object('newspaper',_),'frozen room'),
				retract(position(object('newspaper',_),'frozen room')),
				asserta(position(object('box',"You fold the newspaper to get a box."),'frozen room')),
				output(["You fold the newspaper to get a box."]),!.
				
fold(newspaper):-locate('frozen room'),
				inventory(List),
				member('newspaper',List),
				retract(position(object('newspaper',_),'frozen room')),
				asserta(position(object('box',"You fold the newspaper to get a box."),none)),
				remove(newspaper,List,Templist),
				append([box],Templist,Newlist),
				retract(inventory(List)),
				asserta(inventory(Newlist)),
				output(["You fold the newspaper to get a box."]),!.

listen_to('FM27.3'):-inventory(List),
					member(walkman,List),
					output(["You turned the walkman to FM27.3.",
					"After about forty seconds of noise, a hoarse voice said, 'nine, five, two, seven'."]),!.				

listen_to('FM27.3'):-output(["You don't have walkman in your inventory!"]),!.

listen_to(_):-output(["There is only noise..."]).					
				   
input_psw('9527'):-locate('frozen room'),
				   retract(door('frozen room','choose room', locked)),
				   asserta(door('frozen room','choose room', unlocked)),
				   output(["Oh! The door opened!","[Hint: You can use 'get out' to go the next room.]"]),!.
				  
input_psw(_):-locate('frozen room'),output(["The door didn't open. Maybe the password is wrong..."]),!.

final_branch:-inventory(List),member('golden monkey',List),
			  output(["But by the way, do you still remember the monkey? He seems to be awake now..."]),!.
			  
final_branch:-output(["But do you really feel at ease? The monkey will never be saved, as well as you...",
			  "[You are stucked in this room and finally died because of the toxin...]"]),
			  retract(game_over(false)),asserta(game_over(true)),!.
						   



