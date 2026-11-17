-- 1. Criar banco
CREATE DATABASE retrogame_recuperacao_juan;
USE retrogame_recuperacao_juan;

-- 2. Tabela CLIENTE
CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT TRUE
);

-- 3. Tabela PLATAFORMA
CREATE TABLE PLATAFORMA (
    id_plataforma INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE CATEGORIA (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(80) NOT NULL UNIQUE
);



-- 4. Tabela JOGO
CREATE TABLE JOGO (
    id_jogo INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    codigo VARCHAR(15) NOT NULL UNIQUE,
    ano_lancamento INT NOT NULL,
    quantidade_disponivel INT DEFAULT 0,
    id_plataforma INT NOT NULL,
    id_categoria INT NOT NULL,

    CHECK (quantidade_disponivel >= 0),

    FOREIGN KEY (id_plataforma)
    REFERENCES PLATAFORMA(id_plataforma),

    FOREIGN KEY (id_categoria)
    REFERENCES CATEGORIA(id_categoria)
);
-- 5. Tabela LOCACAO
CREATE TABLE LOCACAO (
    id_locacao INT PRIMARY KEY AUTO_INCREMENT,
    data_retirada DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE NULL,
    status_locacao VARCHAR(20) DEFAULT 'ABERTA',
    id_cliente INT NOT NULL,
    id_jogo INT NOT NULL,

    CHECK (status_locacao IN
    ('ABERTA', 'DEVOLVIDA', 'ATRASADA')),

    FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE(id_cliente)
    ON DELETE RESTRICT,

    FOREIGN KEY (id_jogo)
    REFERENCES JOGO(id_jogo)
    ON DELETE RESTRICT
);

-- 6. ALTER TABLE
ALTER TABLE JOGO
ADD COLUMN desenvolvedora VARCHAR(100);

-- 7. Inserir clientes
INSERT INTO CLIENTE
(nome, email, telefone, ativo)
VALUES
('Bia', 'biauzumaki@email.com', '11988881111', TRUE),
('Adryan', 'andryanlindao@email.com', NULL, TRUE),
('Julia', 'jubenjor@email.com', '11977772222', TRUE),
('Juan', 'michaeljackson@email.com', '11966663333', TRUE);

- 8. Inserir plataformas
INSERT INTO PLATAFORMA (nome)
VALUES ('PlayStation 1'), ('Nintendo 64');

-- Inserir categorias
INSERT INTO CATEGORIA (descricao)
VALUES ('Aventura'), ('Corrida');

-- Inserir 6 jogos
INSERT INTO JOGO
(titulo, codigo, ano_lancamento,
 quantidade_disponivel, id_plataforma,
 id_categoria, desenvolvedora)
VALUES
('Zelda', 'JOGO001', 1998, 5, 2, 1, 'Nintendo'),
('Gran Turismo 2', 'JOGO002', 1999, 4, 1, 2, 'Polyphony'),
('Crash Bandicoot', 'JOGO003', 1996, 3, 1, 1, 'Naughty Dog'),
('Mario Kart 64', 'JOGO004', 1996, 6, 2, 2, 'Nintendo'),
('God of War', 'JOGO005', 2005, 7, 1, 1, 'Santa Monica'),
('Need for Speed', 'JOGO006', 2003, 2, 1, 2, 'EA');

-- 9. Inserir locações
START TRANSACTION;

INSERT INTO LOCACAO
(data_prevista, status_locacao, id_cliente, id_jogo)
VALUES
(DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'ABERTA', 1, 1),
(DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'ABERTA', 2, 2),
(DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'ABERTA', 1, 3);

UPDATE JOGO
SET quantidade_disponivel =
quantidade_disponivel - 1
WHERE id_jogo IN (1, 2, 3);

-- 10. SELECT e UPDATE
SELECT * FROM CLIENTE
WHERE email = 'biauzumaki@email.com';

UPDATE CLIENTE
SET telefone = '11999990000'
WHERE email = 'biauzumaki@email.com';

-- 11. UPDATE em lote
UPDATE JOGO
SET quantidade_disponivel =
quantidade_disponivel + 2
WHERE ano_lancamento >= 2000;

-- 12. Criar e excluir cliente
INSERT INTO CLIENTE
(nome, email, telefone)
VALUES ('Teste', 'teste@email.com', NULL);

DELETE FROM CLIENTE
WHERE email = 'teste@email.com'
AND id_cliente NOT IN
(SELECT id_cliente FROM LOCACAO);
