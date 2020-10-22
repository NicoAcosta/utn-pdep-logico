%vende(Empresa, EstiloDeViaje, Destino).
vende(mcs, crucero(10), rioDeJaneiro).
vende(mcs, crucero(20), mykonos).
vende(vacaviones, allInclusive(burjAlArab), dubai).
vende(vacaviones, allInclusive(wyndhamPlayaDelCarmen), playaDelCarmen).
vende(moxileres, mochila([carpa, bolsaDeDormir, linterna]), elBolson).
vende(moxileres, mochila([camara, cantimplora, protectorSolar, malla]), puntaDelDiablo).
vende(tuViaje, clasico(primavera, avion), madrid).
vende(tuViaje, clasico(verano, micro), villaGesell).
vende(destina3, clasico(_, avion), londres).
vende(destina3, clasico(_, avion), filadelfia).
vende(pdepViajes, mochila([repelenteDeInsectos, adaptadorElectrico, malla, bucito]), colombo).


%crucero(CantidadDeDias).
%allInclusive(Hotel).
%mochila(Objetos).
%clasico(Temporada, MedioDeTransporte).

%continente(Destino, Continente).
continente(rioDeJaneiro, sudAmerica).
continente(mykonos, europa).
continente(dubai, asia).
continente(playaDelCarmen, centroAmerica).
continente(puntaDelDiablo, sudAmerica).
continente(sydney, oceania).
continente(madagascar, africa).
continente(madrid, europa).
continente(londres, europa).
continente(filadelfia, norteAmerica).

%moneda(Destino, Moneda).
moneda(rioDeJaneiro, real).
moneda(miami, dolar).
moneda(shenzhen, renminbi).
moneda(londres, libra).
moneda(colombo, rupia).

%cambioAPesos(Moneda, Conversion).
cambioAPesos(real, 11).
cambioAPesos(dolar, 44).
cambioAPesos(pesoMexicano, 2).
cambioAPesos(ariaryMalgache, 0.012).
cambioAPesos(libra, 54).


% ----------------------------------------------

viajaA(Empresa, Continente):-
    vende(Empresa, _, UnDestino),
    vende(Empresa, _, OtroDestino),
    UnDestino \= OtroDestino,
    continente(UnDestino, Continente),
    continente(OtroDestino, Continente).
    
conversionDeUnDestino(Destino, Conversion):-
    moneda(Destino, Moneda),
    cambioAPesos(Moneda, Conversion).

esMasEconomico(UnDestino, OtroDestino):-
    conversionDeUnDestino(UnDestino, UnaConversion),
    conversionDeUnDestino(OtroDestino, OtraConversion),
    UnaConversion < OtraConversion.

conviene(Destino):-
    conversionDeUnDestino(Destino, Conversion),
    Conversion < 1,
    not(continente(Destino, europa)).

elDestinoMasPopular(Empresa, UnDestino):-
    vende(Empresa, _, UnDestino),
    forall((vende(Empresa, _, OtroDestino), UnDestino \= OtroDestino), esMasEconomico(UnDestino, OtroDestino)).
    %forall((vende(Empresa, _, OtroDestino), UnDestino \= OtroDestino), esMasEconomico(UnDestino, OtroDestino)).

ventaExtravagante(Destino):-
    not(conviene(Destino)),
    vende(_, Estilo, Destino),
    condicionExtravagante(Estilo),
    not(vende(_, clasico(_, _), Destino)).

condicionExtravagante(crucero(CantidadDeDias)):-
    CantidadDeDias > 365.

condicionExtravagante(mochila([])).

condicionExtravagante(allInclusive(Hotel)):-
    hotelExtravagante(Hotel).

hotelExtravagante(burjAlArab).
hotelExtravagante(pangu).


nivelExtravagancia(Empresa, Nivel):-
    findall(Destino, (vende(Empresa, _, Destino), ventaExtravagante(Destino)), DestinosExtravagantes),
    length(DestinosExtravagantes, Cantidad),
    Nivel is Cantidad * 8.

