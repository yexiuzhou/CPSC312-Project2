% Actual degree planner

:- include('transcript.pl').


% Main functions
% ---------------------------------------------------------------------------- 

% graduated(T) is true if the Transcript T (list) given will allow you to graduate.
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

% some very basic nlp
q(Ans) :-
    write("Ask me: "),
    readln(Ln),
    ask(T, Q, Ans).

ask(T, ['can', 'i', 'graduate', 'yet'], 'yes') :- 
    % find a way to read transcript
    complete(T).

ask(T, ['can', 'i', 'graduate', 'yet'], 'not yet') :- 
    % find a way to read transcript
    \+ complete(T).

% Helper functions
% ---------------------------------------------------------------------------- 

% creditCount(T) is true if transcript T has 120 credits
% creditCount(T) :- length(T, X), 38 @=< X. Could be this, but the pure counting way is below
creditCount(T) :- creditCounter(T, Total), 120 @=< Total

% sciCount(T) is true if transcript T has 72 science credits
sciCount(T) :-
    onlyScienceCreditCounter(T, ScienceCourses, ScienceCredit),
    72 @=< ScienceCredit.

% onlyScienceCreditCounter(T, ScienceCourses, Total) is true if ScienceCourses is the subset of science courses in a transcript,
%                                                            and total is the number of science credits
onlyScienceCreditCounter(T, ScienceCourses, Total) :-
    findall(C, (course(C, faculty, science), member(C, T)), ScienceCourses),
    creditCounter(ScienceCourses, Total).

% upperCount(T) is true if transcript T has atleast 48 credits 300 level+
upperCount(T) :-
    findall(C, (course(C, number, X), member(C, T), 300 @=< X), UpperScienceCourses),
    creditCounter(UpperScienceCourses, Total),
    48 @=< Total.

% upperScieCount(T) is true if transcript T has 30 credits 300 level+ and from the science faculty.
upperScieCount(T) :-
    findall(C, (course(C, faculty, science), member(C, T), course(C, number, X), 300 @=< X), UpperScienceCourses),
    creditCounter(UpperScienceCourses, Total),
    30 @=< Total.

% artCount(T) is true if transcript T has atleast 12 and not more than 18 art credits
artCount(T) :-
    onlyArtsCreditCounter(Transcript, Arts, ArtCredit),
    12 @=< ArtCredit,
    ArtCredit @=< 18.

% >onlyArtsCreditCounter(T, ArtCourses, Total) is true if ArtCourses is the subset of art classses in a transcript,
%                                                     and total is the number of art credits. Helper function
onlyArtsCreditCounter(Transcript, ArtCourses, Total) :-
    findall(C, (course(C,faculty,arts), member(C, T)), ArtCourses),
    creditCounter(ArtCourses, Total).

% breadth(T) is true if transcript T has atleast 3 credits from 6 of the following course codes
% math, chem, phys, biol, stat, cpsc, eosc
% missing math
breadth(T) :- onlyMissXBreadth(T,[chem,phys,biol,stat,cpsc,eosc]).
% missing chem
breadth(T) :- onlyMissXBreadth(T,[math,phys,biol,stat,cpsc,eosc]).
% missing phys
breadth(T) :- onlyMissXBreadth(T,[math,chem,biol,stat,cpsc,eosc]).
% missing biol
breadth(T) :- onlyMissXBreadth(T,[math,chem,phys,stat,cpsc,eosc]).
% missing stat
breadth(T) :- onlyMissXBreadth(T,[math,chem,phys,biol,cpsc,eosc]).
% missing cpsc
breadth(T) :- onlyMissXBreadth(T,[math,chem,phys,biol,stat,eosc]).
% missing eosc
breadth(T) :- onlyMissXBreadth(T,[math,chem,phys,biol,stat,cpsc]).

% onlyMissXBreadth(Transcript,List) is true if all type of courses in the list are present in the transcript
onlyMissXBreadth(Transcript,[]).
onlyMissXBreadth(Transcript,[H|T]) :-
    course(C, department, H),
    member(C,T),
    onlyMissXBreadth(Transcript,T).

