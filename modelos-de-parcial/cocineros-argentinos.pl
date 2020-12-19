principal(nioquis, 50).
principal(pizza, 100).
postre(panqueque, dulceDeLeche, 100).
postre(trufas, dulceDeLeche, 60).
postre(pastelito, dulceDeMembrillo, 50).
postre(torta, zanahoria, 60).
entrada(ensalada, [tomate, zanahoria, lechuga], 70).
entrada(empanada, [carne, cebolla, papa], 50).


%cocina(nombre, plato, puntos)
cocina(mariano, principal(nioquis, 50), 80). 
cocina(julia, principal(pizza, 100), 60).
cocina(hernan, postre(panqueque, dulceDeLeche, 100), 60).
cocina(hernan, postre(trufas, dulceDeLeche, 60), 80).
cocina(hernan, entrada(ensalada, [tomate, zanahoria, lechuga], 70), 29).
cocina(susana, entrada(empanada, [carne, cebolla, papa], 50), 50).
cocina(susana, postre(pastelito, dulceDeMembrillo, 50), 60).
cocina(melina, postre(torta, zanahoria, 60),50).

amigo(mariano, susana).
amigo(mariano, hernan).
amigo(hernan, pedro).
amigo(melina, carlos).
amigo(carlos, susana).

popular(carne).
popular(dulceDeLeche).
popular(dulceDeMembrillo).




% calorias(postre(_, _, Calorias), Calorias).
% calorias(entrada(_, _, Calorias), Calorias).
% calorias(principal(_, Calorias), Calorias).


nombre(entrada(Nombre, _, _), Nombre).
nombre(principal(Nombre, _), Nombre).
nombre(postre(Nombre, _, _), Nombre).



%-----
%-----  1
%-----

saludable(Comida):-
    postre(Comida, _, Calorias),
    Calorias < 100.

saludable(Comida):-
    entrada(Comida, _, Calorias),
    Calorias =< 60.

saludable(Comida):-
    principal(Comida, Calorias),
    between(70, 90, Calorias).    

saludable(postre(_, _, Calorias)):-
    Calorias < 100.

saludable(entrada(_, _, Calorias)):-
    Calorias =< 60.

saludable(principal(_, Calorias)):-
    between(70, 90, Calorias).   




%-----
%-----  2
%-----

salado(entrada(_, _, _)).
salado(principal(_, _, _)).

soloSalado(Cocinero):-
    cocina(Cocinero, _, _),
    forall(
        cocina(Cocinero, Comida, _),
        salado(Comida)
    ).




%-----
%-----  3
%-----

puntuacion(Cocinero, Puntuacion):-
    cocina(Cocinero, _, _),
    findall(
        Puntos,
        cocina(Cocinero, _, Puntos),
        ListaDePuntos
    ),
    sumlist(ListaDePuntos, Puntuacion).
    

tieneUnaGranFama(Cocinero):-
    cocina(Cocinero, _, _),
    puntuacion(Cocinero, Puntuacion),
    forall(
        (cocina(OtroCocinero, _, _), Cocinero \= OtroCocinero, puntuacion(OtroCocinero, OtraPuntuacion)),
        OtraPuntuacion < Puntuacion
    ).

%%%%% ooo...

maximaPuntuacion(MaxPuntuacion):-
    findall(
        Puntuacion,
        (cocina(Cocinero, _, _), puntuacion(Cocinero, Puntuacion)),
        Puntuaciones
    ),
    max_list(Puntuaciones, MaxPuntuacion).


tieneUnaGranFama2(Cocinero):-
    cocina(Cocinero, _, _),
    puntuacion(Cocinero, Puntuacion),
    maximaPuntuacion(Puntuacion).




%-----
%-----  4
%-----

noEsSaludable(Cocinero):-
    cocina(Cocinero, ComidaSaludable, _),
    saludable(ComidaSaludable),
    not((
        cocina(Cocinero, OtraComida, _),
        OtraComida \= ComidaSaludable,
        saludable(OtraComida)
    )).

comidasSaludables(Cocinero, Comidas):-
    cocina(Cocinero, _, _),
    findall(
        Comida,
        (cocina(Cocinero, Comida, _), saludable(Comida)),
        Comidas
    ).

noEsSaludable2(Cocinero):-
    comidasSaludables(Cocinero, ComidasSaludables),
    length(ComidasSaludables, 1).




%-----
%-----  5
%-----

tieneIngrediente(entrada(_, Ingredientes, _), Ingrediente):-
    member(Ingrediente, Ingredientes).
tieneIngrediente(postre(_, Ingrediente, _), Ingrediente).

tieneIngredientePopular(Plato):-
    tieneIngrediente(Plato, Ingrediente),
    popular(Ingrediente).

noUsaIngredientesPopulares(Cocinero):-
    cocina(Cocinero, Plato, _),
    not((
        tieneIngredientePopular(Plato)
    )).




%-----
%-----  6
%-----

incidencia(Cocinero, Ingrediente, Cantidad):-
    cocina(Cocinero, _, _),
    findall(
        Plato,
        (
            cocina(Cocinero, Plato, _),
            tieneIngrediente(Plato, Ingrediente)    
        ),
        Platos
    ),
    sumlist(Platos, Cantidad).

maximaIncidenciaPopular(Cocinero, Cantidad):-
    cocina(Cocinero, _, _),
    findall(
        Incidencia,
        (
            popular(Ingrediente),
            incidencia(Cocinero, Ingrediente, Incidencia)
        ),
        Incidencias
    ),
    max_list(Incidencias, Cantidad).
    

ingredientePopularMasUsado(Cocinero, Ingrediente):-
    cocina(Cocinero, _, _),
    incidencia(Cocinero, Ingrediente, Incidencia),
    maximaIncidenciaPopular(Cocinero, Incidencia).
    
    
 




