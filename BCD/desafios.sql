-- ============================================================
-- AULA 08 - ATIVIDADE PRÁTICA DE DML
-- Nome: JUAN PABLO DA ASSUMPÇÃO
-- Turma: ______________________ Data: 30/09-2026
-- Base: smartcoffee_dml_juan
-- ============================================================
USE smartcoffee_dml_juan;

-- IMPORTANTE:
-- Para toda questão de UPDATE ou DELETE, escreva primeiro um SELECT
-- com o mesmo WHERE para validar os registros afetados.

-- PARTE A - INSERT

-- 1. Cadastre dois novos clientes com dados diferentes.


-- 2. Cadastre a categoria 'Especiais da Casa'.


-- 3. Localize o id da categoria criada e cadastre três produtos nela.


-- 4. Cadastre um terceiro cliente sem telefone.


-- 5. Crie um novo pedido para um dos clientes cadastrados.


-- 6. Use LAST_INSERT_ID() para guardar o id do pedido em @pedido_atividade
--    e insira pelo menos dois itens nesse pedido.


-- PARTE B - UPDATE

-- 7. Corrija o telefone de um dos clientes criados.
-- SELECT de validação:
-- UPDATE:
-- SELECT final:


-- 8. Altere cidade e telefone de outro cliente em um único UPDATE.


-- 9. Aumente em 8% o preço dos produtos da categoria 'Especiais da Casa'.


-- 10. Altere o status do pedido criado para 'PREPARANDO'.


-- 11. Atualize valor_total do pedido de acordo com os itens cadastrados.
--     Você pode calcular previamente com SELECT SUM(quantidade * preco_unitario).


-- 12. Escolha um dos produtos criados e faça uma exclusão lógica (ativo = FALSE).


-- PARTE C - DELETE

-- 13. Crie um cliente de teste sem pedidos.
--     Depois localize e exclua apenas esse cliente.


-- 14. Tente excluir um cliente da base original que possua pedidos.
--     Deixe o DELETE comentado após o teste e descreva o erro abaixo.
-- Resultado observado:


-- 15. Explique em comentário por que a FK bloqueou a exclusão.
-- Resposta:


-- 16. Crie uma categoria temporária chamada 'Excluir Depois' e remova-a.


-- PARTE D - INTEGRIDADE E ERROS CONTROLADOS
-- Execute uma tentativa por vez. Depois deixe o comando problemático comentado.

-- 17. Tente inserir um produto com id_categoria = 9999.
-- Qual restrição impediu a operação?


-- 18. Tente cadastrar um cliente usando 'ana@email.com'.
-- Qual restrição impediu a operação?


-- 19. Tente criar um pedido com id_cliente = 9999.
-- Qual restrição impediu a operação?


-- 20. Escreva em comentários a diferença entre os três erros anteriores.


-- PARTE E - DESAFIO COMPLETO COM TRANSAÇÃO

-- 21. Inicie uma transação.


-- 22. Dentro dela, cadastre um cliente, um pedido e dois itens relacionados.


-- 23. Faça uma consulta com JOIN comprovando que os registros existem
--     enquanto a transação está aberta.


-- 24. Execute ROLLBACK e depois use SELECT para provar que o cadastro foi desfeito.


-- 25. Repita o processo com novos dados e finalize usando COMMIT.
--     Depois consulte os registros persistidos.


-- DESAFIO EXTRA
-- 26. Escolha uma situação realista do SmartCoffee que exija INSERT + UPDATE
--     ou UPDATE + DELETE lógico. Descreva a regra de negócio e implemente.



USE smartcoffee_dml_juan;


-- PARTE A - INSERT

-- 1. Dois clientes
INSERT INTO clientes (nome, email, telefone, cidade) VALUES
('Carlos Mendes', 'carlos.atividade@email.com', '11988887777', 'Sao Paulo'),
('Mariana Costa', 'mariana.atividade@email.com', '21977776666', 'Rio de Janeiro');

