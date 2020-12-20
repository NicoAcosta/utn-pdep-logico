

%banda(Nombre, AnioDeFormacion, Localidad, Integrantes).
banda(finta, 2001, haedo, [ale, juli, gabo, ludo, anuk]).
banda(aloeVera, 2007, cordoba, [lula, bren, gaby]).
banda(losEscarabajos, 1960, losPiletones, [juan, pablo, jorge, ricardo]).
banda(plastica, 1983, palermoHollywood, [jaime, kirk, rober, lars]).
banda(oceania, 1978, lasHeras, [jose, juanito, juancito, mic, ian]).
banda(brazoFuerte, 1914, nuevaOrleans, [luis]).

% Para probar el 5
banda(banda1, 2020, buenosAires, []).
banda(banda2, 2020, buenosAires, []).
banda(banda3, 2020, buenosAires, []).
banda(banda4, 2020, buenosAires, []).
banda(banda5, 2020, buenosAires, []).
banda(banda6, 2020, buenosAires, []).
banda(banda7, 2020, buenosAires, []).
banda(banda8, 2020, buenosAires, []).
banda(banda9, 2020, buenosAires, []).
banda(banda10, 2020, buenosAires, []).
banda(banda11, 2020, buenosAires, []).

% 6
banda(lasLiendres, 1988, palomar, [andy, gus, migue, sebas, juan]).
banda(monoJugo, 1982, buenosAires, [gus, equis, carlitos]).




%pop(CantidadDeHits, CantidadDeDiscos)
%rock(TipoDeRock, Decada)
%jazz(Instrumentos)

%genero(NombreBanda, Genero).
genero(finta, pop(20, 7)).
genero(losEscarabajos, rock(mixto ,60)).
genero(plastica, rock(heavy, 80)).
genero(oceania, rock(glam, 80)).
genero(brazofuerte, jazz([trompeta, corneta])).

% 6
genero(monoJugo, rock(glam, 80)).





%festivalMusicalEn(NombreFestival, Localidad).
festivalMusical(mangueraMusmanoRockFestival, cordoba). 
festivalMusical(nueveAuxilios, haedo).

% Para testear el 4
festivalMusical(bsAsJazz, buenosAires).

% 6
festivalMusical(hullabalooza, camposVerdes).




%bandaConfirmadaPara(Banda, Festival).
bandaConfirmadaPara(finta, mangueraMusmanoRockFestival).
bandaConfirmadaPara(aloeVera, mangueraMusmanoRockFestival).
bandaConfirmadaPara(mariaLaCuerda, mangueraMusmanoRockFestival).
bandaConfirmadaPara(reyesDeLaEraDelHielo, mangueraMusmanoRockFestival).
bandaConfirmadaPara(cantoRodado, nueveAuxilios).
bandaConfirmadaPara(lasLiendres, nueveAuxilios).
bandaConfirmadaPara(juanPrincipe, nueveAuxilios).
bandaConfirmadaPara(fluidoVerde, nueveAuxilios).

% Para testear el 4
bandaConfirmadaPara(oceania, bsAsJazz).
bandaConfirmadaPara(losEscarabajos, bsAsJazz).

% 6
bandaConfirmadaPara(losEscarabajos, hullabalooza).
bandaConfirmadaPara(plastica, hullabalooza).
bandaConfirmadaPara(oceania, hullabalooza).





%----   
%----   1
%----   

exitoPorGenero(pop(CantidadDeHits, CantidadDeDiscos)):-
    Promedio is CantidadDeHits / CantidadDeDiscos,
    Promedio >= 4.

exitoPorGenero(rock(mixto, _)).
exitoPorGenero(rock(glam, 80)).

exitoPorGenero(jazz(Instrumentos)):-
    member(trompeta, Instrumentos).


esExitosa(UnaBanda):-
    genero(UnaBanda, UnGenero),
    exitoPorGenero(UnGenero).




%----   
%----   2
%----   

anioDeFormacionEntre(UnaBanda, CotaInferior, CotaSuperior):-
    banda(UnaBanda, UnAnioDeFormacion, _, _),
    between(CotaInferior, CotaSuperior, UnAnioDeFormacion).

cantidadDeIntegrantes(UnaBanda, CantidadDeIntegrantes):-
    banda(UnaBanda, _, _, UnosIntegrantes),
    length(UnosIntegrantes, CantidadDeIntegrantes).

condicionEterna(UnaBanda):-
    anioDeFormacionEntre(UnaBanda, 1960, 1980).

condicionEterna(UnaBanda):-
    cantidadDeIntegrantes(UnaBanda, 4).


seraEterna(UnaBanda):-
    esExitosa(UnaBanda),
    condicionEterna(UnaBanda).




%----   
%----   3
%----   

leConvieneParticipar(UnaBanda, UnFestival):-
    banda(UnaBanda, _, Localidad, _),
    festivalMusical(UnFestival, Localidad),
    not(bandaConfirmadaPara(UnaBanda, UnFestival)).




%----   
%----   4
%----   

seGraba(UnFestival):-
    festivalMusical(UnFestival, _),
    forall(
        bandaConfirmadaPara(UnaBanda, UnFestival),
        seraEterna(UnaBanda)
    ).




%----   
%----   5
%----   

bandasNuevasEnUnAnio(UnAnio, CantidadDeBandasNuevas):-
    findall(
        Banda,
        banda(Banda, UnAnio, _, _),
        BandasNuevas
    ),
    length(BandasNuevas, CantidadDeBandasNuevas).


anioHistorico(UnAnio):-
    banda(_, UnAnio, _, _),
    bandasNuevasEnUnAnio(UnAnio, CantidadDeBandasNuevas),
    CantidadDeBandasNuevas > 10.



% Solo para testear y no tener 10 veces repetido en la consola
aniosHistoricosSinRepetir(AniosHistoricosSinRepetir):-
    findall(
        UnaAnio,
        anioHistorico(UnaAnio),
        AniosHistoricos
    ),
    list_to_set(AniosHistoricos, AniosHistoricosSinRepetir).


%   ----    FIN    ----

laMasGrandeDelFestival(UnaBanda,Festival):-
    festivalMusical(Festival,_),
    totalDeIntegrantesDe(UnaBanda,UnTotal),
    not((bandaConfirmadaPara(OtraBanda,Festival),totalDeIntegrantesDe(OtraBanda,OtroTotal),OtroTotal>UnTotal)).
    
laMasNumerosa(Festival,Banda):-
    bandaConfirmadaPara(Banda,Festival),
    laMasGrandeDelFestival(Banda,Festival).

totalDeIntegrantesDe(Banda,Total):-
    banda(Banda,_,_,Integrantes),
    length(Integrantes,Total).


