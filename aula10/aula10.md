# TIPOS DE DADOS

## 1 Conceito

Definem o tipo de valor que pode ser armazenado em cada campo de uma tabela. Esses tipos de dados indicam como o sistema de banco de dados deve lidar com os dados inseridos.

## 2 Tipos

### 2.1 Inteiros 

#### 2.1.1 INT/INTEGER 

Armazenam números inteiros (-2.147.483.648 e 2.147.483.648).

#### 2.1.2 BIGINT

Suporta valores inteiros maiores, ideal para grandes contagens.

### 2.2 Decimais

#### 2.2.1 FLOAT
Ponto flutuante com precisão simples.

#### 2.2.2 DOUBLE

Similar ao FLOAT, mas com precisão dupla... aceita mais de 7 casas decimais.

### 2.3 Texto

#### 2.3.1 VARCHAR

Armazena texto de comprimento variável, permitindo maior eficiência ao economizar espaço para caracteres não utilizados. O comprimento máximo pode ser definido ao criar o campo.

#### 2.3.2 CHAR

Armazena texto de comprimento fixo, preenchendo o espaço com caracteres em branco se o texto não ocupar todo o campo. Ideal para valores de tamanho constante, como códigos de países.

### 2.4 Data e hora

#### 2.4.1 DATE

#### 2.4.2 TIME

#### 2.4.3 DATETIME

### 2.5 Booleano

Representa valores lógicos como TRUE ou FALSE (1 ou 0 no MYSQL). Esse tipo é usado para indicadores binários, como sinalizadorees de status ou respostas a condições booleanas.

### 2.6 BLOB (Binário)

Binary Large Object - armazena grandes blocos de dados binários, como arquivos de mídia (imagens, áudio, vídeo) ou documentos. Não é diretamente legível por humanos...

# 1 DICIONÁRIO DE DADOS

## 1.1 Definições 

Junto ao Modelo Entidade-Relacionamento (MER), faz-se necessário um documento com a explicação de todos seus objetos. Esse documento é chamado de Dicionário/Glossário de Dados

Seu objetivo é melhorar a comunicação entre os envolvidos no projeto.

Disponibiliza informações sobre os objetos ...

## 1.2 Como criar

| Tabela | Coluna | Tipo de dados | Restrições | Descrição |
| :-: | :-: | :-: | :-: | :- | 
| tbl_aluno | id | int | PK | Identificador único do aluno |
| | nome | VARCHAR | not null | Nome completo do aluno |
| | data_nascimento | | |

## 1.3 Conceito segundo a IBM
