% Actual degree planner

:- include('transcript.pl').


% Main functions
% ---------------------------------------------------------------------------- 

% graduated(T) is true if the Transcript T given will allow you to graduate.
graduated(T) :-
    complete(T, _, _, _, _).


% complete(T,Communications,Lab,Core,UpperCS) is True if
% Transcript T fulfills the requirements.
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

% Helper functions
% ---------------------------------------------------------------------------- 

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

% removeFromTranscript(T1, R, T2)
removeFromTranscript(T, [], T).
removeFromTranscript(T1, [H|T], T2) :-
    select(H, T1, R),
    removeFromTranscript(R, T, T2).

% Courses infomation 
% ---------------------------------------------------------------------------- 

prop(cpsc,faculty,science).

% cpsc courses

% 100 level
course(cpsc100,number,100).
course(cpsc100,department,cpsc).
course(cpsc100, credits, 3).
course(cpsc100, name, "cpsc100").


course(cpsc103,number,103).
course(cpsc103,department,cpsc).
course(cpsc103, credits, 3).
course(cpsc103, name, "cpsc103").

course(cpsc110,number,110).
course(cpsc110,department,cpsc).
course(cpsc110, credits, 4).
course(cpsc110, name, "cpsc110").

course(cpsc121,number,121).
course(cpsc121,department,cpsc).
course(cpsc121, credits, 4).
course(cpsc121, name, "cpsc121").

% 200 level
course(cpsc210, number, 210).
course(cpsc210, department, cpsc).
course(cpsc210, credits, 4).
course(cpsc210, name, "cpsc210").

course(cpsc213, number, 213).
course(cpsc213, department, cpsc).
course(cpsc213, credits, 4).
course(cpsc213, name, "cpsc213").

course(cpsc221, number, 221).
course(cpsc221, department, cpsc).
course(cpsc221, credits, 4).
course(cpsc221, name, "cpsc221").

% 300 level
course(cpsc302, number, 302).
course(cpsc302, department, cpsc).
course(cpsc302, credits, 3).
course(cpsc302, name, "cpsc302").

course(cpsc303, number, 303).
course(cpsc303, department, cpsc).
course(cpsc303, credits, 3).
course(cpsc303, name, "cpsc303").

course(cpsc304, number, 304).
course(cpsc304, department, cpsc).
course(cpsc304, credits, 3).
course(cpsc304, name, "cpsc304").

course(cpsc310, number, 310).
course(cpsc310, department, cpsc).
course(cpsc310, credits, 3).
course(cpsc310, name, "cpsc310").

course(cpsc311, number, 311).
course(cpsc311, department, cpsc).
course(cpsc311, credits, 3).
course(cpsc311, name, "cpsc311").

course(cpsc312, number, 312).
course(cpsc312, department, cpsc).
course(cpsc312, credits, 3).
course(cpsc312, name, "cpsc312").

course(cpsc313, number, 313).
course(cpsc313, department, cpsc).
course(cpsc313, credits, 3).
course(cpsc313, name, "cpsc313").

course(cpsc314, number, 314).
course(cpsc314, department, cpsc).
course(cpsc314, credits, 3).
course(cpsc314, name, "cpsc314").

course(cpsc317, number, 317).
course(cpsc317, department, cpsc).
course(cpsc317, credits, 3).
course(cpsc317, name, "cpsc317").

course(cpsc319, number, 319).
course(cpsc319, department, cpsc).
course(cpsc319, credits, 4).
course(cpsc319, name, "cpsc319").

course(cpsc320, number, 320).
course(cpsc320, department, cpsc).
course(cpsc320, credits, 3).
course(cpsc320, name, "cpsc320").

course(cpsc322, number, 322).
course(cpsc322, department, cpsc).
course(cpsc322, credits, 3).
course(cpsc322, name, "cpsc322").

course(cpsc330, number, 330).
course(cpsc330, department, cpsc).
course(cpsc330, credits, 3).
course(cpsc330, name, "cpsc330").

course(cpsc340, number, 340).
course(cpsc340, department, cpsc).
course(cpsc340, credits, 3).
course(cpsc340, name, "cpsc340").

course(cpsc344, number, 344).
course(cpsc344, department, cpsc).
course(cpsc344, credits, 3).
course(cpsc344, name, "cpsc344").

course(cpsc349, number, 349).
course(cpsc349, department, cpsc).
course(cpsc349, credits, 3).
course(cpsc349, name, "cpsc349").

% 400 level
course(cpsc404,number,404).
course(cpsc404,department,cpsc).
course(cpsc404, credits, 3).
course(cpsc404, name, "cpsc404").

course(cpsc406,number,406).
course(cpsc406,department,cpsc).
course(cpsc406, credits, 3).
course(cpsc406, name, "cpsc406").

course(cpsc410,number,410).
course(cpsc410,department,cpsc).
course(cpsc410, credits, 3).
course(cpsc410, name, "cpsc410").

course(cpsc411,number,411).
course(cpsc411,department,cpsc).
course(cpsc411, credits, 3).
course(cpsc411, name, "cpsc411").

course(cpsc415,number,415).
course(cpsc415,department,cpsc).
course(cpsc415, credits, 3).
course(cpsc415, name, "cpsc415").

course(cpsc416,number,416).
course(cpsc416,department,cpsc).
course(cpsc416, credits, 3).
course(cpsc416, name, "cpsc416").

course(cpsc418,number,418).
course(cpsc418,department,cpsc).
course(cpsc418, credits, 3).
course(cpsc418, name, "cpsc418").

course(cpsc420,number,420).
course(cpsc420,department,cpsc).
course(cpsc420, credits, 3).
course(cpsc420, name, "cpsc420").

course(cpsc421,number,421).
course(cpsc421,department,cpsc).
course(cpsc421, credits, 3).
course(cpsc421, name, "cpsc421").

course(cpsc422,number,422).
course(cpsc422,department,cpsc).
course(cpsc422, credits, 3).
course(cpsc422, name, "cpsc422").

course(cpsc424,number,424).
course(cpsc424,department,cpsc).
course(cpsc424, credits, 3).
course(cpsc424, name, "cpsc424").

course(cpsc436D,number,436).
course(cpsc436D,department,cpsc).
course(cpsc436D, credits, 3).
course(cpsc436D, name, "cpsc436D").

course(cpsc444,number,444).
course(cpsc444,department,cpsc).
course(cpsc444, credits, 3).
course(cpsc444, name, "cpsc444").

course(cpsc445,number,445).
course(cpsc445,department,cpsc).
course(cpsc445, credits, 3).
course(cpsc444, name, "cpsc444").

course(cpsc448,number,448).
course(cpsc448,department,cpsc).
course(cpsc448, credits, 3).
course(cpsc448, name, "cpsc448").

course(cpsc449,number,449).
course(cpsc449,department,cpsc).
course(cpsc449, credits, 6).
course(cpsc449, name, "cpsc449").

course(cpsc490,number,490).
course(cpsc490,department,cpsc).
course(cpsc490, credits, 3).
course(cpsc490, name, "cpsc490").








