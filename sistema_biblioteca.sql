CREATE DATABASE sistema_biblioteca;

\c sistema_biblioteca;

CREATE TABLE livro (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(200) NOT NULL
);

CREATE TABLE exemplar (
    id SERIAL PRIMARY KEY,
    livro_id INTEGER NOT NULL REFERENCES livro(id),
    disponivel BOOLEAN DEFAULT TRUE
);

CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE emprestimo (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuario(id),
    exemplar_id INTEGER REFERENCES exemplar(id),
    data_emprestimo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_devolucao TIMESTAMP
);

INSERT INTO livro (titulo, autor) VALUES
('Dom Casmurro', 'Machado de Assis'),
('O Hobbit', 'J.R.R. Tolkien'),
('1984', 'George Orwell'),
('Clean Code', 'Robert C. Martin');

INSERT INTO exemplar (livro_id, disponivel) VALUES
(1, TRUE),
(1, TRUE),
(2, TRUE),
(2, FALSE),
(3, TRUE),
(4, TRUE);

INSERT INTO usuario (nome) VALUES
('João Silva'),
('Maria Souza'),
('Carlos Pereira');

INSERT INTO emprestimo (usuario_id, exemplar_id, data_devolucao) VALUES
(1, 4, NULL),
(2, 2, '2026-04-20 10:00:00'),
(3, 3, NULL);

SELECT emprestimo.exemplar_id, emprestimo.usuario_id, emprestimo.data_emprestimo FROM emprestimo INNER JOIN exemplar ON (emprestimo.exemplar_id = exemplar.id) WHERE exemplar.disponivel = false;

SELECT DISTINCT usuario.id, usuario.nome FROM usuario INNER JOIN emprestimo ON (usuario.id = emprestimo.usuario_id);

SELECT usuario.id, usuario.nome, COUNT(emprestimo.id) AS total_emprestimos FROM usuario INNER JOIN emprestimo ON (usuario.id = emprestimo.usuario_id) GROUP BY usuario.id;

SELECT livro.id, livro.titulo, livro.autor, COUNT(emprestimo.id) AS total_emprestimos FROM livro INNER JOIN exemplar ON (livro.id = exemplar.livro_id) INNER JOIN emprestimo ON (exemp
lar.id = emprestimo.exemplar_id) GROUP BY livro.id, livro.titulo, livro.autor;

SELECT livro.id, livro.titulo,livro.autor FROM livro INNER JOIN exemplar ON (livro.id = exemplar.livro_id) WHERE exemplar.disponivel IS true;

SELECT usuario.id, usuario.nome, COUNT(emprestimo.id) AS ranking_usuario_por_emprestimo FROM usuario INNER JOIN emprestimo ON (usuario.id = emprestimo.usuario_id) GROUP BY usuario.id ORDER BY ranking_usuario_por_emprestimo DESC;

SELECT livro.id, livro.titulo, COUNT(emprestimo.id) AS Livro_mais_emprestado FROM livro INNER JOIN exemplar ON (livro.id = exemplar.livro_id) LEFT JOIN emprestimo ON (exemplar.id = e
mprestimo.exemplar_id) GROUP BY livro.id, livro.titulo ORDER BY Livro_mais_emprestado DESC;

SELECT * FROM emprestimo WHERE  data_devolucao > data_emprestimo + INTERVAL '1 week';

SELECT 
    AVG(data_devolucao - data_emprestimo) AS tempo_medio
FROM emprestimo
WHERE data_devolucao IS NOT NULL;

SELECT EXTRACT(YEAR FROM data_emprestimo) AS ano, COUNT(id) AS emprestimos_por_ano FROM emprestimo GROUP BY ano;

WITH emprestimos_por_usuario AS (
    SELECT 
        usuario_id,
        COUNT(*) AS total
    FROM emprestimo
    GROUP BY usuario_id
),
media_geral AS (
    SELECT AVG(total) AS media
    FROM emprestimos_por_usuario
)
SELECT 
    u.id,
    u.nome,
    epu.total
FROM emprestimos_por_usuario epu
JOIN usuario u ON u.id = epu.usuario_id
WHERE epu.total > (SELECT media FROM media_geral);

SELECT DISTINCT ON (emprestimo.usuario_id) emprestimo.usuario_id, usuario.nome,exemplar.id, emprestimo.data_emprestimo FROM emprestimo INNER JOIN usuario ON (emprestimo.usuario_id = usuario.id) INNER JOIN exemplar ON (emprestimo.exemplar_id = exemplar.id) ORDER BY emprestimo.usuario_id;

SELECT l.id, l.titulo
FROM livro l
WHERE NOT EXISTS (
    SELECT 1
    FROM exemplar e
    JOIN emprestimo emp ON e.id = emp.exemplar_id
    WHERE e.livro_id = l.id
);

SELECT 
    e.id AS exemplar,
    COUNT(emp.id) AS total_atrasos
FROM exemplar e
JOIN emprestimo emp ON e.id = emp.exemplar_id
WHERE emp.data_devolucao IS NOT NULL
AND emp.data_devolucao > emp.data_emprestimo + INTERVAL '1 week'
GROUP BY e.id
ORDER BY total_atrasos DESC;

SELECT 
    u.id,
    u.nome,
    SUM(emp.data_devolucao - emp.data_emprestimo) AS tempo_total
FROM usuario u
JOIN emprestimo emp ON u.id = emp.usuario_id
WHERE emp.data_devolucao IS NOT NULL
GROUP BY u.id, u.nome
ORDER BY tempo_total DESC;