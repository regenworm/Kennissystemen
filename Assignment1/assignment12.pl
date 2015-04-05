% knowledge base
:- dynamic descendant/2.
:- dynamic relatie/3.

%%%%%%%%%%%%%%%%%% klasse dier %%%%%%%%%%%%%%%%%%
% descendant(Parent class, Child class)
% onderste niveau
descendant(zoogdier,wolf).
descendant(zoogdier, aap).
descendant(vogel,duif).
descendant(vogel,eend).
descendant(reptiel, hagedis).
descendant(reptiel,leguaan).
descendant(amfibie,kikker).
descendant(amfibie,pad).
descendant(kraakbeenvis,haai).
descendant(kraakbeenvis,rog).

% klasse niveau 2
descendant(gewervelde, zoogdier).
descendant(gewervelde, vogel).
descendant(gewervelde, reptiel).
descendant(gewervelde, amfibie).
descendant(gewervelde, kraakbeenvis).

% klasse niveau 3
descendant(dier, gewervelde).

%%%%%%%%%%%%%%%%%% relaties %%%%%%%%%%%%%%%%%%
% relatie(class, feature/type, valuerestriction)
% huid
relatie(zoogdier, huid/haar, 1/inf).
relatie(vogel, huid/veren, 1/inf).
relatie(reptiel, huid/schubben, 1/inf).
relatie(amfibie, huid/slijmlaag,1/1 ).
relatie(kraakbeenvis, huid/huidtandjes,1/inf).

% ledematen
relatie(zoogdier, ledematen/_, 2/5).
relatie(vogel, ledematen/vleugels, 2/2).
relatie(reptiel, ledematen/poten, 1/4).
relatie(amfibie, ledematen/poten, 1/4).
relatie(kraakbeenvis, ledematen/vinnen, 2/inf).

% eet
relatie(wolf, eet/carnivoor, 1/inf).
relatie(aap, eet/omnivoor, 1/inf).
relatie(duif, eet/herbivoor, 1/inf).
relatie(eend, eet/omnivoor, 1/inf).
relatie(hagedis, eet/carnivoor, 1/inf).
relatie(leguaan, eet/carnivoor, 1/inf).
relatie(kikker, eet/carnivoor, 1/inf).
relatie(pad, eet/carnivoor, 1/inf).
relatie(haai, eet/carnivoor, 1/inf).
relatie(rog, eet/omnivoor, 1/inf).

% voortplanting
relatie(zoogdier, voortplanting/geboorte, 0/inf).
relatie(vogel, voortplanting/ei, 0/inf).
relatie(reptiel, voortplanting/ei, 0/inf).
relatie(amfibie, voortplanting/larve, 0/inf).
relatie(kraakbeenvis, voortplanting/geboorte, 0/inf).

% warm of koudbloedig
relatie(zoogdier, lichaamswarmte/warmbloedig, 1/inf).
relatie(vogel, lichaamswarmte/warmbloedig, 1/inf).
relatie(reptiel, lichaamswarmte/koudbloedig, 1/inf).
relatie(amfibie, lichaamswarmte/koudbloedig, 1/inf).
relatie(kraakbeenvis, lichaamswarmte/koudbloedig, 1/inf).

% gewervelde
relatie(gewervelde, wervels/ja, 1/inf).

%%%%%%%%%%%%%%%%%% functions %%%%%%%%%%%%%%%%%%
% print ancestors of given class
printDescent([],Parent):-
	print(Parent),
	print('\n').

printDescent([H|T],Parent):-
	print(H),
	print(' > '),
	printDescent(T,Parent).

% get all ancestors of given class
% base case
getAncestors(Parent,[]):-
	not(descendant(_,Parent)).
	
getAncestors(Parent, [Ancestor|AncestorsT]):-
	descendant(Ancestor,Parent),
	getAncestors(Ancestor,AncestorsT).

% get all Children of given class


% 1 parent, 1 child
getChildren(Parent,AllChildren):-
	bagof(Y,descendant(Parent,Y),[Child]),
	print(Parent),
	getChildren(Child,GrandChildren),
	append(Child,GrandChildren,AllChildren).

% multiple parents, multiple children
% hier zit een fout
getChildren([HP|TP],AllChildren):-
	bagof(Y,descendant(HP,Y),[ChildH|ChildT]),
	getChildren(TP, TPChild),
	append([ChildH|ChildT],TPChild, AllChildren).

% 1 parent, multiple children
getChildren(Parent,AllChildren):-
	bagof(Y,descendant(Parent,Y),[ChildH|ChildT]),
	getChildren(ChildH,GrandHChild),
	getChildren(ChildT,GrandTChild),
	append([ChildH],GrandHChild,Htree),
	append(ChildT,GrandTChild,Ttree),
	append(Htree,Ttree, AllChildren).

% base case
getChildren([Parent],[]):-
	not(descendant(Parent,_)).

getChildren(Parent,[]):-
	not(descendant(Parent,_)).

% get all relations of given class.
% base case
getRelations(Parent, [], Relations):-
	bagof(Y,relatie(Y,Parent,_,_),Relations).

getRelations(Parent,[H|T],[Rels|MoreRels]):-
	bagof(Y,relatie(Y,Parent,_,_),Rels);
	getRelations(H,T,MoreRels).

show(Parent):-
	print('Ancestors:\n'),
	getAncestors(Parent,Ancestors),
	reverse(Ancestors,AncestorsR),
	printDescent(AncestorsR,Parent),
	getChildren(Parent,Children),
	print('Children:\n'),
	print(Children),
	print('\n'),
	getRelations(Parent,Ancestors,Relations),
	print('Relations:\n'),
	print(Relations).

% add class
% add(class, relaties, ancestor)
go1:-
	add(hond, [huid/haar, wervels/ja],zoogdier).

add(Class,[H|T],[]):-
	bagof(Y,relatie(Y,H,_),Possible).

add(Class,[H|T],Ancestor):-
	assert(descendant(Ancestor,Class)),
	bagof(Y,relatie(Y,H,_),Possible).

% welke classes hebben allemaal deze relatie
% checkAllRel(Relations,PossibleClasses,Answer)
checkAllRel([],Poss,Poss).

checkAllRel([H|T],Possible1,Ans):-
	bagof(Y,relatie(Y,H,_),Possible2),
	getList(Possible1,Possible2,ActualPossible),
	checkAllRel(T,ActualPossible,Ans).

% crossreference classes
% last element is also in list 1
getList(Possible1,[H],[H]):-
	memberchk(H,Possible1).

% last element is not also in list 1
getList(Possible1,[H],[]):-
	not(memberchk(H,Possible1)).

% iterate through list
getList(Possible1,[H|T],[H|PossibleClasses]):-
	getList(Possible1,T,PossibleClasses),
	memberchk(H,Possible1).

% h not a member
getList(Possible1,[H|T],AllClasses)
	getList(Possible1,T,AllClasses),
	not(memberchk(H,Possible1)).