% communicationsRequirement(T,R) is true if transcript T has atleast 6 credits from communications 
% , and T1 is T without the 6 credits from communications.
communicationsRequirement(T,R) :- 
    % is true if you can remove 2 communication requirements
    removeComms(T,_, T1),
    removeComms(T1,_,R).

% removeComms(T,C,R)  is true if R is T with a communications course C removed
removeComms(T,C,R) :-
    course(C, requirements, communications),
    select(C, T, R).

% lab_requirements(T,R) is true if transcript T has atleast 3 credits from lab requirements 
% , and R is T without the lab requirements.
lab_requirements(T,R) :- 
    course(C,requirements, labscience),
    select(C,T,R).


% coreRequirements(T,T1) is true if transcript T has completed required named courses and 
% T1 has them removed.
coreRequirements(T,R) :-
	removeFromTranscript(T,[cpsc110,cpsc121],T1),
	removeCalc1(T1,T2),
	removeCalc2(T2,T3),
	removeFromTranscript(T3,[cpsc210,cpsc221,cpsc213],T4),
	removeCalc3(T4,T5),
	removeLinAlg(T5,T6),
	removeStat(T6,T7),
	removeFromTranscript(T7,[cpsc310,cpsc320,cpsc313],R).

% all of these are calc 1 courses
removeCalc1(T,R) :- removeFromTranscript(T,[math100],R).
removeCalc1(T,R) :- removeFromTranscript(T,[math102],R).
removeCalc1(T,R) :- removeFromTranscript(T,[math104],R).
removeCalc1(T,R) :- removeFromTranscript(T,[math180],R).
removeCalc1(T,R) :- removeFromTranscript(T,[math184],R).
removeCalc1(T,R) :- removeFromTranscript(T,[math120],R).

% all of these are calc 2 courses
removeCalc2(T,R) :- removeFromTranscript(T,[math101],R).
removeCalc2(T,R) :- removeFromTranscript(T,[math103],R).
removeCalc2(T,R) :- removeFromTranscript(T,[math105],R).
removeCalc2(T,R) :- removeFromTranscript(T,[math121],R).

% all of these are calc 3 courses
removeCalc3(T,R) :- removeFromTranscript(T,[math200],R).
removeCalc3(T,R) :- removeFromTranscript(T,[math253],R).

% all of these are calc lnear algebra courses
removeLinAlg(T,R) :- removeFromTranscript(T,[math221],R).
removeLinAlg(T,R) :- removeFromTranscript(T,[math223],R).

% there are 4 ways to satisfy stat requirements
removeStat(T,R) :- removeFromTranscript(T,[stat241],R).
removeStat(T,R) :- removeFromTranscript(T,[stat251],R).
removeStat(T,R) :- removeFromTranscript(T,[stat200,math302],R).
removeStat(T,R) :- removeFromTranscript(T,[stat200,stat302],R).

% upperCSRequirements(T,R) is true if transcript T has atleast 3 300 level+ cs courses and
% 3 400 level+ cs courses (excluding 310,313,320 but they should already be removed so its ok),
% and R has them removed.
upperCSRequirements(T,R) :- 
	% is true if you can remove  3 300 level+ cs courses 
	% and 3 400 level+ cs courses
    remove300levelcpsc(T, _, T1),
    remove300levelcpsc(T1, _, T2),
    remove300levelcpsc(T2, _, T3),
    remove400levelcpsc(T3, _, T4),
    remove400levelcpsc(T4, _, T5),
    remove400levelcpsc(T5, _, R).

% remove300levelcpsc(T, C, R) is true if transcript R is T with a 3rd year cpsc course C removed
remove300levelcpsc(T, C, R) :-
    course(C, number, Cnum),
    course(C, department, cpsc),
    CourseNumber >= 300,
    CourseNumber < 400,
    select(C, T, R).

% remove400levelcpsc(T, C, R) is true if transcript R is T with a 4rd year cpsc course C removed
remove400levelcpsc(T, C, R) :-
    course(C, number, Cnum),
    course(C, department, cpsc),
    CourseNumber >= 400,
    select(C, T, R).

