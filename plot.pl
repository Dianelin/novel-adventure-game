start_info:-write('[Welcome to Thriller Paradise!]'),nl,write('[Script loading......]'),nl,nl,
output(["[Your name is Arthur seager.",
"You are a famous photojournalist. You have a good family, good job and good social status.",
"Until one Christmas night, you wake up from a coma and find yourself in a strange warehouse.",
"The last thing you can think of is to pick up your car in the parking lot after work...]"]).

help_info:-output(["[GAME INSTRUCTIONS]",
"use 'help' to get instructions.",
"use 'look' to look around.",
"use 'inspect sth' to inspect for more information about the thing.",
"use 'get sth' to pick up sth and put it to your inventory.",
"use 'put sth' to take out sth from your inventory and put it on the ground.",
"use 'inventory' to list things in your inventory.",
"use 'open sth' to open the door or sth else if its key is in your inventory.",
"use 'get out' to get out the door if the door is open.",
"use 'state' to see your health point(HP) and physical point(FP).",
"use 'hint' to get some hints if you are stucked.",
"use 'end' to exit this game.",
"You should use natural language to execute some other actions in the game."]),!.

warehouse_plot:-write("You pressed the play key, a husky male voice sounded:"),nl,nl,
output(["'	Hello, Arthur, I want to play a game with you...",
"	You love your job, a job that requires a strong sense of professionalism and mission.",
"	But do you really care? Are you a hypocrite hiding behind a mask, or a real fighter?",
"	At the moment, some kind of toxin is spreading in your body, eating away at your life. ",
"	When you wake up, your metabolism will speed up the process, and you have about 40 minutes to find the only exit from this place.",
"	Let's see whether the man who's been hiding behind the camera can get his conscience back to his family.",
"	Live or die, make your choice!'	"]),!.

frozen_room_plot:-write("As long as you entered this room, a husky male voice sounded:"),nl,nl,
output(["Hello,'charitarian' Auther.",
"You go to charity parties a lot and you're in front of the camera, but we all know that in private you don't give money to any organization.",
"You call on people not to discriminate against homeless people, but you have never given any lower social status than you respect.",
"Your mean and snobbish make everyone around you sick.",
"Arthur, you have more than once stood on the moral high ground and accused the world of apathy and institutional injustice, but your actions show that you don't know what you're talking about.",
"Now you have a chance to learn how helpless people get through difficult times.",
"[**In this snow-covered room, there is a piece of paper on which is written the password to unlock the lock.** ",
"All you have to do is reach down into the snow at your feet and look for the paper.]",
"Just like every person who gets frozen in the street on a snowy night is yearning for a glimmer of ethereal hope, you will not have the time limit.",
"[**But even if you find something, the best result is just to get to the dawn...**]",
"[Hint: use 'dig snow' to reach down into the snow and look for the paper.]"
]).

machine_room_plot:-output(["You pressed the button, and the doll starts to speak:'",
"Hello, Arthur, coming here shows you didn't choose to wait for death, so listen to the rules.",
"You should have seen a working machine...",
"This machine can crush things and also open the door to the next room, and all you have to do is throwing things in enough weights into it.",
"The door opens when you put in more than 15 kilograms .",
"If you cut off the power intelligently, or wait until the timer runs out, the machine stops working...",
"You devalue poachers and call people who buy wildlife products rich executioners.",
"But on your travels in the name of interviews, you've enjoyed many animal-friendly meals. ",
"Your wife has more than one fur coat in her closet.",
"Now you have a chance to see what a real executioner feels like.",
"Whether to trade the animal's life for your own, make a choice, Arthur.'"," ",
"[Hint: You can only throw things which are in your inventory!",
" use 'get sth' and then use 'throw sth' to throw it to the machine.]"]).

choose_room_plot:-output(["The door you entered closed, and at the same time, the TV lit up, showing the image of the white-faced doll.",
"'Hello, Arthur. Maybe you think the game is over.But ask yourself --- do you really deserve this?",
"Can a moment of kindness and a moment of pain change your false nature? We both know that you haven't been truly redeemed.",
"You have many false friends, Arthur, but you have only one true friend--John.",
"John is also playing a 'game' now, and the only thing that could get him out of death is the key on the table---that's also can get you out of here.",
"You can [use it to open the last door], or you can [throw it into a pipe] in the corner and take it to John.",
"There is only one key. If the mean and hypocritical Arthur seager chooses to die, then the good and honest John will survive.",
"Live or die, make your choice!","",
"[Hint: use 'get key'and then 'throw key' to throw it to the pipe;",
" use 'get key' and then use 'open door' to open the last door.]"]).

