% 1. Implementar o n-ésimo termo de uma PA (Progressão Aritmética)  considerando
% como dados de entrada a posição N, o primeiro elemento da PA e a razão. Considere
% duas versões recursivas: recursiva de cauda e recursiva que não seja de cauda.

% Termo geral de uma PA: An = A1 + (n - 1) * Raz

npa(A1, 1, _, A1).
npa(A1, Pos, Raz, Res) :-
	Pos > 1,
	ProxPos is Pos - 1,
	npa(A1, ProxPos, Raz, Res1),
	Res is Raz + Res1.

npa_cauda(A1, 1, _, A1).
npa_cauda(A1, Pos, Raz, Res) :-
	Pos > 1,
	Ax is A1 + Raz,
	ProxPos is Pos - 1,
	npa_cauda(Ax, ProxPos, Raz, Res).

% 2. Implementar a soma dos N primeiros termos de uma PA considerando como dados
% de entrada a posição N, o primeiro elemento da PA e a razão. Considere duas
% versões recursivas: recursiva de cauda e recursiva que não seja de cauda.

% Soma dos termos de uma PA até An: Sn = ((A1 + An) * n)/2

somapa(A1, 1, _, A1).
somapa(A1, Pos, Raz, Res) :-
	Pos > 1,
	npa(A1, Pos, Raz, An),
	PosAnt is Pos - 1,
	somapa(A1, PosAnt, Raz, Res1),
	Res is Res1 + An.

% 3. Quais as respostas Prolog para as seguintes consultas?
% 01. ?-[X]=[a].			Resp:   X = a.
% 02. ?-X=[ ].				Resp:   X = [].
% 03. ?-[X]=[ ].			Resp:   False.
% 04. ?-X=[a].				Resp:   X = a.
% 05. ?-[X,Y]=[a].			Resp:   False.
% 06. ?-[X,Y]=[a,b].		Resp:   X = a, Y = b.
% 07. ?-[X,Y]=[a,b,c].		Resp:   False.
% 08. ?-[X,Y,Z]=[a,b,c].	Resp:   X = a, Y = b, Z = c.
% 09. ?-[X,Y,X]=[a,b,c].	Resp:   False.
% 10. ?-[X,Y,X]=[a,b,a].	Resp:   X = a, Y = b.
% 11. ?-[X|Y]=[a].			Resp:   X = a, Y = [].
% 12. ?-[X|Y]=[ ].			Resp:   False.
% 13. ?-[X|Y]=[a,b,c].		Resp:   X = a, Y = [b,c].
% 14. ?-[X,Y|Z]=[a,b,c].	Resp:   X = a, Y = b, Z = [c].
% 15. ?-[X,Y|Z]=[a,b].		Resp:   X = a, Y = b, Z = [].
% 16. ?-[X,Y|Z]=[a].		Resp:   False.
% 17. ?-[X,Y|Z]=[a,b,c,d].	Resp:   X = a, Y = b, Z = [c,d].
% 18. ?-[X,Y|Z]=[a,b,a].	Resp:   X = a, Y = b, Z = [a].
% 19. ?-[X,Y|Z]=[[a],b,a].	Resp:   X = [a], Y = b, Z = [a].

% 4. N-ésimo elemento de uma lista: n_esimo( N, Elemento, Lista ).
nlista(1, Elem, [Elem|_]).
nlista(N, Elem, [_|Y]) :-
	N > 1,
	N1 is N - 1,
	nlista(N1, Elem, Y),!.

% 5. Número de elementos de uma  lista:  no_elementos ( Lista, N ).

nro_elementos([], 0).
nro_elementos([_|Y], Res) :-
	nro_elementos(Y, Res1),
	Res is Res1 + 1.

% 6. Retirar a primeira ocorrência de um elemento de uma lista:
% 7. tire_elemento ( Elemento, Lista, Lista_nova ).

tire_elemento(Elem, [Elem|T], T).
tire_elemento(Elem, [H|T], [H|Y]) :-
	Elem \= H,
	tire_elemento(Elem, T, Y).

% 8. Retirar todas as ocorrências de um elemento de uma lista.
% 9. retirar_ocor ( Elemento, Lista, Lista_nova ).

retirar_ocor(_, [], []).
retirar_ocor(Elem, [Elem|T], Res) :-
	retirar_ocor(Elem, T, Res).