% isDifferent(T1,Requirements,T2) is true if transcript T2 is T1 with 
% requirements removed. 
isDifferent(T,[],T).
isDifferent(T1,Requirements,T2) :-
	subtract(T1,T2,Requirements).

% removeFromTranscript(T1, R, T2) allows you to remove a list of specific courses from the transcript T1,
% which is T2
removeFromTranscript(T, [], T).
removeFromTranscript(T1, [H|T], T2) :-
    select(H, T1, R),
    removeFromTranscript(R, T, T2).

% creditCounter(ListOfCourses, Total) is true if Total is the total number of credits that ListOfCourses has
creditCounter([],0).
creditCounter([H|T], Total) :-
    course(H, Credit, _),
    creditCounter(T, NewTotal),
    Total is Credit+NewTotal.

% Courses infomation 
% ---------------------------------------------------------------------------- 


% cpsc courses

% 100 level
course(cpsc100,number,100).
course(cpsc100,department,cpsc).
course(cpsc100, faculty, science).
course(cpsc100, credits, 3).
course(cpsc100, name, "cpsc100").


course(cpsc103,number,103).
course(cpsc103,department,cpsc).
course(cpsc103, faculty, science).
course(cpsc103, credits, 3).
course(cpsc103, name, "cpsc103").

course(cpsc110,number,110).
course(cpsc110,department,cpsc).
course(cpsc110, faculty, science).
course(cpsc110, credits, 4).
course(cpsc110, name, "cpsc110").

course(cpsc121,number,121).
course(cpsc121,department,cpsc).
course(cpsc121, faculty, science).
course(cpsc121, credits, 4).
course(cpsc121, name, "cpsc121").

% 200 level
course(cpsc210, number, 210).
course(cpsc210, department, cpsc).
course(cpsc210, faculty, science).
course(cpsc210, credits, 4).
course(cpsc210, name, "cpsc210").

course(cpsc213, number, 213).
course(cpsc213, department, cpsc).
course(cpsc213, faculty, science).
course(cpsc213, credits, 4).
course(cpsc213, name, "cpsc213").

course(cpsc221, number, 221).
course(cpsc221, department, cpsc).
course(cpsc221, faculty, science).
course(cpsc221, credits, 4).
course(cpsc221, name, "cpsc221").

% 300 level
course(cpsc302, number, 302).
course(cpsc302, department, cpsc).
course(cpsc302, faculty, science).
course(cpsc302, credits, 3).
course(cpsc302, name, "cpsc302").

course(cpsc303, number, 303).
course(cpsc303, department, cpsc).
course(cpsc303, faculty, science).
course(cpsc303, credits, 3).
course(cpsc303, name, "cpsc303").

course(cpsc304, number, 304).
course(cpsc304, department, cpsc).
course(cpsc304, faculty, science).
course(cpsc304, credits, 3).
course(cpsc304, name, "cpsc304").

course(cpsc310, number, 310).
course(cpsc310, department, cpsc).
course(cpsc310, faculty, science).
course(cpsc310, credits, 3).
course(cpsc310, name, "cpsc310").

course(cpsc311, number, 311).
course(cpsc311, department, cpsc).
course(cpsc311, faculty, science).
course(cpsc311, credits, 3).
course(cpsc311, name, "cpsc311").

course(cpsc312, number, 312).
course(cpsc312, department, cpsc).
course(cpsc312, faculty, science).
course(cpsc312, credits, 3).
course(cpsc312, name, "cpsc312").

course(cpsc313, number, 313).
course(cpsc313, department, cpsc).
course(cpsc313, faculty, science).
course(cpsc313, credits, 3).
course(cpsc313, name, "cpsc313").

course(cpsc314, number, 314).
course(cpsc314, department, cpsc).
course(cpsc314, faculty, science).
course(cpsc314, credits, 3).
course(cpsc314, name, "cpsc314").

course(cpsc317, number, 317).
course(cpsc317, department, cpsc).
course(cpsc317, faculty, science).
course(cpsc317, credits, 3).
course(cpsc317, name, "cpsc317").

