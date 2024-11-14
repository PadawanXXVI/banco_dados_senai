CREATE DATABASE IF NOT EXISTS db_cinema;
USE db_cinema;

CREATE TABLE IF NOT EXISTS tb_filme(
	id_filme INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    genero VARCHAR(100),
    duracao INT,
    ano_lancamento YEAR,
    classificacao_indicativa VARCHAR(50)
    );
    
INSERT INTO tb_filme
	(id_filme, titulo, genero, duracao, ano_lancamento, classificacao_indicativa)
VALUES
(1, 'O Senhor dos Anéis', 'Aventura, Fantasia', 180, 2001, '12 anos'),
(2, 'Vingadores: Ultimato', 'Ação, Aventura', 180, 2019, '12 anos'),
(3, 'O Rei Leão', 'Animação, Aventura', 118, 2019, 'Livre'),
(4, 'Matrix', 'Ficção Científica', 136, 1999, '14 anos'),
(5, 'Parasita', 'Drama, Suspense', 132, 2019, '16 anos'),
(6, 'Titanic', 'Romance, Drama', 195, 1997, '14 anos'),
(7, 'A Origem', 'Ficção Científica', 148, 2010, '14 anos'),
(8, 'Pantera Negra', 'Ação, Aventura', 134, 2018, '12 anos'),
(9, 'Coringa', 'Drama, Crime', 122, 2019, '18 anos'),
(10, 'Toy Story 4', 'Animação, Aventura', 100, 2019, 'Livre');

SELECT * FROM tb_filme;

-- 1. Quais filmes têm título que começa com "O" e duração maior que 120 minutos?
SELECT * FROM tb_filme
WHERE titulo  LIKE 'O%'
AND duracao > '120';

-- 2. Quais filmes pertencem aos gêneros "Aventura" ou "Ação"?
SELECT * FROM tb_filme
WHERE genero LIKE '%aventura%' -- como os filmes possuem mais de um gênero, foi necessário o uso do LIKE
OR genero LIKE '%ação%';

-- 3. Quais filmes foram lançados em 2019 e têm duração superior a 130 minutos?
SELECT * FROM tb_filme
WHERE ano_lancamento = '2019'
AND duracao > '130';

-- 4. Quais filmes de gênero "Ficção Científica" têm classificação "14 anos" ou "16 anos"?
SELECT * FROM tb_filme
WHERE genero LIKE 'Ficção científica'
AND classificacao_indicativa = '14 anos' OR classificacao_indicativa = '16 anos';
-- AND classificacao_indicativa IN ('14 anos', '16 anos') : poderia ser utilizado o IN

-- 5. Quais filmes não são de gênero "Aventura" e têm duração entre 120 e 180 minutos?
SELECT * FROM tb_filme
WHERE genero LIKE '%aventura%'
AND duracao BETWEEN 120 AND 180;

-- 6. Quais filmes foram lançados entre 2018 e 2019 e têm duração acima de 120 minutos?
SELECT * FROM tb_filme
WHERE ano_lancamento BETWEEN 2018 AND 2019
AND duracao > 120;

-- 7. Quais filmes têm título que contém "Rei" e ano de lançamento após 2000?
SELECT * FROM tb_filme
WHERE titulo LIKE '%rei%'
AND ano_lancamento > 2000;

-- 8. Quais filmes têm duração menor que 130 minutos ou classificação 'Livre'?
SELECT * FROM tb_filme
WHERE duracao < 130
OR classificacao_indicativa = 'livre';

-- 9. Quais filmes são dos gêneros "Aventura" ou "Drama" e têm classificação "12 anos"?
SELECT * FROM tb_filme
WHERE genero LIKE '%aventura%' OR genero LIKE '%drama%'
AND classificacao_indicativa > '12 anos';

-- 10. Quais filmes foram lançados entre 1997 e 2000, exceto os de gênero "Romance"?
SELECT * FROM tb_filme
WHERE ano_lancamento BETWEEN 1997 AND 2000
AND NOT genero LIKE '%romance%';

-- 11. Quais filmes têm classificação "12 anos" ou "14 anos" e duração entre 130 e 150 minutos?
SELECT * FROM tb_filme
WHERE classificacao_indicativa LIKE '12%' OR classificacao_indicativa LIKE '14%'
AND duracao BETWEEN 130 AND 150;

-- 12. Quais filmes têm título diferente de 'Titanic' e são dos gêneros "Drama" ou "Crime"?
SELECT * FROM tb_filme
WHERE NOT titulo = 'Titanic'
AND genero LIKE '%drama%' OR genero LIKE '%crime%';

-- 13. Quais filmes têm duração superior a 150 minutos e foram lançados entre 1999 e 2010?
SELECT * FROM tb_filme
WHERE duracao > 150
AND ano_lancamento BETWEEN 1999 AND 2010;

-- 14. Quais filmes são de gênero "Aventura", lançados em 2019 ou 2018, e têm classificação "12 anos"?
SELECT * FROM tb_filme
WHERE genero LIKE '%aventura%' 
AND ano_lancamento BETWEEN 2018 AND 2019
AND classificacao_indicativa = '12 anos';

-- 15. Quais filmes têm duração entre 100 e 140 minutos ou título contendo "Toy"?
SELECT * FROM tb_filme
WHERE duracao BETWEEN 100 AND 140
AND titulo LIKE '%Toy%';

-- 16. Quais filmes têm duração maior que 100 minutos e foram lançados entre 1997 e 2000?
SELECT * FROM tb_filme
WHERE duracao > 100
AND ano_lancamento BETWEEN 1997 AND 2000;

-- 17. Quais filmes são de gênero "Aventura" e têm classificação "Livre" ou "12 anos"?
SELECT * FROM tb_filme
WHERE genero LIKE '%aventura%'
AND classificacao_indicativa = 'livre' OR classificacao_indicativa = '12 anos';

-- 18. Quais filmes têm duração superior a 120 minutos e foram lançados nos anos 2019 ou 2018?
SELECT * FROM tb_filme
WHERE duracao > 120 
AND ano_lancamento BETWEEN 2018 AND 2019;

-- 19. Quais filmes são de gênero "Animação" e têm classificação indicativa "Livre" ou "12 anos"?
SELECT * FROM tb_filme
WHERE genero LIKE '%animacao%'
AND classificacao_indicativa = 'livre' OR classificacao_indicativa = '12 anos';

-- 20. Quais filmes foram lançados em 1999 ou 2001 e têm duração entre 130 e 150 minutos?
SELECT * FROM tb_filme
WHERE ano_lancamento = 1999 OR ano_lancamento = 2001
AND duracao BETWEEN 130 AND 150;
