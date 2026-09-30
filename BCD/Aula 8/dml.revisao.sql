-- Active: 1788351675873@@127.0.0.1@3306@smartcoffee_dml_juan
use smartcoffee_dml_juan;

--inserindo dados no BD
-- DML: INSERTS , UPDATE , DELETE
INSERT INTO cliente (nome,email,telefone,cidade,ativo) VALUES
('Adryan Costa','adryan@email.com','199999901','Limeira',TRUE),
('Ana Francisca','ana@email.com','199999902','Lençóis Paulista',TRUE),
('Anna Julia','anaj@email.com','199999903','Limeira',TRUE),
('Beatriz Barros','beatrizb@email.com','199999904','Limeira',TRUE),
('Beatriz Santana','beatrizs@email.com','199999905','Limeira',TRUE),
('Bruno Dias','bruno@email.com','199999906','Limeira',TRUE),
('Cristopher da Costa','cristopher@email.com','199999907','Mogi Guaçu',TRUE),
('Davi Guerra','davi@email.com',NULL,'Limeira',TRUE),
('Gabriel Lucio','grabiel@email.com','199999908','Limeira',TRUE),
('Gabriela Lima','gabriela@email.com','199999909','Curitiba',TRUE),
('Giovana Santana','giovana@email.com',NULL,'Juquerópolis',FALSE),
('Gustavo Couto','gustavo@email.com','199999910','Ipatinga',FALSE),
('Isabeli Sousa','isabeli@email.com',NULL,'Limeira',TRUE),
('Jacó de Souza','jaco@email.com','199999911','Limeira',TRUE),
('João Moreira','joao@email.com','199999912','Limeira',TRUE),
('John Pierre','john@email.com','199999913','cap haitien',TRUE),
('Jonas Dawid','jonas@email.com','199999914','Rio de Janeiro',TRUE),
('Juan Pablo','juan@email.com','199999915','Limeira',TRUE),
('Julia Fernanda','julia@email.com','199999916','Limeira',TRUE);

insert into produto (nome,preco,ativo,id_categoria) values
('Manteiga Giovana',14.00,true,5)

INSERT INTO pedido (data_pedido,status,valor_total,id_cliente) VALUES
(NOW(),'ABERTO',14.00,118)

SET @pedido = LAST_INSERT_ID();
SELECT @pedido;

-- CONSULTAR DADOS EM TABELAS BD
-- CONSULTAR TODA A TABELA
SELECT * FROM cliente;
-- CONSULTAR INDIVIDUAL POR ID
SELECT * FROM cliente
WHERE id_cliente = 115;

Run Select
UPDATE cliente
SET ativo TRUE
WHERE id cliente = 18;

-- NUNCA, JAMAIS, NEVER ESQUEÇAM DE UTILIZAR O WHERE

-- REGRA DE OURO
--PRIMEIRA ΕΤΑΡΑ
Run+Tab ISON
SELECT FROM cliente
WHERE id_cliente = 18;

-- SEGUNDA ETAPA
Run | Select
UPDATE cliente
SET ativo = FALSE
WHERE id_cliente = 18;
--EX 2: ATUALIZANDO MAIS DO QUE Um CAMPO
UPDATE cliente
SET telefone = '1999888016',
    cidade = 'Campinas'
WHERE id_cliente = 18;

Run
DELETE FROM cliente
- WHERE id_cliente = 18;


-- EX 3: ATUALIZANDO COM CONDICIONAIS
▷Run | ▢Select
UPDATE produto
SET preco = preco * 2.50
WHERE id_categoria = 1;


--ATUALIZANDO OU MODIFICANDO DADOS NO BD
--EX 1: ATUALIZANDO INFORMAÇÕS INDIVIDUAIS
DRun | Select
UPDATE cliente
SET telefone = 19999888801'
WHERE



--PASSO 2: CRIAR O PEDIDO
Run
INSERT INTO pedido (data_pedido, status, valor_total, id_cliente) VALUES
(NOW(), 'ABERTO', 0.00, 102);
DRun
SET @pedido LAST_INSERT_ID();

-- PASSO 3: INSERIR ITENS NO PEDIDO

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(@pedido,4,1,73.13),
(@pedido,11,1,11.25);

-- PASSO 4: ATUALIZAR O TOTAL E STATUS

UPDATE pedido
SET valor_total = 84.38,
    status = 'Preparando'
WHERE id_pedido = @pedido;

-- PASSO 5: PROCESSAR PAGAMENTO
