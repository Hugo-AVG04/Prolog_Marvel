% ====================================================================
% BASE DE CONOCIMIENTO
% Cada personaje debe tener: tipo, origen, ciudad de origen y naturaleza.
% Los identificadores se escriben en minusculas y con guion bajo.
% ====================================================================

% Categoria narrativa: heroe, antiheroe o villano.
tipo(iron_man, heroe).
tipo(spider_man, heroe).
tipo(thor, heroe).
tipo(captain_america, heroe).
tipo(vision, heroe).
tipo(daredevil, heroe).
tipo(jean_grey, heroe).
tipo(scarlet_witch, heroe).

tipo(loki, antiheroe).
tipo(deadpool, antiheroe).
tipo(venom, antiheroe).
tipo(winter_soldier, antiheroe).
tipo(punisher, antiheroe).
tipo(emma_frost, antiheroe).
tipo(polaris, antiheroe).

tipo(kingpin, villano).
tipo(thanos, villano).
tipo(magneto, villano).
tipo(ultron, villano).
tipo(agatha_harkness, villano).
tipo(hela, villano).
tipo(apocalipsis, villano).
tipo(sinister, villano).

% Planeta, reino o mundo de procedencia.
origen(iron_man, tierra).
origen(spider_man, tierra).
origen(thor, asgard).
origen(captain_america, tierra).
origen(vision, tierra).
origen(daredevil, tierra).
origen(jean_grey, tierra).
origen(scarlet_witch, tierra).
origen(loki, asgard).
origen(deadpool, tierra).
origen(venom, tierra).
origen(winter_soldier, tierra).
origen(punisher, tierra).
origen(emma_frost, tierra).
origen(polaris, tierra).
origen(kingpin, tierra).
origen(thanos, titan).
origen(magneto, tierra).
origen(ultron, tierra).
origen(agatha_harkness, tierra).
origen(hela, hel).
origen(apocalipsis, titan).
origen(sinister, tierra).

% Ciudad o localidad de origen conocida.
ciudad_origen(iron_man, long_island).
ciudad_origen(spider_man, queens).
ciudad_origen(thor, asgard).
ciudad_origen(captain_america, brooklyn).
ciudad_origen(vision, new_york).
ciudad_origen(daredevil, hells_kitchen).
ciudad_origen(jean_grey, annandale_on_hudson).
ciudad_origen(scarlet_witch, novi_pazar).
ciudad_origen(loki, jotunheim).
ciudad_origen(deadpool, regina).
ciudad_origen(venom, san_francisco).
ciudad_origen(winter_soldier, shelbyville).
ciudad_origen(punisher, new_york).
ciudad_origen(emma_frost, boston).
ciudad_origen(polaris, san_francisco).
ciudad_origen(kingpin, new_york).
ciudad_origen(thanos, titan).
ciudad_origen(magneto, nuremberg).
ciudad_origen(ultron, new_york).
ciudad_origen(agatha_harkness, salem).
ciudad_origen(hela, asgard).
ciudad_origen(apocalipsis, akkaba).
ciudad_origen(sinister, london).

% Naturaleza, especie o condicion del personaje.
tipo_personaje(iron_man, humano).
tipo_personaje(spider_man, humano_modificado).
tipo_personaje(thor, asgardiano).
tipo_personaje(captain_america, humano_modificado).
tipo_personaje(vision, androide).
tipo_personaje(daredevil, humano_mutado).
tipo_personaje(jean_grey, mutante).
tipo_personaje(scarlet_witch, bruja).
tipo_personaje(loki, asgardiano).
tipo_personaje(deadpool, mutante).
tipo_personaje(venom, simbionte).
tipo_personaje(winter_soldier, humano_modificado).
tipo_personaje(punisher, humano).
tipo_personaje(emma_frost, mutante).
tipo_personaje(polaris, mutante).
tipo_personaje(kingpin, humano).
tipo_personaje(thanos, alien).
tipo_personaje(magneto, mutante).
tipo_personaje(ultron, androide).
tipo_personaje(agatha_harkness, bruja).
tipo_personaje(hela, asgardiana).
tipo_personaje(apocalipsis, mutante).
tipo_personaje(sinister, mutante).

% ====================================================================
% RELACIONES DIRECTAS
% Cada hecho representa un vinculo conocido entre dos personajes.
% Las reglas posteriores permiten consultar estos vinculos sin importar
% el orden de los dos personajes.
% ====================================================================

