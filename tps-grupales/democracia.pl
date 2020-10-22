/*

Consignas:

https://docs.google.com/document/d/1bblUbyuVNoGQKDRVq0usSkHEIts7WXNrkTMQlnkJC9w/edit#

*/


% -----
% -----     PUNTO 1
% -----


% partido(Candidato, Partido)
partido(frank, rojo).
partido(claire, rojo).
partido(garrett, azul).
partido(jackie, amarillo).
partido(linda, azul).
partido(catherine, rojo).
partido(seth, amarillo).
partido(heather, amarillo).

% Peter no es candidato del partido amarillo. No se expresa en la base de conocimientos ya que solo tenemos en cuenta aquellas cosas que consideramos verdaderas, no las que consideramos que no lo son.

% El partido violeta no tiene candidatos. No se expresa en la base de conocimientos
% porque solo tenemos en cuenta los candidatos que son de un partido (los partidos que tienen al menos un candidato).
% Se podría obtener que no hay ningún candidato del partido violeta haciendo la consulta
% partido(_, violeta) -> false.

% edad(Candidato, Edad)
edad(frank, 50).
edad(claire, 52).
edad(garrett, 64).
edad(peter, 26).
edad(jackie, 38).
edad(linda, 30).
edad(catherine, 59).

% Heather nació en 1969. No lo tenemos en cuenta ya que el parámetro que tomamos con los candidatos es la edad, no el año de nacimiento.
% Al día de hoy, podría tener 50 o 51 años, y no podemos asumir uno de ellos.


% -----------------------------------------

% sePostulaEn(Partido, Provincia)

sePostulaEn(azul, buenosAires).
sePostulaEn(azul, chaco).
sePostulaEn(azul, tierraDelFuego).
sePostulaEn(azul, sanLuis).
sePostulaEn(azul, neuquen).

sePostulaEn(rojo, buenosAires).
sePostulaEn(rojo, santaFe).
sePostulaEn(rojo, cordoba).
sePostulaEn(rojo, chubut).
sePostulaEn(rojo, tierraDelFuego).
sePostulaEn(rojo, sanLuis).

sePostulaEn(amarillo, chaco).
sePostulaEn(amarillo, formosa).
sePostulaEn(amarillo, tucuman).
sePostulaEn(amarillo, salta).
sePostulaEn(amarillo, santaCruz).
sePostulaEn(amarillo, laPampa).
sePostulaEn(amarillo, corrientes).
sePostulaEn(amarillo, misiones).
sePostulaEn(amarillo, buenosAires).


% -----------------------------------------


habitantes(buenosAires, 15355000).
habitantes(chaco, 1143201).
habitantes(tierraDelFuego, 160720).
habitantes(sanLuis, 489255).
habitantes(neuquen, 637913).
habitantes(santaFe, 3397532).
habitantes(cordoba, 3567654).
habitantes(chubut, 577466).
habitantes(formosa, 527895).
habitantes(tucuman, 1687305).
habitantes(salta, 1333365).
habitantes(santaCruz, 273964).
habitantes(laPampa, 349299).
habitantes(corrientes, 992595).
habitantes(misiones, 1189446).



% -----
% -----     PUNTO 2
% -----



esPicante(Provincia):-
    sePostulaEn(UnPartido, Provincia),
    sePostulaEn(OtroPartido, Provincia),
    UnPartido \= OtroPartido,
    habitantes(Provincia, CantidadHabitantes),
    CantidadHabitantes > 1000000.



% -----
% -----     PUNTO 3
% -----