-- 2. Categoria
INSERT INTO categorias (nome) VALUES ('Especiais da Casa');

-- 3. Três produtos
SET @cat = (SELECT id_categoria FROM categorias WHERE nome = 'Especiais da Casa' LIMIT 1);
INSERT INTO produtos (nome, id_categoria, preco, ativo) VALUES
('Cafe Especial', @cat, 18.90, TRUE),
('Capuccino', @cat, 14.50, TRUE),
('Mocha', @cat, 16.00, TRUE);

-- 4. Cliente sem telefone
INSERT INTO clientes (nome, email, telefone, cidade)
VALUES ('Pedro Almeida', 'pedro.atividade@email.com', NULL, 'Curitiba');

-- 5. Pedido
SET @cli = (SELECT id_cliente FROM clientes WHERE email = 'carlos.atividade@email.com');
INSERT INTO pedidos (id_cliente, data_pedido, status, valor_total)
VALUES (@cli, NOW(), 'ABERTO', 0);

-- 6. Itens do pedido
SET @pedido_atividade = LAST_INSERT_ID();
SET @p1 = (SELECT id_produto FROM produtos WHERE nome = 'Cafe Especial' LIMIT 1);
SET @p2 = (SELECT id_produto FROM produtos WHERE nome = 'Capuccino' LIMIT 1);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (@pedido_atividade, @p1, 2, 18.90),
       (@pedido_atividade, @p2, 1, 14.50);

-- PARTE B - UPDATE

-- 7. Corrigir telefone
SELECT * FROM clientes WHERE email = 'carlos.atividade@email.com';
UPDATE clientes SET telefone = '11999990000' WHERE email = 'carlos.atividade@email.com';
SELECT * FROM clientes WHERE email = 'carlos.atividade@email.com';

-- 8. Alterar cidade e telefone
SELECT * FROM clientes WHERE email = 'mariana.atividade@email.com';
UPDATE clientes SET cidade = 'Belo Horizonte', telefone = '31988880000'
WHERE email = 'mariana.atividade@email.com';
SELECT * FROM clientes WHERE email = 'mariana.atividade@email.com';

-- 9. Aumentar preços em 8%
SELECT * FROM produtos WHERE id_categoria = @cat;
UPDATE produtos SET preco = ROUND(preco * 1.08, 2) WHERE id_categoria = @cat;
SELECT * FROM produtos WHERE id_categoria = @cat;

-- 10. Atualizar status
SELECT * FROM pedidos WHERE id_pedido = @pedido_atividade;
UPDATE pedidos SET status = 'PREPARANDO' WHERE id_pedido = @pedido_atividade;
SELECT * FROM pedidos WHERE id_pedido = @pedido_atividade;

-- 11. Atualizar total
SELECT SUM(quantidade * preco_unitario) FROM itens_pedido WHERE id_pedido = @pedido_atividade;
SELECT * FROM pedidos WHERE id_pedido = @pedido_atividade;
UPDATE pedidos SET valor_total = (SELECT SUM(quantidade * preco_unitario)
FROM itens_pedido WHERE id_pedido = @pedido_atividade)
WHERE id_pedido = @pedido_atividade;
SELECT * FROM pedidos WHERE id_pedido = @pedido_atividade;

-- 12. Exclusão lógica
SELECT * FROM produtos WHERE nome = 'Mocha' AND id_categoria = @cat;
UPDATE produtos SET ativo = FALSE WHERE nome = 'Mocha' AND id_categoria = @cat;
SELECT * FROM produtos WHERE nome = 'Mocha' AND id_categoria = @cat;

-- PARTE C - DELETE