% Tutoria: mentor(Mentor, Alumno).
mentor(iron_man, spider_man).

% Companerismo y alianzas habituales.
companero(iron_man, captain_america).
companero(iron_man, thor).
companero(captain_america, thor).
companero(spider_man, daredevil).
companero(jean_grey, emma_frost).
companero(captain_america, winter_soldier).
companero(emma_frost, polaris).
companero(scarlet_witch, vision).

% Parentescos y pareja registrados como relaciones aparte.
parentesco(thor, loki, hermanos_adoptivos).
parentesco(magneto, polaris, padre_hija).
pareja(vision, scarlet_witch).

% Enemistades destacadas dentro del elenco definido en esta base.
enemigo(daredevil, kingpin).
enemigo(spider_man, kingpin).
enemigo(spider_man, venom).
enemigo(iron_man, thanos).
enemigo(iron_man, ultron).
enemigo(thor, thanos).
enemigo(thor, hela).
enemigo(thor, loki).
enemigo(captain_america, thanos).
enemigo(jean_grey, apocalipsis).
enemigo(jean_grey, sinister).
enemigo(scarlet_witch, agatha_harkness).
enemigo(deadpool, sinister).
enemigo(punisher, kingpin).
enemigo(polaris, magneto).

% ====================================================================
% REGLAS DE INFERENCIA Y CONSULTA
% Una regla se escribe como cabeza :- condiciones. Se cumple cuando
% Prolog puede demostrar todas sus condiciones (de izquierda a derecha).
% Las variables empiezan con mayuscula; los atomos, con minuscula.
% Para probar una regla, escribe una consulta con ?- en SWI-Prolog.
% ====================================================================

% personaje(X): X es un personaje si aparece en algun hecho tipo/2.
% Ejemplo: ?- personaje(spider_man).       % comprueba un personaje concreto
%          ?- personaje(Personaje).        % enumera los personajes registrados
personaje(X) :-
    tipo(X, _).

% parametros_completos(X): existe un registro de categoria, origen, ciudad
% y naturaleza para X. El guion bajo (_) significa "un valor cualquiera".
% Ejemplo: ?- parametros_completos(spider_man).
parametros_completos(X) :-
    tipo(X, _),
    origen(X, _),
    ciudad_origen(X, _),
    tipo_personaje(X, _).

% faltan_datos(X): X esta registrado como personaje, pero Prolog no puede
% demostrar que tenga los cuatro parametros anteriores. No indica cual falta.
% \+ significa negacion por fallo: la prueba de la meta no tuvo exito.
% Ejemplo: ?- faltan_datos(Personaje).
faltan_datos(X) :-
    personaje(X),
    \+ parametros_completos(X).

% aliados(X, Y): ambos estan clasificados como heroes y son distintos.
% Es una alianza inferida por categoria, no requiere un hecho companero/2.
% X \= Y comprueba que no sean el mismo termino.
% Ejemplo: ?- aliados(iron_man, Heroe).
aliados(X, Y) :-
    tipo(X, heroe),
    tipo(Y, heroe),
    X \= Y.

% combatiente(X): X es heroe o antiheroe. Las dos clausulas son alternativas.
combatiente(X) :-
    tipo(X, heroe).
combatiente(X) :-
    tipo(X, antiheroe).

% rivales(X, Y): un heroe/antiheroe y un villano son rivales por categoria.
% Tambien funciona con los argumentos al reves; no consulta enemigo/2.
% Ejemplos: ?- rivales(thor, Villano).
%           ?- rivales(Villano, deadpool).
rivales(X, Y) :-
    combatiente(X),
    tipo(Y, villano).
rivales(X, Y) :-
    tipo(X, villano),
    combatiente(Y).

% compatriotas(X, Y): tienen la misma ciudad_origen/2 y son distintos.
% No exige que compartan planeta ni categoria.
% Ejemplo: ?- compatriotas(Personaje, kingpin).
compatriotas(X, Y) :-
    ciudad_origen(X, Ciudad),
    ciudad_origen(Y, Ciudad),
    X \= Y.

% son_companeros/2 y son_enemigos/2 hacen simetricos los hechos directos:
% permiten consultar la pareja en cualquier orden, aunque el hecho original
% se haya escrito en un solo sentido. Ejemplos:
% ?- son_companeros(thor, iron_man).
% ?- son_enemigos(kingpin, Personaje).
son_companeros(X, Y) :-
    companero(X, Y).
