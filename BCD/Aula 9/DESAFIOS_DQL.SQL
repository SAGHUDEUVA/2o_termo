-- Active: 1788351675873@@127.0.0.1@3306@smartcoffee_dml_juan
-- ============================================================
-- AULA 09 - ATIVIDADE PRÁTICA DE DQL
-- Nome: Juan pablo da assumpção
-- Turma: 2DEVIE Data: 07/10/2026
-- Base: smartcoffee_dql
-- ============================================================
USE smartcoffee_dql;

-- ============================================================
-- PARTE A - AQUECIMENTO
-- ============================================================

-- 1. Liste todos os clientes cadastrados.
SELECT *
FROM clientes;


-- 2. Exiba apenas nome, cidade e e-mail dos clientes.
SELECT nome, cidade, email
FROM clientes;


-- 3. Liste os nomes das cidades sem repetir valores.
SELECT DISTINCT cidade
FROM clientes;


-- 4. Liste todos os produtos em ordem crescente de preço.
SELECT *
FROM produtos
ORDER BY preco ASC;


-- 5. Mostre apenas os 5 produtos mais caros.
SELECT *
FROM produtos
ORDER BY preco DESC
LIMIT 5;


-- ============================================================
-- PARTE B - FILTROS
-- ============================================================

-- 6. Liste os produtos com preço entre R$ 8,00 e R$ 15,00.
SELECT *
FROM produtos
WHERE preco BETWEEN 8.00 AND 15.00;


-- 7. Liste os clientes das cidades Limeira ou Americana.
SELECT *
FROM clientes
WHERE cidade IN ('Limeira', 'Americana');


-- 8. Localize os produtos cujo nome contém a palavra “Café”.
SELECT *
FROM produtos
WHERE nome LIKE '%Café%';


-- 9. Liste os clientes que não informaram telefone.
SELECT *
FROM clientes
WHERE telefone IS NULL;


-- 10. Mostre os pedidos FINALIZADOS com valor acima de R$ 20,00,
--     do maior para o menor valor.
SELECT *
FROM pedidos
WHERE status = 'FINALIZADO'
  AND valor > 20.00
ORDER BY valor DESC;


-- ============================================================
-- PARTE C - CÁLCULOS E AGRUPAMENTOS
-- ============================================================

-- 11. Informe quantos produtos estão cadastrados.
SELECT COUNT(*) AS quantidade_produtos
FROM produtos;


-- 12. Mostre menor preço, maior preço e preço médio dos produtos.
SELECT
    MIN(preco) AS menor_preco,
    MAX(preco) AS maior_preco,
    AVG(preco) AS preco_medio
FROM produtos;


-- 13. Informe quantos clientes existem em cada cidade.
SELECT
    cidade,
    COUNT(*) AS quantidade_clientes
FROM clientes
GROUP BY cidade;


-- 14. Mostre somente as cidades que possuem dois ou mais clientes.
SELECT
    cidade,
    COUNT(*) AS quantidade_clientes
FROM clientes
GROUP BY cidade
HAVING COUNT(*) >= 2;


-- 15. Calcule o faturamento total considerando apenas pedidos FINALIZADOS.
SELECT SUM(valor) AS faturamento_total
FROM pedidos
WHERE status = 'FINALIZADO';

-- ============================================
-- PARTE D - RELACIONAMENTOS
-- ============================================

-- 16. Liste cada pedido exibindo id, data, nome do cliente,
-- status e valor total.

SELECT
    p.id,
    p.data_pedido,
    c.nome AS nome_cliente,
    p.status,
    p.valor_total
FROM pedidos p
INNER JOIN clientes c
    ON p.cliente_id = c.id;


-- 17. Liste cada produto acompanhado do nome de sua categoria.

SELECT
    p.nome AS produto,
    c.nome AS categoria
FROM produtos p
INNER JOIN categorias c
    ON p.categoria_id = c.id;


-- 18. Gere um relatório dos itens vendidos: pedido, produto,
-- quantidade, preço unitário e subtotal.

SELECT
    ip.pedido_id AS pedido,
    p.nome AS produto,
    ip.quantidade,
    ip.preco_unitario,
    (ip.quantidade * ip.preco_unitario) AS subtotal
FROM itens_pedido ip
INNER JOIN produtos p
    ON ip.produto_id = p.id;


-- 19. Mostre todos os clientes, inclusive aqueles que nunca
-- fizeram pedidos.

SELECT
    c.id,
    c.nome,
    p.id AS pedido_id,
    p.data_pedido,
    p.status
FROM clientes c
LEFT JOIN pedidos p
    ON c.id = p.cliente_id;


-- 20. Liste apenas os clientes que nunca fizeram pedidos.

SELECT
    c.id,
    c.nome
FROM clientes c
LEFT JOIN pedidos p
    ON c.id = p.cliente_id
WHERE p.id IS NULL;


-- ============================================
-- PARTE E - DESAFIO GERENCIAL
-- ============================================

-- 21. Informe quantos pedidos FINALIZADOS cada cliente realizou
-- e quanto cada cliente gastou. Ordene do maior gasto para o menor.

SELECT
    c.id,
    c.nome AS cliente,
    COUNT(p.id) AS total_pedidos_finalizados,
    COALESCE(SUM(p.valor_total), 0) AS total_gasto
FROM clientes c
LEFT JOIN pedidos p
    ON c.id = p.cliente_id
    AND p.status = 'FINALIZADO'
GROUP BY
    c.id,
    c.nome
ORDER BY total_gasto DESC;


-- 22. Mostre a quantidade de produtos e o preço médio
-- de cada categoria.

SELECT
    c.nome AS categoria,
    COUNT(p.id) AS quantidade_produtos,
    ROUND(AVG(p.preco), 2) AS preco_medio
FROM categorias c
LEFT JOIN produtos p
    ON c.id = p.categoria_id
GROUP BY
    c.id,
    c.nome;


-- 23. Descubra quais produtos possuem preço superior
-- ao preço médio geral.

SELECT
    id,
    nome AS produto,
    preco
FROM produtos
WHERE preco > (
    SELECT AVG(preco)
    FROM produtos
);


-- 24. Classifique os produtos como Econômico,
-- Intermediário ou Premium.
-- Econômico: até R$ 50,00.
-- Intermediário: acima de R$ 50,00 até R$ 200,00.
-- Premium: acima de R$ 200,00.

SELECT
    id,
    nome AS produto,
    preco,
    CASE
        WHEN preco <= 50 THEN 'Econômico'
        WHEN preco <= 200 THEN 'Intermediário'
        ELSE 'Premium'
    END AS classificacao
FROM produtos
ORDER BY preco;


-- 25. CONSULTA AUTORAL
-- Pergunta de negócio:
-- Quais são os cinco produtos mais vendidos em quantidade?
--
-- Por que essa informação é útil?
-- Permite identificar os produtos com maior demanda,
-- auxiliar na reposição de estoque e planejar compras.
--
-- Consulta:

SELECT
    p.id,
    p.nome AS produto,
    SUM(ip.quantidade) AS quantidade_vendida
FROM produtos p
INNER JOIN itens_pedido ip
    ON p.id = ip.produto_id
INNER JOIN pedidos pe
    ON ip.pedido_id = pe.id
WHERE pe.status = 'FINALIZADO'
GROUP BY
    p.id,
    p.nome
ORDER BY quantidade_vendida DESC
LIMIT 5;