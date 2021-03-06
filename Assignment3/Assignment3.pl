%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kennissystemen, Assignment 3
% Alex Khawalid, 
% Philip Bouman, 10668667
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Operators
:- dynamic fact/1.
:- op(800, fx, if).
:- op(700, xfy, then).
:- op(300, xfy, or).
:- op(200, xfy, and).

%%%%%%%%%%%%%%%%%%
% Knowledge base
%%%%%%%%%%%%%%%%%%

% Moet als if then rules gerepresenteerd
% 2 ziekten

% Malaria
if (hoofdpijn or diarree or braken) then malaria_aanval.
if malaria_aanval then malaria_tropica.
if malariaparasieten then malaria_tropica.
if hoge_koorts then malaria_tropica.
if piek_koorts then malaria_goedaardig.
if (malaria_tropica or malaria_goedaardig) then malaria.

% Darminfecties
if (diarree or misselijk or buikpijn) then giardiasis.
if (koorts or kramp or ontlasting) then bascillaire_dysenterie.
if verlammings_verschijnselen then kinderverlamming.
if (gele_huid or misselijkheid or donkere_urine) then geelzucht.
if dunne_diaree then cholera.

%%%%%%%%%%%%%%%%%%
% Program
%%%%%%%%%%%%%%%%%%
start:-
    write('Heeft u hoofdpijn? Graag antwoorden met ja of nee.\n'),
    read(Symptom),
    if (Symptom is ja) then deriveDisease(hoofdpijn,Diseases,RulesUsed).

deriveDisease(Symptom,Diseases,RulesUsed):-
    assert(fact(Symptom)),
    forward.
    %getDiseases(Symptom,Diseases).

getDiseases(Symptom,PossibleDiseases):-
    bagof(Y, if Symptom then Y, PossibleDiseases );
    bagof(Y, if Symptom or _ then Y, PossibleDiseases);
    bagof(Y, if _ or Symptom then Y, PossibleDiseases);
    bagof(Y, if _ or Symptom or _ then Y, PossibleDiseases).

test(A, B) :-
	if A then B.

% Backward chaining

is_true(P):-
	fact(P).

is_true(P):-
	if Condition then P,
	is_true(Condition).

is_true(P1 and P2):-
	is_true(P1)
	;
	is_true(P2).

% Forward chaining

forward:-
    new_derived_fact(P),
    !,
    write('Derived:'), write_ln(P),
    assert(fact(P)),
    forward
    ;
    write_ln('No more facts').

new_derived_fact( Conclusion ):-
    if Condition then Conclusion,
    not( fact( Conclusion ) ),
    composed_fact( Condition ).

composed_fact( Condition ):-
    fact( Condition ).

composed_fact( Condition1 and Condition2 ):-
    composed_fact( Condition1 ),
    composed_fact( Condition2 ).

composed_fact( Condition1 or Condition2 ):-
    composed_fact( Condition1 )
    ;
    composed_fact( Condition2 ).