son_companeros(X, Y) :-
    companero(Y, X).

son_enemigos(X, Y) :-
    enemigo(X, Y).
son_enemigos(X, Y) :-
    enemigo(Y, X).

% relacion(X, Y, Tipo): consulta distintos vinculos con un solo predicado.
% Tipo indica si se encontro tutoria, companerismo, parentesco(Tipo),
% pareja o enemistad. Parentesco, pareja, companerismo y enemistad se pueden
% consultar en ambos ordenes; tutoria conserva el orden mentor-alumno.
% Ejemplos: ?- relacion(spider_man, Persona, Tipo).
%           ?- relacion(Persona, loki, parentesco(Clase)).
relacion(X, Y, tutoria) :-
    mentor(X, Y).
relacion(X, Y, companerismo) :-
    son_companeros(X, Y).
relacion(X, Y, parentesco(Tipo)) :-
    parentesco(X, Y, Tipo).
relacion(X, Y, parentesco(Tipo)) :-
    parentesco(Y, X, Tipo).
relacion(X, Y, pareja) :-
    pareja(X, Y).
relacion(X, Y, pareja) :-
    pareja(Y, X).
relacion(X, Y, enemistad) :-
    son_enemigos(X, Y).

% es_terrestre(X): su origen esta registrado como tierra.
% Ejemplo: ?- es_terrestre(Personaje).
es_terrestre(X) :-
    origen(X, tierra).

% es_extraterrestre(X): tiene un origen registrado distinto de tierra.
% No basta con que no haya datos de origen: debe existir origen/2.
% Ejemplo: ?- es_extraterrestre(Personaje).
es_extraterrestre(X) :-
    origen(X, Lugar),
    Lugar \= tierra.

% es_pupilo(Pupilo, Mentor): expresa la tutoria poniendo primero al alumno,
% aunque mentor/2 guarda primero al mentor.
% Ejemplo: ?- es_pupilo(spider_man, Mentor).
es_pupilo(Pupilo, Mentor) :-
    mentor(Mentor, Pupilo).

% defensor_local(Heroe, Planeta): Heroe es heroe y su origen coincide con
% el Planeta indicado. Ejemplo: ?- defensor_local(Heroe, tierra).
defensor_local(Heroe, Planeta) :-
    tipo(Heroe, heroe),
    origen(Heroe, Planeta).

% amenaza_alienigena(X): X esta clasificado como villano y su origen
% registrado no es la Tierra. Ejemplo: ?- amenaza_alienigena(Villano).
amenaza_alienigena(X) :-
    tipo(X, villano),
    es_extraterrestre(X).

% conflicto_entre_compatriotas(Heroe, Villano): son de la misma ciudad y
% tienen las categorias indicadas. No requiere un hecho enemigo/2.
% Ejemplo: ?- conflicto_entre_compatriotas(Heroe, Villano).
conflicto_entre_compatriotas(Heroe, Villano) :-
    compatriotas(Heroe, Villano),
    tipo(Heroe, heroe),
    tipo(Villano, villano).

% duo_entrenado(Maestro, Alumno): hay un hecho mentor(Maestro, Alumno) y
% ambos estan clasificados como heroes.
% Ejemplo: ?- duo_entrenado(Maestro, Alumno).
duo_entrenado(Maestro, Alumno) :-
    mentor(Maestro, Alumno),
    tipo(Maestro, heroe),
    tipo(Alumno, heroe).

% ====================================================================
% EJEMPLOS DE CONSULTAS (ejecutar en SWI-Prolog)
% Una consulta con atomos concretos comprueba si la relacion se cumple.
% Una consulta con variables mayusculas busca valores que la hacen cierta.
% Si hay varias respuestas, escribe ; para pedir la siguiente.
%
% ?- parametros_completos(spider_man).       % comprueba sus datos descriptivos
% ?- faltan_datos(Personaje).                % busca personajes con datos incompletos
% ?- relacion(spider_man, Persona, Tipo).    % vinculos de Spider-Man y su tipo
% ?- son_enemigos(Personaje, kingpin).       % enemigos de Kingpin
% ?- rivales(thor, Villano).                 % villanos rivales de Thor por categoria
% ?- compatriotas(Personaje1, Personaje2).    % pares distintos de la misma ciudad
% ?- amenaza_alienigena(Villano).            % villanos con origen no terrestre
% ====================================================================