% intencionDeVotoEn(Provincia, Partido, Porcentaje)
intencionDeVotoEn(buenosAires, rojo, 40).
intencionDeVotoEn(buenosAires, azul, 30).
intencionDeVotoEn(buenosAires, amarillo, 30).
intencionDeVotoEn(chaco, rojo, 50).
intencionDeVotoEn(chaco, azul, 20).
intencionDeVotoEn(chaco, amarillo, 0).
intencionDeVotoEn(tierraDelFuego, rojo, 40).
intencionDeVotoEn(tierraDelFuego, azul, 20).
intencionDeVotoEn(tierraDelFuego, amarillo, 10).
intencionDeVotoEn(sanLuis, rojo, 50).
intencionDeVotoEn(sanLuis, azul, 20).
intencionDeVotoEn(sanLuis, amarillo, 0).
intencionDeVotoEn(neuquen, rojo, 80).
intencionDeVotoEn(neuquen, azul, 10).
intencionDeVotoEn(neuquen, amarillo, 0).
intencionDeVotoEn(santaFe, rojo, 20).
intencionDeVotoEn(santaFe, azul, 40).
intencionDeVotoEn(santaFe, amarillo, 40).
intencionDeVotoEn(cordoba, rojo, 10).
intencionDeVotoEn(cordoba, azul, 60).
intencionDeVotoEn(cordoba, amarillo, 20).
intencionDeVotoEn(chubut, rojo, 15).
intencionDeVotoEn(chubut, azul, 15).
intencionDeVotoEn(chubut, amarillo, 15).
intencionDeVotoEn(formosa, rojo, 0).
intencionDeVotoEn(formosa, azul, 0).
intencionDeVotoEn(formosa, amarillo, 0).
intencionDeVotoEn(tucuman, rojo, 40).
intencionDeVotoEn(tucuman, azul, 40).
intencionDeVotoEn(tucuman, amarillo, 20).
intencionDeVotoEn(salta, rojo, 30).
intencionDeVotoEn(salta, azul, 60).
intencionDeVotoEn(salta, amarillo, 10).
intencionDeVotoEn(santaCruz, rojo, 10).
intencionDeVotoEn(santaCruz, azul, 20).
intencionDeVotoEn(santaCruz, amarillo, 30).
intencionDeVotoEn(laPampa, rojo, 25).
intencionDeVotoEn(laPampa, azul, 25).
intencionDeVotoEn(laPampa, amarillo, 40).
intencionDeVotoEn(corrientes, rojo, 30).
intencionDeVotoEn(corrientes, azul, 30).
intencionDeVotoEn(corrientes, amarillo, 10).
intencionDeVotoEn(misiones, rojo, 90).
intencionDeVotoEn(misiones, azul, 0).
intencionDeVotoEn(misiones, amarillo, 0).


% -----------------------------------------
sePostulanMismaProvincia(UnPartido,OtroPartido,Provincia):-
    sePostulaEn(UnPartido,Provincia),
    sePostulaEn(OtroPartido,Provincia).

leGanaA(UnCandidato, OtroCandidato, Provincia):-
    partido(UnCandidato, MismoPartido),
    partido(OtroCandidato, MismoPartido),
    sePostulaEn(MismoPartido, Provincia).

leGanaA(UnCandidato, OtroCandidato,Provincia):-
    partido(UnCandidato, UnPartido),
    partido(OtroCandidato, OtroPartido),
    sePostulanMismaProvincia(UnPartido, OtroPartido, Provincia),
    intencionDeVotoEn(Provincia, UnPartido, UnPorcentaje),
    intencionDeVotoEn(Provincia, OtroPartido, OtroPorcentaje),
    UnPorcentaje > OtroPorcentaje.

leGanaA(UnCandidato, OtroCandidato, Provincia):-
    partido(UnCandidato, UnPartido),
    sePostulaEn(UnPartido, Provincia),
    partido(OtroCandidato, OtroPartido),
    not(sePostulaEn(OtroPartido, Provincia)).
    


% -----
% -----     PUNTO 4
% -----



elGranCandidato(UnCandidato):-
    esElMasJovenDeSuPartido(UnCandidato),
    ganaSiempre(UnCandidato).

esMasJovenQue(Joven, Viejo):-
    edad(Joven, EdadJoven),
    edad(Viejo, EdadViejo),
    EdadJoven < EdadViejo.

esMasJovenQue(MismoCandidato, MismoCandidato).

esElMasJovenDeSuPartido(UnCandidato):-
    partido(UnCandidato, Partido),
    forall(partido(OtroCandidato, Partido), esMasJovenQue(UnCandidato, OtroCandidato)).

ganaEn(UnCandidato, Provincia):-
    forall(partido(OtroCandidato, _), leGanaA(UnCandidato, OtroCandidato, Provincia)).

ganaSiempre(UnCandidato):-
    partido(UnCandidato, Partido),
    forall(sePostulaEn(Partido, Provincia), ganaEn(UnCandidato, Provincia)).