course(cpsc319, number, 319).
course(cpsc319, department, cpsc).
course(cpsc319, faculty, science).
course(cpsc319, credits, 4).
course(cpsc319, name, "cpsc319").

course(cpsc320, number, 320).
course(cpsc320, department, cpsc).
course(cpsc320, faculty, science).
course(cpsc320, credits, 3).
course(cpsc320, name, "cpsc320").

course(cpsc322, number, 322).
course(cpsc322, department, cpsc).
course(cpsc322, faculty, science).
course(cpsc322, credits, 3).
course(cpsc322, name, "cpsc322").

course(cpsc330, number, 330).
course(cpsc330, department, cpsc).
course(cpsc330, faculty, science).
course(cpsc330, credits, 3).
course(cpsc330, name, "cpsc330").

course(cpsc340, number, 340).
course(cpsc340, department, cpsc).
course(cpsc340, faculty, science).
course(cpsc340, credits, 3).
course(cpsc340, name, "cpsc340").

course(cpsc344, number, 344).
course(cpsc344, department, cpsc).
course(cpsc344, faculty, science).
course(cpsc344, credits, 3).
course(cpsc344, name, "cpsc344").

course(cpsc349, number, 349).
course(cpsc349, department, cpsc).
course(cpsc349, faculty, science).
course(cpsc349, credits, 3).
course(cpsc349, name, "cpsc349").

% 400 level
course(cpsc404,number,404).
course(cpsc404,department,cpsc).
course(cpsc404, faculty, science).
course(cpsc404, credits, 3).
course(cpsc404, name, "cpsc404").

course(cpsc406,number,406).
course(cpsc406,department,cpsc).
course(cpsc406, faculty, science).
course(cpsc406, credits, 3).
course(cpsc406, name, "cpsc406").

course(cpsc410,number,410).
course(cpsc410,department,cpsc).
course(cpsc410, faculty, science).
course(cpsc410, credits, 3).
course(cpsc410, name, "cpsc410").

course(cpsc411,number,411).
course(cpsc411,department,cpsc).
course(cpsc411, faculty, science).
course(cpsc411, credits, 3).
course(cpsc411, name, "cpsc411").

course(cpsc415,number,415).
course(cpsc415,department,cpsc).
course(cpsc415, faculty, science).
course(cpsc415, credits, 3).
course(cpsc415, name, "cpsc415").

course(cpsc416,number,416).
course(cpsc416,department,cpsc).
course(cpsc416, faculty, science).
course(cpsc416, credits, 3).
course(cpsc416, name, "cpsc416").

course(cpsc418,number,418).
course(cpsc418,department,cpsc).
course(cpsc418, faculty, science).
course(cpsc418, credits, 3).
course(cpsc418, name, "cpsc418").

course(cpsc420,number,420).
course(cpsc420,department,cpsc).
course(cpsc420, faculty, science).
course(cpsc420, credits, 3).
course(cpsc420, name, "cpsc420").

course(cpsc421,number,421).
course(cpsc421,department,cpsc).
course(cpsc421, faculty, science).
course(cpsc421, credits, 3).
course(cpsc421, name, "cpsc421").

course(cpsc422,number,422).
course(cpsc422,department,cpsc).
course(cpsc422, faculty, science).
course(cpsc422, credits, 3).
course(cpsc422, name, "cpsc422").

course(cpsc424,number,424).
course(cpsc424,department,cpsc).
course(cpsc424, faculty, science).
course(cpsc424, credits, 3).
course(cpsc424, name, "cpsc424").

course(cpsc436D,number,436).
course(cpsc436D,department,cpsc).
course(cpsc436D, faculty, science).
course(cpsc436D, credits, 3).
course(cpsc436D, name, "cpsc436D").

course(cpsc444,number,444).
course(cpsc444,department,cpsc).
course(cpsc444, faculty, science).
course(cpsc444, credits, 3).
course(cpsc444, name, "cpsc444").

course(cpsc445,number,445).
course(cpsc445,department,cpsc).
course(cpsc445, faculty, science).
course(cpsc445, credits, 3).
course(cpsc444, name, "cpsc444").