-- 13. Cliente de teste
INSERT INTO clientes (nome, email) VALUES ('Teste Exclusao', 'teste.exclusao@email.com');
SELECT * FROM clientes WHERE email = 'teste.exclusao@email.com'
AND NOT EXISTS (SELECT 1 FROM pedidos WHERE pedidos.id_cliente = clientes.id_cliente);
DELETE FROM clientes WHERE email = 'teste.exclusao@email.com'
AND NOT EXISTS (SELECT 1 FROM pedidos WHERE pedidos.id_cliente = clientes.id_cliente);
SELECT * FROM clientes WHERE email = 'teste.exclusao@email.com';

-- 14. Teste de exclusão de cliente com pedidos
SELECT c.* FROM clientes c JOIN pedidos p ON c.id_cliente = p.id_cliente LIMIT 1;
-- DELETE FROM clientes WHERE id_cliente = ID_ENCONTRADO;
-- Resultado: erro de chave estrangeira porque existem pedidos vinculados.

-- 15. A FK impede excluir clientes que possuem pedidos associados,
-- pois isso deixaria registros relacionados sem um cliente válido.

-- 16. Categoria temporária
INSERT INTO categorias (nome) VALUES ('Excluir Depois');
SELECT * FROM categorias WHERE nome = 'Excluir Depois';
DELETE FROM categorias WHERE nome = 'Excluir Depois';
SELECT * FROM categorias WHERE nome = 'Excluir Depois';

-- PARTE D - ERROS CONTROLADOS

-- 17. Categoria inexistente: erro de FOREIGN KEY
-- INSERT INTO produtos (nome, id_categoria, preco, ativo)
-- VALUES ('Produto Erro', 9999, 10, TRUE);

-- 18. E-mail duplicado: erro de UNIQUE, se o e-mail já existir
-- INSERT INTO clientes (nome, email) VALUES ('Ana', 'ana@email.com');

-- 19. Cliente inexistente: erro de FOREIGN KEY
-- INSERT INTO pedidos (id_cliente, data_pedido, status, valor_total)
-- VALUES (9999, NOW(), 'ABERTO', 0);

-- 20. Questão 17: categoria inválida.
-- Questão 18: e-mail duplicado.
-- Questão 19: cliente inválido.

-- PARTE E - TRANSAÇÃO

-- 21 e 22. Cadastrar cliente, pedido e itens
START TRANSACTION;
INSERT INTO clientes (nome, email) VALUES ('Cliente Rollback', 'rollback@email.com');
SET @cr = LAST_INSERT_ID();
INSERT INTO pedidos (id_cliente, data_pedido, status, valor_total)
VALUES (@cr, NOW(), 'ABERTO', 0);
SET @pr = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (@pr, @p1, 1, 18.90), (@pr, @p2, 2, 14.50);

-- 23. Conferir durante a transação
SELECT * FROM clientes c JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE c.email = 'rollback@email.com';

-- 24. Desfazer e conferir
ROLLBACK;
SELECT * FROM clientes WHERE email = 'rollback@email.com';

-- 25. Repetir e confirmar
START TRANSACTION;
INSERT INTO clientes (nome, email) VALUES ('Cliente Commit', 'commit@email.com');
SET @cc = LAST_INSERT_ID();
INSERT INTO pedidos (id_cliente, data_pedido, status, valor_total)
VALUES (@cc, NOW(), 'ABERTO', 0);
SET @pc = LAST_INSERT_ID();
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES (@pc, @p1, 1, 18.90), (@pc, @p2, 2, 14.50);
UPDATE pedidos SET valor_total = (SELECT SUM(quantidade * preco_unitario)
FROM itens_pedido WHERE id_pedido = @pc) WHERE id_pedido = @pc;
COMMIT;
SELECT * FROM clientes c JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE c.email = 'commit@email.com';

-- 26. Regra de negócio: desativar produto fora de linha,
-- preservando seu histórico de vendas.
SELECT * FROM produtos WHERE nome = 'Cafe Especial' AND id_categoria = @cat;
UPDATE produtos SET ativo = FALSE WHERE nome = 'Cafe Especial' AND id_categoria = @cat;
SELECT * FROM produtos WHERE nome = 'Cafe Especial' AND id_categoria = @cat;