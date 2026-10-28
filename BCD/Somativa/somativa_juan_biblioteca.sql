-- FASE 1 — DDL: CRIAÇÃO E ESTRUTURA
CREATE DATABASE biblioteca_som2;
USE biblioteca_som2;

CREATE TABLE IF NOT EXISTS USUARIO (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT TRUE
);


CREATE TABLE IF NOT EXISTS LIVRO (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(120) NOT NULL,
    isbn CHAR(13) NOT NULL UNIQUE,
    ano_publicacao INT NULL,
    quantidade_disponivel INT DEFAULT 0,
    CONSTRAINT chk_quantidade CHECK (quantidade_disponivel >= 0)
);

CREATE TABLE IF NOT EXISTS EMPRESTIMO (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    data_emprestimo DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE NULL,
    status_emprestimo VARCHAR(20) DEFAULT 'ABERTO',
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    CONSTRAINT chk_status CHECK (status_emprestimo IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE RESTRICT,
    CONSTRAINT fk_livro FOREIGN KEY (id_livro) REFERENCES LIVRO(id_livro) ON DELETE RESTRICT
);
ALTER TABLE LIVRO ADD editora VARCHAR(100) NULL;

-- FASE 2 — DML: MANIPULAÇÃO DE DADOS
INSERT INTO USUARIO (nome, email, telefone) VALUES 
('Ana Silva', 'ana.silva@email.com', '11999998888'),
('Carlos Souza', 'carlos.souza@email.com', '11988887777'),
('Beatriz Costa', 'beatriz.costa@email.com', NULL),
('Marcos Oliveira', 'marcos.o@email.com', '11977776666');

INSERT INTO LIVRO (titulo, autor, isbn, ano_publicacao, quantidade_disponivel, editora) VALUES
('O Programador Pragmático', 'Andrew Hunt', '9788573076104', 2000, 3, 'Bookman'),
('Código Limpo', 'Robert C. Martin', '9788576082675', 2009, 5, 'Alta Books'),
('Arquitetura Limpa', 'Robert C. Martin', '9788550804606', 2018, 1, 'Alta Books'),
('Entendendo Algoritmos', 'Aditya Bhargava', '9788575225639', 2017, 4, 'Novatec'),
('Refatoração', 'Martin Fowler', '9788575227244', 2020, 2, 'Novatec'),
('Design Patterns', 'Erich Gamma', '9788573076105', 2021, 6, 'Bookman');

INSERT INTO EMPRESTIMO (data_prevista, id_usuario, id_livro) VALUES
('2026-11-10', 1, 1),
('2026-11-12', 2, 2),
('2026-11-15', 3, 4);

SELECT id_usuario FROM USUARIO WHERE email = 'marcos.o@email.com';
UPDATE USUARIO SET telefone = '11911112222' WHERE id_usuario = 4;
UPDATE LIVRO SET quantidade_disponivel = quantidade_disponivel + 2 WHERE ano_publicacao >= 2020;

INSERT INTO USUARIO (nome, email, telefone) VALUES ('Teste Silva', 'teste@email.com', '11900000000');
DELETE FROM USUARIO WHERE email = 'teste@email.com';
DELETE FROM USUARIO WHERE id_usuario = 1;
-- FASE 3 — DQL: CONSULTAS E ANÁLISE

-- 12. SELECT básico
SELECT titulo, autor, quantidade_disponivel FROM LIVRO;

-- 13. WHERE + ORDER BY 
SELECT * FROM LIVRO WHERE quantidade_disponivel > 2 ORDER BY quantidade_disponivel DESC;

-- 14. LIKE — (Palavra escolhida: "Dados")
SELECT * FROM LIVRO WHERE titulo LIKE '%Dados%';

-- 15. BETWEEN 
SELECT * FROM LIVRO WHERE ano_publicacao BETWEEN 2015 AND 2025;

-- 16. Funções agregadas 
SELECT 
    COUNT(*) AS total_titulos_cadastrados,
    SUM(quantidade_disponivel) AS total_exemplares_estoque,
    AVG(quantidade_disponivel) AS media_exemplares_por_livro,
    MIN(quantidade_disponivel) AS menor_estoque,
    MAX(quantidade_disponivel) AS maior_estoque
FROM LIVRO;

-- 17. INNER JOIN 
SELECT 
    e.id_emprestimo,
    u.nome AS nome_usuario,
    l.titulo AS titulo_livro,
    e.data_emprestimo,
    e.status_emprestimo
FROM EMPRESTIMO e
INNER JOIN USUARIO u ON e.id_usuario = u.id_usuario
INNER JOIN LIVRO l ON e.id_livro = l.id_livro;

-- 18. JOIN + WHERE 
SELECT 
    e.id_emprestimo,
    u.nome AS nome_usuario,
    l.titulo AS titulo_livro,
    e.status_emprestimo
FROM EMPRESTIMO e
INNER JOIN USUARIO u ON e.id_usuario = u.id_usuario
INNER JOIN LIVRO l ON e.id_livro = l.id_livro
WHERE e.status_emprestimo = 'ABERTO';

-- 19. GROUP BY 
SELECT 
    u.nome AS nome_usuario,
    COUNT(e.id_emprestimo) AS total_emprestimos
FROM EMPRESTIMO e
INNER JOIN USUARIO u ON e.id_usuario = u.id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY total_emprestimos DESC;

-- 20. LEFT JOIN 
SELECT 
    u.nome AS nome_usuario,
    COUNT(e.id_emprestimo) AS total_emprestimos
FROM USUARIO u
LEFT JOIN EMPRESTIMO e ON u.id_usuario = e.id_usuario
GROUP BY u.id_usuario, u.nome;


-- FASE 4 — TCL, TRANSAÇÕES E INTEGRIDADE
-- 21. Transação de empréstimo
START TRANSACTION;

INSERT INTO EMPRESTIMO (data_prevista, id_usuario, id_livro) VALUES ('2026-11-10', 4, 3);

UPDATE LIVRO SET quantidade_disponivel = quantidade_disponivel - 1 WHERE id_livro = 3;
-- Consulta de conferência interna na transação
SELECT * FROM LIVRO WHERE id_livro = 3;
COMMIT;

-- 22. ROLLBACK
START TRANSACTION;
-- Modificação provisória de teste
UPDATE LIVRO SET quantidade_disponivel = 50 WHERE id_livro = 1;

SELECT quantidade_disponivel FROM LIVRO WHERE id_livro = 1;
ROLLBACK;

SELECT quantidade_disponivel FROM LIVRO WHERE id_livro = 1;

-- 23. SAVEPOINT
START TRANSACTION;

UPDATE LIVRO SET quantidade_disponivel = 10 WHERE id_livro = 5;
SAVEPOINT ponto_alteracao1;

UPDATE LIVRO SET quantidade_disponivel = 20 WHERE id_livro = 6;

ROLLBACK TO ponto_alteracao1;
COMMIT; 
-- 24. Transação de devolução;
UPDATE EMPRESTIMO 
SET status_emprestimo = 'DEVOLVIDO', data_devolucao = '2026-10-28' 
WHERE id_emprestimo = 1 AND status_emprestimo = 'ABERTO';

UPDATE LIVRO SET quantidade_disponivel = quantidade_disponivel + 1 WHERE id_livro = 1;
COMMIT;