course(cpsc448,number,448).
course(cpsc448,department,cpsc).
course(cpsc448, faculty, science).
course(cpsc448, credits, 3).
course(cpsc448, name, "cpsc448").

course(cpsc449,number,449).
course(cpsc449,department,cpsc).
course(cpsc449, faculty, science).
course(cpsc449, credits, 6).
course(cpsc449, name, "cpsc449").

course(cpsc490,number,490).
course(cpsc490,department,cpsc).
course(cpsc490, faculty, science).
course(cpsc490, credits, 3).
course(cpsc490, name, "cpsc490").

% math courses

% 100 level
course(math100,number,100).
course(math100,department,math).
course(math100, faculty, science).
course(math100, credits, 3).
course(math100, name, "math100").

course(math101,number,101).
course(math101,department,math).
course(math101, faculty, science).
course(math101, credits, 3).
course(math101, name, "math101").

course(math102,number,102).
course(math102,department,math).
course(math102, faculty, science).
course(math102, credits, 3).
course(math102, name, "math102").

course(math103,number,103).
course(math103,department,math).
course(math103, faculty, science).
course(math103, credits, 3).
course(math103, name, "math103").

course(math104,number,104).
course(math104,department,math).
course(math104, faculty, science).
course(math104, credits, 3).
course(math104, name, "math104").

course(math105,number,105).
course(math105,department,math).
course(math105, faculty, science).
course(math105, credits, 3).
course(math105, name, "math105").

course(math180,number,180).
course(math180,department,math).
course(math180, faculty, science).
course(math180, credits, 4).
course(math180, name, "math180").

course(math184,number,184).
course(math184,department,math).
course(math184, faculty, science).
course(math184, credits, 4).
course(math184, name, "math184").

course(math120,number,120).
course(math120,department,math).
course(math120, faculty, science).
course(math120, credits, 4).
course(math120, name, "math120").

course(math121,number,121).
course(math121,department,math).
course(math121, faculty, science).
course(math121, credits, 4).
course(math121, name, "math121").

% 200 level
course(math200,number,200).
course(math200,department,math).
course(math200, faculty, science).
course(math200, credits, 3).
course(math200, name, "math200").

course(math221,number,221).
course(math221,department,math).
course(math221, faculty, science).
course(math221, credits, 3).
course(math221, name, "math221").

course(math223,number,223).
course(math223,department,math).
course(math223, faculty, science).
course(math223, credits, 3).
course(math223, name, "math223").

course(math253,number,253).
course(math253,department,math).
course(math253, faculty, science).
course(math253, credits, 3).
course(math253, name, "math253").

course(math302,number,302).
course(math302,department,math).
course(math302, faculty, science).
course(math302, credits, 3).
course(math302, name, "math302").

% stat courses

% 200 level
course(stat200,number,200).
course(stat200,department,stat).
course(stat200, faculty, science).
course(stat200, credits, 3).
course(stat200, name, "stat200").

course(stat241,number,241).
course(stat241,department,stat).
course(stat241, faculty, science).
course(stat241, credits, 3).
course(stat241, name, "stat241").

course(stat251,number,251).
course(stat251,department,stat).
course(stat251, faculty, science).
course(stat251, credits, 3).
course(stat251, name, "stat251").

% 300 level
course(stat302,number,302).
course(stat302,department,stat).
course(stat302, faculty, science).
course(stat302, credits, 3).
course(stat302, name, "stat302").

% communications

course(wrds150,number,150).
course(wrds150,department,wrds).
course(wrds150, credits, 3).
course(wrds150, name, "wrds150").
course(wrds150, requirements, communications).

course(scie113,number,113).
course(scie113,department,scie).
course(scie113, credits, 3).
course(scie113, name, "scie113").
course(scie113, requirements, communications).

course(scie300,number,300).
course(scie300,department,scie).
course(scie300, credits, 3).
course(scie300, name, "scie300").
course(scie300, requirements, communications).

course(chem300,number,300).
course(chem300,department,chem).
course(chem300, credits, 3).
course(chem300, name, "chem300").
course(chem300, requirements, communications).

