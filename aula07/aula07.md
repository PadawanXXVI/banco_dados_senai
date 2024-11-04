# CARDINALIDADES 29.10.24

Representam a quantidade de ocorrências de uma entidade que podem estar associadas a ocorrências de outra entidade em um relacionamento.

A cardinanlidade pode ser máxima ou mínima, significando os números de registros de cada entidade associada no relacionamento.

## Notaçõ de Peter Chen

(1,1) -> (mínima, máxima)

- 0 zero
- 1 um
- N muitos

## Notação Pé de Galinha

- 0
- \
- ('símbolo do pé de galinha')

## Um-para-um

Entidades: carro e CRV

CARRO POSSUI UM CRV\
CARRO (1,1) - (1,1) CRV\
CARRO - CRV 1:1

Podem ser representados

- forma ordem:\
(1,1) - (1,1)
- forma reduzida:\
1:1\
Obs: na forma reduzida, utilizam-se os máximos de cada entidade.
- função:\
função bijetora - por diagrama de Venn, onde um elemento do domínio corresponde a um elemento do contradomínio sem repetição ou sobra.

Entidades: paciente e ficha médica

PACIENTE POSSUI UMA FICHA MÉDICA

Entidades: estudante e certificado

ESTUDANTE RECEBE UM CERTIFICADO

## Um-para-muitos

Entidades: clientes e pedidos

CLIENTE (1,1) - (1,N) PEDIDO

- reduzida:\
1:N
- conjunto:\
funçao sobrejetora - por diagrama de Venn onde a imagem é igual ao contradomínio, porém a domínio pode ter mais de um elemento correspondente no contradomínio.

## Muitos-muitos

Entidades: aluno e disciplina

ALUNO (1,N) - (1,N) DISCIPLINA

- reduzida:\
(N:N)
- conjuntos:\
os elementos do domínio se relacionam com vários elementos do contradomínio e vice-versa.
