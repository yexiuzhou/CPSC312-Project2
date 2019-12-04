% transcript

% use below to import file:
% :- include('transcript.pl').

% example of successful transcript
transcript([cpsc110,cpsc121,math100,math101,phys101,chem121,biol111,wrds150,scie113, % 1st year
	cpsc210,cpsc221,cpsc213,math200,math221,stat241,arts102,arts100,arts101,cpsc310, % 2nd year
	cpsc313,cpsc320,cpsc312,cpsc314,cpsc330,cpsc415,cpsc410,cpsc420,cpsc317,cpsc340, % 3rd year
	cpsc304,cpsc404,cpsc416,cpsc418,cpsc311,cpsc411,cpsc322,cpsc422,arts300]). 		 % 4th year

% this is actually my own transcript (planned atleast)
transcript2([cpsc103,cpsc107,cpsc121,math100,math101,stat200,wrds150,scie113,arts100,arts101,arts102, % 1st year
	cpsc210,cpsc221,cpsc213,math200,math221,phys101,arts103, 										 % 2nd year
	cpsc313,cpsc320,cpsc310,stat302,cpsc312,cpsc304,cpsc314,cpsc322,eosc114,biol111,				 % 3rd year
	cpsc410,cpsc418,cpsc317,cpsc404,cpsc311,cpsc416,cpsc330,cpsc340,cpsc411,cpsc422]).				 % 4th year

% example of failure of a transcript
transcript3([cpsc103,cpsc107,cpsc121,math100,math101,stat200,wrds150,scie113,arts100,arts101,arts102, % 1st year
	cpsc210,cpsc221,cpsc213,math200,math221,phys101,arts103, 										 % 2nd year
	cpsc313,cpsc320,cpsc310,stat302,cpsc312,cpsc304,cpsc314,cpsc322,eosc114,biol111,				 % 3rd year
	cpsc410,cpsc418,cpsc317,cpsc404,cpsc311,cpsc416,arts300,arts301,arts302,arts303]).				 % 4th year

% example of failure of a transcript - missing arts (upper level credit), communications
transcript4([cpsc110,cpsc121,math100,math101,phys101,chem121,biol111,scie113,eosc114, % 1st year
	cpsc210,cpsc221,cpsc213,math200,math221,stat241,arts102,arts100,arts101,cpsc310, % 2nd year
	cpsc313,cpsc320,cpsc312,cpsc314,cpsc330,cpsc415,cpsc410,cpsc420,cpsc317,cpsc340, % 3rd year
	cpsc304,cpsc404,cpsc416,cpsc418]). 		 % 4th year

% example of failure of a transcript - missing total credit requirement
transcript5([cpsc110,cpsc121,math100,math101,phys101,chem121,biol111,wrds150,scie113,
	cpsc210,cpsc221,cpsc213,math200,math221,stat241,arts102,arts100,arts101,cpsc310,
	cpsc313,cpsc320,cpsc312,cpsc314,cpsc330,cpsc415,cpsc410,cpsc420,cpsc317,cpsc340,
	cpsc304,cpsc404,cpsc416,cpsc418,cpsc311,cpsc411,arts300]).

% example of failure of a transcript - missing upper level science, breadth
transcript6([cpsc110,cpsc121,math100,math101,chem121,biol111,wrds150,scie113,math103,
    math105,lfs150,math217,cpsc210,cpsc221,cpsc213,math200,math221,stat241,arts102,
    arts100,arts101,cpsc310,cpsc313,cpsc320,cpsc312,cpsc314,cpsc330,cpsc415,cpsc410,
    cpsc420,cpsc317,cpsc340,cpsc304,cpsc404,arts300,arts301,arts302,arts303]).