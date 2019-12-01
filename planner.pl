% Actual degree planner

:- include('transcript.pl').

% graduated(T) is true if the Transcript T given will allow you to graduate.
graduated(T) :-
    complete(T, _, _, _, _, _).


% complete(T,Communications,Lab,Art,Core,UpperCS) is True if
% Transcript T fulfills the 8 requirements.
complete(T,Communications,Lab,Core,UpperCS) :-
	creditCount(T),
	sciCount(T),
	upperCount(T),
	upperScieCount(T),
	artCount(T),
	breadth(T),
	communicationsRequirement(T,T1),
	isDifferent(T,Communications,T1),
	lab_requirements(T1,T2),
	isDifferent(T1,Lab,T2),
	coreRequirements(T2,T3),
	isDifferent(T2,Core,T3),
	upperCSRequirements(T3,T4),
	isDifferent(T3,UpperCS,T4).

% creditCount(T) is true if transcript T has 120 credits

% sciCount(T) is true if transcript T has 72 science credits

% upperCount(T) is true if transcript T has atleast 48 credits 300 level+

% upperScieCount(T) is true if transcript T has 30 credits 300 level+ 
% and from the science faculty.

% artCount(T) is true if transcript T has atleast 12 and not more than 18 art credits

% breadth(T) is true if transcript T has atleast 3 credits from 6 of the following course codes
% math, chem, phys, biol, stat, cpsc, eosc

% communicationsRequirement(T,T1) is true if transcript T has atleast 6 credits from communications 
% , and T1 is T without the 6 credits from communications.

% lab_requirements(T,T1) is true if transcript T has atleast 3 credits from lab requirements 
% , and T1 is T without the 3 credits from lab requirements.

% coreRequirements(T,T1) is true if transcript T has 

% upperCSRequirements(T,T1) is true if transcript T has


% isDifferent(T1,Requirements,T2) is true if transcript T2 is T1 with 
% requirements removed. 
isDifferent(T,[],T).
isDifferent(T1,Requirements,T2) :-
	subtract(T1,T2,Requirements).