course(apsc176,number,176).
course(apsc176,department,apsc).
course(apsc176, credits, 3).
course(apsc176, name, "apsc176").
course(apsc176, requirements, communications).

course(lfs150,number,150).
course(lfs150,department,lfs).
course(lfs150, credits, 3).
course(lfs150, name, "lfs150").
course(lfs150, requirements, communications).

course(astu100,number,100).
course(astu100,department,astu).
course(astu100, credits, 3).
course(astu100, name, "astu100").
course(astu100, requirements, communications).

course(astu101,number,101).
course(astu101,department,astu).
course(astu101, credits, 3).
course(astu101, name, "astu101").
course(astu101, requirements, communications).

% lab science

course(astr101,number,101).
course(astr101,department,astr).
course(astr101,faculty, science).
course(astr101, credits, 3).
course(astr101, name, "astr101").
course(astr101, requirements, labscience).

course(astr102,number,102).
course(astr102,department,astr).
course(astr102, faculty, science).
course(astr102, credits, 3).
course(astr102, name, "astr102").
course(astr102, requirements, labscience).

course(biol140,number,140).
course(biol140,department,biol).
course(biol140, faculty, science).
course(biol140, credits, 2).
course(biol140, name, "biol140").
course(biol140, requirements, labscience).

course(chem111,number,111).
course(chem111,department,chem).
course(chem111, faculty, science).
course(chem111, credits, 4).
course(chem111, name, "chem111").
course(chem111, requirements, labscience).

course(chem121,number,121).
course(chem121,department,chem).
course(chem121, faculty, science).
course(chem121, credits, 4).
course(chem121, name, "chem121").
course(chem121, requirements, labscience).

course(chem123,number,123).
course(chem123,department,chem).
course(chem123, faculty, science).
course(chem123, credits, 4).
course(chem123, name, "chem123").
course(chem123, requirements, labscience).

course(eosc111,number,111).
course(eosc111,department,eosc).
course(eosc111, faculty, science).
course(eosc111, credits, 1).
course(eosc111, name, "eosc111").
course(eosc111, requirements, labscience).

course(phys101,number,101).
course(phys101,department,phys).
course(phys101, faculty, science).
course(phys101, credits, 3).
course(phys101, name, "phys101").
course(phys101, requirements, labscience).

course(phys107,number,107).
course(phys107,department,phys).
course(phys107, faculty, science).
course(phys107, credits, 3).
course(phys107, name, "phys107").
course(phys107, requirements, labscience).

course(phys109,number,109).
course(phys109,department,phys).
course(phys109, faculty, science).
course(phys109, credits, 1).
course(phys109, name, "phys109").
course(phys109, requirements, labscience).

course(phys119,number,119).
course(phys119,department,phys).
course(phys119, faculty, science).
course(phys119, credits, 1).
course(phys119, name, "phys119").
course(phys119, requirements, labscience).

course(phys159,number,159).
course(phys159,department,phys).
course(phys159, faculty, science).
course(phys159, credits, 1).
course(phys159, name, "phys159").
course(phys159, requirements, labscience).

% dummy arts course
course(arts100,number,100).
course(arts100,faculty,arts).
course(arts100, credits, 3).
course(arts100, name, "arts100").

course(arts101,number,101).
course(arts101,faculty,arts).
course(arts101, credits, 3).
course(arts101, name, "arts101").

course(arts102,number,102).
course(arts102,faculty,arts).
course(arts102, credits, 3).
course(arts102, name, "arts102").

course(arts103,number,103).
course(arts103,faculty,arts).
course(arts103, credits, 3).
course(arts103, name, "arts103").

course(arts300,number,300).
course(arts300,faculty,arts).
course(arts300, credits, 3).
course(arts300, name, "arts300").

course(arts301,number,301).
course(arts301,faculty,arts).
course(arts301, credits, 3).
course(arts301, name, "arts301").

course(arts302,number,302).
course(arts302,faculty,arts).
course(arts302, credits, 3).
course(arts302, name, "arts302").

course(arts303,number,303).
course(arts303,faculty,arts).
course(arts303, credits, 3).
course(arts303, name, "arts303").


















