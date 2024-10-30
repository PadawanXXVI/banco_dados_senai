# NORMALIZAÇÃO (30.10.24)

## 1 Anomalias

São problemas que surgem em bancos de dados que não foram bem planejados ou normalizados, geralmente devido ao acúmulo excessivo de informaçãoes em uma única tabela.

### 1.1 Principais anomalias

#### 1.1.1 Anomalia de inclusão

É um problema que ocorre quando não é possível adicionar um novo dado em uma tabela sem preencher informaçãoes que ainda não existem ou que não são necessárias.

Exemplo:<br>
Cliente e Pedido<br>
Aluno e Curso

#### 1.1.2 Anomaliza de Exclusão

Acontece quando a exclusão de uma registro leva à perda indesejada de outros dados importantes que esão vinculados a ele.

Exemplo:<br>
Cliente e Pedido<br>
Funcinário e Departamento

#### Anomalia de Modificação

Ocorre quando a mesma infomação é armazanda em vaprios lugares dentro de uma tabela. Isso causa problemas quando você precisa atualizar essa informação, pois é necessário modificar todos os registros onde ela aparece. Se a atualização não for feita em todos os locais, isso resulta em dados inconsistentes.

Exemplo:<br>
Clientes e Pedido

| Nome | Pedido |
| :-: | :-: |
| João | Ped1 |
| Zoão | Ped2 |
| Zoão | Ped3 |

Por exemplo, após vários pedidos, foi detectado que o nome do cliente foi escrito de forma errada, sendo necessário fazer o ajuste para cada entrada.

Para evitar as anomalias, usamos o processo de normalização, como 1FN, 2FN e 3FN, para estruturar corretamente os bancos de dados

## 2 Normalização

É um processo de organização de dados em um banco de dados relacionais, que busca reduzir a redundância e melhorar a integrudade dos dados.

### 2.1 1FN (Primeira Forma Normal)

Os atributos multivalorados, compostos e suas combinações não podem ser aceitos.

#### 2.1.1 Requisitos da 1FN
- Valores atômicos
- Registros únicos
- Formato tabular

### 2.2 2FN

#### Requisitos
- Estar na 1FN
- Remover as dependências parciais

### 3FN 

- Estar na 1FN
- Estar na 2F
- Remover dependências transacionais