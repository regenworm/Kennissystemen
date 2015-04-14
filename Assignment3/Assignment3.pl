%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kennissystemen, Assignment 3
% Alex Khawalid, 
% Philip Bouman, 10668667
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Operators
:- op(800, fx, if).
:- op(700, xfy, then).
:- op(300, xfy, or).
:- op(200, xfy, and).

%%%%%%%%%%%%%%%%%%
% Knowledge base
%%%%%%%%%%%%%%%%%%

% Symptoom
fact(symptoom, fysiek).
fact(symptoom, mentaal).

	% Fysiek
	fact(fysiek, uiterlijk).
	fact(fysiek, sensatie).
	fact(fysiek, lichaamsfunctie).
	fact(fysiek, temperatuur).

	% Mentaal
	fact(mentaal, veranderingen).
	fact(mentaal, verward).
	fact(mentaal, concentratie).
	fact(mentaal, eetlust).

		% Uiterlijk
		fact(uiterlijk, verkleuring).
		fact(uiterlijk, uitsteeksels).
		fact(uiterlijk, zwelling).
		fact(uiterlijk, uitslag).

		% Verkleuring
		fact(verkleuring, vlekken).
		fact(verkleuring, geling).
		fact(verkleuring, framboosachtig).

			% Vlekken
			fact(vlekken, licht).
			fact(vlekken, donker).
			fact(vlekken, kleding).

		% Uitstekels
		fact(uitsteeksels, bobbels).
		fact(uitsteeksels, schilfering).
		fact(uitsteeksels, zweren).
		fact(uitsteeksels, steenpuist).
		fact(uitsteeksels, pukkels).
		fact(uitsteeksels, knobbels).
		fact(uitsteeksels, muggenbeet).

			% Schilfering
			fact(schilfering, borst).
			fact(schilfering, schouders).
			fact(schilfering, bovenarmen).
			fact(schilfering, rug).

		% Zwelling
		fact(zwelling, benen).

		% Uitslag
		fact(uitslag, jeuk).
		fact(uitslag, eczeem).
		fact(uitslag, schilfering).
		fact(uitslag, afwijking).

			% Eczeem
			fact(eczeem, liezen).
			fact(eczeem, oksels).
			fact(eczeem, borsten).

	% Sensatie	
	fact(sensatie, onwel).
	fact(sensatie, zwakjes).
	fact(sensatie, jeuk).
	fact(sensatie, pijn).

	% Lichaamsfunctie
	fact(lichaamsfunctie, bloedcirculatie).
	fact(lichaamsfunctie, zintuigen).
	fact(lichaamsfunctie, vertering).	

%%%%%%%%%%%%%%%%%%
% Program
%%%%%%%%%%%%%%%%%%


% Choose from a list of symptoms
ask(L):-
	fact(symptoom, X),
	fact(symptoom, Y),
	X \= Y,
	append([], X, L),
	print(L).




% Backward chaining

is_true(P):-
	fact(P).

