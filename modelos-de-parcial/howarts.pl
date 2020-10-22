
/*  
    ---
    ---     Parte 1
    ---
*/

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

caracteristicas(harry, [coraje, amistoso, orgullo, inteligencia]).
caracteristicas(draco, [inteligencia, orgullo]).
caracteristicas(hermione, [inteligencia, orgullo, responsabilidad]).

odiaria(harry, slytherin).
odiaria(draco, hufflepuff).

%%%%%%%%%%%%%%%%%%

caracteristicasPrincipales(gryffindor, [coraje]).
caracteristicasPrincipales(slytherin, [orgullo, inteligencia]).
caracteristicasPrincipales(ravenclaw, [inteligencia, responsabilidad]).
caracteristicasPrincipales(hufflepuff, [amistoso]).


permiteEntrar(slytherin, Mago):-
    esDe(Mago, _),
    not(sangre(Mago, impura)).

permiteEntrar(OtraCasa, _):-
    OtraCasa \= slytherin.


caracterApropiado(Casa, Mago):-
    caracteristicas(Mago, CaracteristicasDelMago),
    caracteristicasPrincipales(Casa, CaracteristicasDeLaCasa),
    forall(member(Caracteristica, CaracteristicasDeLaCasa), member(Caracteristica, CaracteristicasDelMago)).


puedeQuedarSeleccionado(gryffindor, hermione).

puedeQuedarSeleccionado(Casa, Mago):-
    caracterApropiado(Casa, Mago),
    permiteEntrar(Casa, Mago),
    not(odiaria(Mago, Casa)).

cadenaDeAmistades(Lista):-
    forall(member(Mago, Lista), caracteristicas(Mago, amistoso)).



/*  
    ---
    ---     Parte 2
    ---
*/


accion(harry,      fueraDeCama).
accion(hermione,   irA(tercerPiso)).
accion(hermione,   irA(seccionRestringidaBiblioteca)).
accion(harry,      irA(bosque)).
accion(harry,      irA(tercerPiso)).
accion(draco,      irA(mazmorras)).
accion(ron,        ganarAjedrezMagico).
accion(hermione,   salvarAmigos).
accion(harry,      ganarAVoldemort).

accion(hermione, pregunta("Donde se encuentra un Bezoar", 20, snape)).
accion(hermione, pregunta("Como hacer levitar una pluma", 25, flitwick)).


puntos(ganarAjedrezMagico, 50).
puntos(salvarAmigos, 50).
puntos(ganarAVoldemort, 60).

puntos(fueraDeCama, -50).

puntos(irA(Lugar), Puntos):-
    puntosPorLugarProhibido(Lugar, PuntosLugar),
    Puntos is PuntosLugar.

puntos(pregunta(_, Dificultad, Profesor), Puntos):-
    puntosPorPregunta(Dificultad, Profesor, PuntosPregunta),
    Puntos is PuntosPregunta.


puntosPorLugarProhibido(tercerPiso, -75).
puntosPorLugarProhibido(seccionRestringidaBiblioteca, -10).
puntosPorLugarProhibido(bosque, -50).


esMalaAccion(Accion):-
    puntos(Accion, Puntos),
    Puntos < 0.


esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).


esBuenAlumno(Mago):-
    esDe(Mago, _),
    forall(accion(Mago, Accion), not(esMalaAccion(Accion))).


esAccionRecurrente(Accion):-
    accion(UnMago, Accion),
    accion(OtroMago, Accion),
    UnMago \= OtroMago.


puntosMago(Mago, SumaPuntos):-
    esDe(Mago, _),
    findall(    Puntos,
                (accion(Mago, Accion), puntos(Accion, Puntos)),
                ListaPuntos),
    sum_list(ListaPuntos, SumaPuntos).


puntosCasa(Casa, SumaPuntos):-
    esDe(_, Casa),
    findall(    Puntos,
                (esDe(Mago, Casa), puntosMago(Mago, Puntos)),
                ListaPuntos),
    sum_list(ListaPuntos, SumaPuntos).


ganadoraDeLaCopa(UnaCasa):-
    puntosCasa(UnaCasa, UnosPuntos),
    forall( (esDe(_, OtraCasa), UnaCasa \= OtraCasa, puntosCasa(OtraCasa, OtrosPuntos)),
            (puntosCasa(OtraCasa, OtrosPuntos), UnosPuntos > OtrosPuntos)).


puntosPorPregunta(Dificultad, snape, Puntos):-
    Puntos is (Dificultad / 2).

puntosPorPregunta(Dificultad, Profesor, Puntos):-
    Profesor \= snape,
    Puntos is Dificultad.