info(warehouse):-output(["This room seems to be a warehouse and its roof is about 12 meters or more above the ground.",
"The walls are solid, with a metal surface, so it's clear that you're unable to force its way out.",
"There is an unlocked door, which may be the only way out...",
"[Hint: You can use 'get out' to walk out the door. Use 'get sth' to pick up things.]"]).

info('machine room'):-output(["This is a room with an arresting machine!",
"After you entered this room, the door to the warehouse was locked and you can't open it anyway.",
"There's another door which is the only way out, but it is locked!"]).

info('frozen room'):-output(["The room is obviously a closed freezer!",
"The ground is covered with white frost and Knee-deep snow and there are signs of ice on the walls on all sides.",
"On the opposite side of the room, there was a door with no open handwheel.",
"Only an electronic lock that was embedded in the door and requires a four-digit password.",
"[Hint: you can use 'input psw', such as 'input 1234' to open the door.]"]).

info('choose room'):-output(["The room is not big. "]).

info(walkman):-output(["[Name: walkman with built-in tape]",
"[Function: play the recording on tape or listen to the radio on a designated channel]",
"[Pickable: yes]",
"[Note: You can [play] it. And you'd better believe the recording of the tape]",
"[Hint: use 'play walkman' to play it, use 'listen to FMxx.x' to listen to a designated channel.]"]).

info('iron cage'):-output(["The cage is locked. You need a key to unlocked it."]),!.

info(doll):-output(["There is a play button on this doll... You can use 'play doll' to play it."]).

info(paper):-output(["On this paper is an article with title 'They are not your dinner!', which was writen by you---Arthur.",
"An picture below shows a young monkey  prostrate in an iron cage, looking out with the help of its eyes."]).

info('pendant lamp'):-output(["Maybe I can [stand on the chair] to [get] it..."]).

info('machine'):-output(["There is a countdown timer at the top of the machine, which is set to five minutes and already running.",
 "Next to the timer, there is a meter with kilograms on it and the pointer is pointing to zero."]).

info(newspaper):-output(["On this newspaper is an article with title 'They are no different from us!', with a photo of a group of homeless men warming themselves around an old oil drum.",
"The sky was snowing in the background and the ground was white. Of course, the story was written by Arthur seager.",
"The newspaper was taped to the wall by holding four corners together with four small pieces of tape.",
"***Unusually, this newspaper is new but has a lot of clear creases.***"]).

info(box):-output(["You held it in hand and looked at it carefully. ",
"After turning it several angles, you finally found a series of letters and Numbers in a place where the edges of several pieces of paper overlapped.",
"That is 'FM27.3MHZ'"]).

info(Object):-output_list(["It's just a",Object]), write("It seems there are no more useful information about it."),nl.

hint_info('warehouse'):-output(["use 'inspect' to get more information about things you care.",
"use 'get out' to get out from the door.",
"use 'play' to play things with the play button.",
"use 'look' to get information about this room."]).

hint_info('machine room'):-output(["if you are not tall enough, try to stand on sth and then get things you want.",
"Pay attention to the time since you only have five minites.",
"Use 'throw sth' to throw it to the machine, and you can only throw things which is in your inventory.",
"use 'get out' to get out from the door.",
"use 'play' to play things with the play button.",
"use 'look' to get information about this room."]).

hint_info('frozen room'):-output(["They newspaper have many creases, so it may have been folded...",
"The homeless men... They may need...",
"use 'dig snow' to find the paper under the snow, but it's too cold",
"use 'inspect' to get more information about things you care.",
"use 'input XXXX' to input password for the door.",
"use 'look' to get information about this room."]).

hint_info('warehouse'):-output(["use 'inspect' to get more information about things you care.",
"use 'open door' to open door and get out if you have key in your inventory.",
"use 'throw sth' to throw it to the pipe, but you should get it first.",
"It's time to make your choice!"]).