% -----
% -----     PUNTO 5
% -----



tieneMayorIntencionDeVotoQue(UnPartido, OtroPartido, Provincia):-
    intencionDeVotoEn(Provincia, UnPartido, UnPorcentaje),
    intencionDeVotoEn(Provincia, OtroPartido, OtroPorcentaje),
    UnPorcentaje > OtroPorcentaje.

tieneMayorIntencionDeVotoQue(MismoPartido, MismoPartido, _).

partidoGanabaEn(Partido, Provincia):-
    forall(intencionDeVotoEn(Provincia, OtroPartido, _), tieneMayorIntencionDeVotoQue(Partido, OtroPartido, Provincia)).

ajusteConsultora(Partido, Provincia, VerdaderoPorcentaje):-
    partidoGanabaEn(Partido, Provincia),
    intencionDeVotoEn(Provincia, Partido, PorcentajePrevio),
    VerdaderoPorcentaje is PorcentajePrevio - 20 .

ajusteConsultora(Partido, Provincia, VerdaderoPorcentaje):-
    intencionDeVotoEn(Provincia, Partido, PorcentajePrevio),
    not(partidoGanabaEn(Partido, Provincia)),
    VerdaderoPorcentaje is PorcentajePrevio + 5 .



% -----
% -----     PUNTO 6
% -----



% Functores Promesas 
% inflacion(cotaInferior, cotaSuperior)
% construir(listaDeObras)
% nuevosPuestosDeTrabajo(cantidad)
% edilicio(Construccion,Cantidad)

% CONSTRUIR
promete(azul, construir([edilicio(hospital, 1000), edilicio(jardin, 100), edilicio(escuela, 5)])).
promete(amarillo, construir([edilicio(hospital, 100), edilicio(universidad, 1), edilicio(comisaria, 200)])).

% PUESTOS DE TRABAJO
promete(rojo, nuevosPuestosDeTrabajo(800000)).
promete(amarillo, nuevosPuestosDeTrabajo(10000)).

% INFLACION
promete(azul, inflacion(2, 4)).
promete(amarillo, inflacion(1, 15)).
promete(rojo ,inflacion(10, 30)).



% -----
% -----     PUNTO 7
% -----



influenciaDePromesas(inflacion(CotaInferior, CotaSuperior), Influencia):-
    Influencia is -(CotaInferior + CotaSuperior) / 2.

influenciaDePromesas(nuevosPuestosDeTrabajo(Cantidad), Influencia):-
    Cantidad > 50000,
    Influencia is 3.

influenciaDePromesas(construir(Edificios), Influencia):-
    findall(InfluenciaParcial, influenciaPorEdilicio(Edificios, InfluenciaParcial), InfluenciasParciales),
    sum_list(InfluenciasParciales, SumaInfluencias),
    Influencia is SumaInfluencias.

influenciaPorEdilicio(Edificios, Influencia):-
    member(edilicio(hospital, _), Edificios),
    Influencia is 2.

influenciaPorEdilicio(Edificios, Influencia):-
    member(edilicio(jardin, Cantidad), Edificios),
    Influencia is (Cantidad / 10).

influenciaPorEdilicio(Edificios, Influencia):-
    member(edilicio(escuela, Cantidad), Edificios),
    Influencia is (Cantidad / 10).

influenciaPorEdilicio(Edificios, Influencia):-
    member(edilicio(comisaria, 200), Edificios),
    Influencia is 2.

influenciaPorEdilicio(Edificios, Influencia):-
    findall(Edilicio, (member(edilicio(Edilicio, _), Edificios), edilicioInnecesario(Edilicio)), EdiliciosInnecesarios),
    length(EdiliciosInnecesarios, CantidadInnecesarios),
    Influencia is - CantidadInnecesarios.

edilicioInnecesario(Edilicio):-
    not(member(Edilicio, [hospital, jardin, escuela, comisaria, universidad])).



% -----
% -----     PUNTO 8
% -----



promedioDeCrecimiento(UnPartido, Crecimiento):-
    findall(InfluenciaParcial, (promete(UnPartido, UnaPromesa), influenciaDePromesas(UnaPromesa, InfluenciaParcial)), InfluenciasParciales),
    sum_list(InfluenciasParciales, Crecimiento).