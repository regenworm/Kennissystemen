% knowledge base

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
% relatie(feature, class, type, valuerestriction)
% huid
relatie(huid,zoogdier, haar, 1/inf).
relatie(huid,vogel, veren, 1/inf).
relatie(huid,reptiel, schubben, 1/inf).
relatie(huid,amfibie,slijmlaag,1/1 ).
relatie(huid,kraakbeenvis,huidtandjes,1/inf).



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
% base case
getChildren([Parent],[]):-
	not(descendant(Parent,_)).

getChildren(Parent,[]):-
	not(append([_],[_],Parent)),
	not(descendant(Parent,_)).

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
	getChildren(ChildH,GrandHChild),
	getChildren(ChildT,GrandTChild),
	getChildren(TP,TPChild),
	append([ChildH],GrandHChild,Htree),
	append(ChildT,GrandTChild,Ttree),
	append(Htree,Ttree,HChildren),
	append([TPChild],HChildren,AllChildren).

% 1 parent, multiple children
getChildren(Parent,AllChildren):-
	print('multchild\n'),
	print(Parent),
	bagof(Y,descendant(Parent,Y),[ChildH|ChildT]),
	getChildren(ChildH,GrandHChild),
	getChildren(ChildT,GrandTChild),
	append([ChildH],GrandHChild,Htree),
	append(ChildT,GrandTChild,Ttree),
	append(Htree,Ttree,AllChildren).

% multiple parents, 1 child

% get all relations of given class.
% base case
getRelations(Parent, [], Relations):-
	bagof(Y,relatie(Y,Parent,_,_),Relations),
	print(Relations),
	print('\n').

getRelations(Parent,[H|T],AllRelations):-
	getRelations(H,T,Relations2),
	bagof(Y,relatie(Y,Parent,_,_),Relations),
	print(Relations),
	print('\n'),
	append(Relations, Relations2, AllRelations).

show(Parent):-
	print('Ancestors:\n'),
	getAncestors(Parent,Ancestors),
	printDescent(Ancestors,Parent),
	print('Children:\n'),
	getChildren(Parent,_),
	getRelations(Parent,Ancestors,_).

