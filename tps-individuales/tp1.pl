%
%   1
%

viveEnMansion(agatha).
viveEnMansion(carnicero).
viveEnMansion(charles).


odiaA(agatha, Odiado):-
    viveEnMansion(Odiado),
    Odiado \= carnicero.

odiaA(charles, Odiado):-
    viveEnMansion(Odiado),
    not(odiaA(agatha, Odiado)).

odiaA(carnicero, Odiado):-
    odiaA(agatha, Odiado).

esMasRicoQue(Rico, agatha):-
    viveEnMansion(Rico),
    not(odiaA(carnicero, Rico)).

esAsesinoDe(Victimario, Victima):-
    viveEnMansion(Victimario),
    odiaA(Victimario, Victima),
    not(esMasRicoQue(Victimario, Victima)).

/*

?- esAsesinoDe(Asesino, agatha).    -->     Asesino = agatha ;
                                            false.

*/



%
%   2
%

/*

?- odiaA(_, milhouse).              -->     false.

?- odiaA(charles, Odiado).          -->     Odiado = carnicero ;
                                            false.

?- odiaA(Odiador, agatha).          -->     Odiador = agatha ;
                                            Odiador = carnicero.

?- odiaA(Odiador, Odiado).          -->     Odiador = Odiado, Odiado = agatha ;     (no entiendo por qué apareció el nombre de la variable - Supongo que deberían ser ambos agatha)
                                            Odiador = agatha, Odiado = charles ;
                                            Odiador = charles, Odiado = carnicero ;
                                            Odiador = carnicero, Odiado = agatha ;
                                            Odiador = carnicero, Odiado = charles.

?- odiaA(carnicero, _).             -->     true .

*/



%
%   Ejercicio adicional de obras
%
/*
nacionalidad(jorgeLuisBorges, argentina).
nacionalidad(marioBenedetti, uruguaya).

nacionalidadDelAutor(Obra, Nacionalidad):-
    escribio(Autor, Obra),
    nacionalidad(Autor, SuNacionalidad),
    SuNacionalidad == Nacionalidad.

obraRioplatense(Obra):-
    nacionalidadDelAutor(Obra, argentina).

obraRioplatense(Obra):-
    nacionalidadDelAutor(Obra, uruguaya).

*/