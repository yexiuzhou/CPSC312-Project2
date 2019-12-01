% Actual degree planner

:- include('transcript.pl').

% graduated(T) is true if the Transcript T given will allow you to graduate.
graduated(T) :-
    complete(T, _, _, _, _, _).


% complete(T,Communications,Lab,Art,Core,UpperCS) is True if
% Transcript T fulfills the 8 requirements.
complete(T,Communications,Lab,Art,Core,UpperCS) :-
	communicationsRequirement(T,T1),
	isDifferent(T,Communications,T1),
	lab_requirements(T1,T2),
	isDifferent(T1,Lab,T2),
	artRequirements(T2,T3),
	isDifferent(T2,Art,T3),
	coreRequirements(T3,T4),
	isDifferent(T3,Core,T4),
	upperCSRequirements(T4,UpperCS,T5).



% isDifferent(T1,Requirements,T2) is True if T2 is T1 with requirements removed. 
isDifferent(T,[],T).
isDifferent(T1,Requirements,T2) :-
	subtract(T1,T2,Requirements).