retirar_ocor(Elem, [H|T], Res) :-
	Elem \= H,
	retirar_ocor(Elem, T, R1),
	Res = [H|R1], !.

% 10. Retirar elementos repetidos de uma lista:
% retire_repet ( Lista, Lista_nova ).

retire_repet([],[]).
retire_repet([H|T],Res):-
    retire_repet(T,R2),
    retirar_ocor(H,R2,R1),
    inserir_cabeca(H,R1,Res),!.

% 11. Concatenar duas listas quaisquer: concatenar ( Lista1, Lista2, Lista_concat ).

concatenar([],L2,L2).
concatenar([H|T],L,[H|Y]):-
    concatenar(T,L,Y).

% 12. Encontrar o maior elemento de uma lista numérica: maior ( Lista, Elemento ).

maior([H],H).
maior([H|[Y|Z]],M):-
    H>Y,
    maior([H|Z],M).
maior([H|[Y|Z]],M):-
    Y>=H,
    maior([Y|Z],M),!.

% 13. Encontrar o menor elemento de uma lista numérica: menor ( Lista, Elemento ).

menor([H],H).
menor([H|[Y|Z]],Res):-
    H<Y,
    menor([H|Z],Res).
menor([H|[Y|Z]],Res):-
    Y=<H,
    menor([Y|Z],Res),!.

% 14. Pegar elementos de uma lista dada a lista de suas posições: pegar (Lista_posições, Lista, Lista_resultante).  ->> Duvida

pegar([],_,[]).
pegar([H|T],[X|Y],Res):-
    pegar(T,[X|Y],Res1),
    posicao(H,[X|Y],Elem),
    inserir_cabeca(Elem,Res1,Res),!.

posicao(1,[H|_],H).
posicao(N,[_|T],Res):-
    N1 is N-1,
    posicao(N1,T,Res).

% 15. Inserir elemento na primeira posição de uma lista:  inserir_cabeça ( Elemento, Lista, Lista_resultante ).

inserir_cabeca(H,L,[H|L]).

% 16. Inserir elemento numa posição N da lista:  inserir_N (Elemento, N, Lista, Lista_resultante)

inserir_N(Elem,1,L,[Elem|L]).
inserir_N(Elem,N,[H|T],Res):-
   N1 is N-1,
   inserir_cabeca(H,R1,Res),
   inserir_N(Elem,N1,T,R1),!.

% 17. Inverter uma lista:   inverter (Lista, Lista_resultante)

inverter([],[]).
inverter([H|T],Res):-
    inverter(T,Res1),
    append(Res1,[H],Res).

% 18. Substituir um elemento de uma lista por um outro elemento: substitui (X, Y, Lista, Lista_resultante).

substitui(Z,W,[Z|T],[W|T]):-!.
substitui(Z,W,[H|T],Res):-
    substitui(Z,W,T,Res1),
    inserir_cabeca(H,Res1,Res),!.

% 19. Duplicar elementos de uma lista:  duplicar_todos (Lista, Lista_resultante)


% 20. Duplicar um elemento de uma lista: duplicar_um (Elemento, Lista, Lista_resultante)

duplica_um(Elem,[H|T],Res):-
    Res1 is 2*Elem,
    substitui(Elem,Res1,[H|T],Res).

% 21. Verificar se a intersecção entre dois conjuntos não é vazia: nao_vazia ( Lista1, Lista2).

nao_vazia([H|T],[X|Y]):-
    not(disjuntos([H|T],[X|Y])).

% 22. Fazer a união de dois conjuntos: uniao ( Lista1, Lista2, Lista_uniao ).

uniao(L1,L2,LU):-
	concatenar(L1,L2,LC),
	retire_repet(LC,LU).

% 23. Verificar se dois conjuntos são disjuntos: disjuntos ( Lista1, Lista2 ).

disjuntos(_,[]).
disjuntos([],_).
disjuntos([H|T],[X|Y]):-
    disjuntos(T,[X|Y]),
    not(pertence([X|Y],H)).

pertence([H|_],X):-
	X=H,!.
pertence([_|T],X):-
	pertence(T,X).

% 24. Verificar se dois conjuntos são iguais: iguais ( Lista1, Lista2 ).

iguais([H],[H]):- !.
iguais([H|T],[H|Z]):-
	iguais(T,Z).
