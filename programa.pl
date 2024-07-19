% Aquí va el código.

% natacion: estilos(lista), metros nadados, medallas
practica(ana, natacion([pecho, crawl], 1200, 10)).
practica(luis, natacion([perrito], 200, 0)).
practica(vicky, natacion([crawl, mariposa, pecho, espalda], 800, 0)).

% fulbol: medallas, goles marcados, veces que fue expulsado
practica(deby, fulbol(2, 15, 5)).
practica(mati, fulbol(1, 11, 7)).

% rugby: posicion que ocupa, medallas
practica(zaffa, rugby(pilar, 0)).

% nos interesa el handicap del polista, no tiene medallas
practica(gise, polo(8)). % -> agregamos un nuevo deporte y el programa sigue funcionando!!

% PUNTO 1) ¿Quienes son nadadores?

esNadador(Quien) :- practica(Quien, natacion(_,_,_)).

nadadores(Quien) :-
    practica(Quien, Deporte), % el nadador practica deporte
    nadador(Deporte).       

nadador(natacion(_,_,_)).
fulbolista(fulbol(_,_,_)).
rugbier(rugby(_,_)).

% PUNTO 2) Medallas Obtenidas

medallas(Alguien, Medallas) :-
    practica(Alguien, Deporte),
    cuantasMedallas(Deporte, Medallas).

cuantasMedallas(natacion(_,_,Medallas), Medallas).
cuantasMedallas(fulbol(Medallas,_,_), Medallas).
cuantasMedallas(rugby(_,Medallas), Medallas).

% PUNTO 3) Buen deportista
% natacion --> si recorren mas de 1.000 metros diarios o nadan mas de 3 estilos
% fulbol --> si la diferencia de goles menos las expulsiones suman mas de 5
% rugby --> si son wings o pilares
% polo --> si tiene hadicap mayor a 6

esBuenDeportista(Alguien) :-
    practica(Alguien, Deporte),
    esBueno(Deporte).

esBueno(natacion(_,Metros,_)) :- Metros > 1000.

esBueno(natacion(Estilos,_,_)) :- 
    length(Estilos, Cantidad), 
    Cantidad > 3.

esBueno(fulbol(_, Goles, Explusiones)) :- 
    Diferencia is Goles - Explusiones,
    Diferencia > 5.

esBueno(rugby(wing,_)).
esBueno(rugby(pilar,_)).
esBueno(rugby(Posicion,_)) :- member(Posicion, [wing, pilar]).

esBueno(polo(Handicap)) :- Handicap > 6.
