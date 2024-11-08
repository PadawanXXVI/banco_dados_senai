-- Criar um banco de dados chamado db_biblioteca.
CREATE DATABASE IF NOT EXISTS db_biblioteca
COLLATE utf8mb4_general_ci 
CHARSET utf8mb4;

-- Selecionar o banco de dados biblioteca como o banco de dados ativo.
USE db_biblioteca;

-- Crie uma tabela para livros
CREATE TABLE tb_livros(
	id_livro INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(125) NOT NULL,
    descricao LONGTEXT,
    escritor VARCHAR(125) NOT NULL,
    editora VARCHAR(125),
    categoria VARCHAR(125)
);

-- Listar todas as tabelas no banco de dados atual.
SHOW TABLES;

-- Descreva a sua tabela para visualizar os detalhes da estrutura da tabela livro.
DESCRIBE tb_livros;

-- Inserir 15 livros na tabela tb_livro
INSERT INTO tb_livros 
	(nome, descricao, escritor, editora, categoria)
VALUES
	('O Mistério do Lago', 'Um thriller envolvente sobre um desaparecimento inexplicável.', 'Ana Costa', 'Editora Vento', 'Suspense'),
	('Jornada ao Infinito', 'Uma viagem fantástica através de universos paralelos.', 'Carlos Lima', 'Editora Estrela', 'Ficção Científica'),
	('Receitas da Vovó', 'Uma coleção das melhores receitas caseiras.', 'Maria Oliveira', 'Editora Sabor', 'Culinária'),
	('A Arte da Guerra', 'Um estudo estratégico sobre táticas militares.', 'Sun Tzu', 'Editora Clássica', 'História'),
	('Os Segredos da Mente', 'Explorando os mistérios do cérebro humano.', 'Roberto Silva', 'Editora Saber', 'Psicologia'),
	('O Jardim Encantado', 'Uma aventura mágica em um jardim secreto.', 'Patrícia Lopes', 'Editora Fantasia', 'Infantil'),
	('Histórias de Amor', 'Contos românticos que aquecem o coração.', 'Juliana Souza', 'Editora Romance', 'Romance'),
	('A Era dos Dragões', 'Uma épica batalha entre humanos e dragões.', 'Fernando Almeida', 'Editora Dragão', 'Fantasia'),
	('Viagem no Tempo', 'As incríveis aventuras de um viajante temporal.', 'Tiago Santos', 'Editora Cronos', 'Ficção Científica'),
	('Mitos e Lendas', 'Narrativas ancestrais de diversas culturas.', 'Leonardo Pereira', 'Editora Mitológica', 'História'),
	('A Última Fronteira', 'Desbravando o espaço em busca de novas civilizações.', 'Beatriz Rodrigues', 'Editora Galáctica', 'Ficção Científica'),
	('Cozinha Vegana', 'Deliciosas receitas veganas para o dia a dia.', 'Cláudia Mendes', 'Editora Verde', 'Culinária'),
	('O Enigma das Pirâmides', 'Segredos escondidos nas antigas pirâmides.', 'Ricardo Martins', 'Editora Mistério', 'História'),
	('A Magia da Música', 'Como a música pode transformar vidas.', 'Gabriela Silva', 'Editora Harmonia', 'Arte'),
	('Segredos do Submarino', 'Uma expedição submarina cheia de surpresas.', 'Daniel Costa', 'Editora Oceano', 'Aventura');
    
-- comando para visualizar a tabela com os dados inseridos
SELECT * FROM tb_livros;

