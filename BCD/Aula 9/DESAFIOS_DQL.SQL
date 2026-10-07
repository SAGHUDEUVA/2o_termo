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
