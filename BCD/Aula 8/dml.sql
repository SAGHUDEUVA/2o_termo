DROP DATABASE IF EXISTS SMARTCOFFEE_DML_JUAN;

CREATE DATABASE SMARTCOFFEE_DML_JUAN;

USE SMARTCOFFEE_DML_JUAN;

-- TABELAS

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE,
    telefone VARCHAR(20),
    cidade VARCHAR(60),
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    id_categoria INT NOT NULL,
    CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria)
    REFERENCES categoria(id_categoria)
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATETIME NOT NULL,
    status ENUM('ABERTO', 'PREPARANDO', 'FINALIZADO', 'CANCELADO') NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    id_cliente INT NOT NULL,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente)
);

CREATE TABLE item_pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    observacao VARCHAR(150),
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido)
    REFERENCES pedido(id_pedido),
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto)
    REFERENCES produto(id_produto)
);


CREATE TABLE forma_pagamento (
    id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME,
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (id_pedido)
    REFERENCES pedido(id_pedido),
    CONSTRAINT fk_forma_pagamento FOREIGN KEY (id_forma_pagamento)
    REFERENCES forma_pagamento (id_forma_pagamento)
);

INSERT INTO cliente (nome,email,telefone,cidade,ativo)VALUES
('Anna Concolato', 'ana@email.com','199999999001', 'Limeira',TRUE),
('Jacó Souza', 'jaco@email.com','199999999002', 'Limeira',TRUE),
('Gabriela Lima', 'gaby@email.com','199999999003', 'Limeira',TRUE),
('Juan Pablo', 'juan@email.com','199999999004', 'Limeira',TRUE),
('Jonas Dawid', 'jonas@email.com','199999999005', 'Limeira',TRUE),
('John Pierre', 'Pierre@email.com','199999999006', 'Limeira',TRUE),
('Nicollas Lombas', 'fortin@email.com','199999999007', 'Limeira',TRUE),
('Kauan Mello', 'soufiel@email.com','199999999008', 'Limeira',TRUE);

SELECT * FROM cliente;
INSERT INTO categoria (nome) VALUES
('CAFÉS'), ('BEBIDAS GELADAS'), ('DOCES'),('SALGADOS'),('COMBOS');
INSERT INTO PRODUTO 
(NOME, PRECO, ATIVO, ID_CATEGORIA) VALUES
('CAFÉ ESPRESSO', 7.00, TRUE, 1),
('CAFÉ DUPLO', 10.00, TRUE, 1),
('CAFÉ COM LEITE', 9.50, TRUE, 1),
('CAPPUCCCINO', 13.00, TRUE, 1),
('MONSTER COM CAFÉ', 18.00, TRUE, 3),
('COCA COM CAFÉ', 20.00, TRUE, 2),
('LEITE NESQUIK', 17.00, TRUE, 1),
('LEITE ACHOCOLATADO', 30.00, TRUE, 1);

INSERT INTO pedido (data_pedido, status, valor_total, id_cliente) VALUES
('2026-09-01 08:15:00', 'FINALIZADO', 16.00, 1),
('2026-09-01 09:30:00', 'FINALIZADO', 26.00, 2),
('2026-09-02 10:20:00', 'CANCELADO', 18.00, 3),
('2026-09-03 14:10:00', 'FINALIZADO', 35.50, 1),
('2026-09-04 16:40:00', 'FINALIZADO', 20.00, 4),
('2026-09-05 11:05:00', 'PREPARANDO', 31.50, 5),
('2026-09-06 08:50:00', 'FINALIZADO', 28.00, 6),
('2026-09-07 17:25:00', 'FINALIZADO', 44.00, 2),
('2026-09-08 13:15:00', 'ABERTO', 13.00, 7),
('2026-09-09 09:45:00', 'FINALIZADO', 39.00, 1);
 SET @PEDIDO = LAST_INSERT_ID();
 SELECT @PEDIDO;

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, observacao) VALUES
(1,1,1,7.00,NULL),(1,9,1,9.00,NULL),(2,4,2,13.00,'Sem canela'),
(3,7,1,18.00,NULL),(4,5,1,15.50,NULL),(4,16,1,20.00,NULL),
(5,16,1,20.00,NULL),(6,4,1,13.00,NULL),(6,7,1,18.00,NULL),
(7,6,2,14.00,NULL),(8,14,2,16.00,NULL),(8,12,2,6.00,NULL),
(9,4,1,13.00,NULL),(10,3,2,9.50,NULL),(10,16,1,20.00,NULL);

INSERT INTO forma_pagamento (descricao) VALUES
('Dinheiro'), ('PIX'), ('Cartão de Crédito'), ('Cartão de Débito');

INSERT INTO pagamento (id_pedido, id_forma_pagamento, valor, data_pagamento) VALUES
(1,2,16.00,'2026-09-01 08:20:00'),(2,4,26.00,'2026-09-01 09:40:00'),
(4,3,35.50,'2026-09-03 14:20:00'),(5,2,20.00,'2026-09-04 16:45:00'),
(7,1,28.00,'2026-09-06 09:00:00'),(8,3,30.00,'2026-09-07 17:30:00'),
(8,2,14.00,'2026-09-07 17:31:00'),(10,2,39.00,'2026-09-09 09:50:00');

SELECT 'Base smartcoffee_dml criada com sucesso.' AS mensagem;



-- EX 1: UPDATE OU ATUALIZAÇÕES DE DE DADOS
UPDATE cliente
SET telefone = '1999990210'
WHERE id_cliente = 3;

-- EX 2: ATUALIZANDO VARIOS CAMPOS
UPDATE cliente
SET telefone = '1999999999'
    cidade = Piracicaba
WHERE id_cliente = 5;

---EX 3: ATUALIZANDO VÁRIOS REGISTROS
UPDATE produto
SET PRECO = PRECO * 1.05
WHERE ID_CATEGORIA = 1;

---EX 4: ATUALIZANDO SEM WHERE
---EX 3: ATUALIZANDO VÁRIOS REGISTROS
--UPDATE produto
--SET PRECO = PRECO * 1.05

---EX 5:ATUALIZANDO CONDICIONAIS
UPDATE produto
SET preco = CASE 
    WHEN preco THEN preco * 1.10
    ELSE preco * 1.05
END
WHERE ativo = TRUE;

-- EX 6 : ATUALIZANDO PARA NULL
UPDATE PRODUTO
SET PRECO = CASCADE
    WHEN PRECO <= 15 THEN PRECO * 1.10
    ELSE PRECO * 1.05
END
WHERE ATIVO = TRUE;