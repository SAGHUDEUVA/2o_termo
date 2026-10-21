-- Active: 1788351675873@@127.0.0.1@3306@smartcoffee_dml_juan
INSERT INTO cliente (NOME, EMAIL, TELEFONE, CIDADE, ATIVO) VALUES
('Edson wladmir', 'edson@email.com','19999888244','Paris', true);


------------------- INICIANDO OS EXEMPLOS --------------------

select caluna
from tabela;

-- EX 1: select para consultar todas as colunas
SELECT * FROM cliente;

-- EX 2: consultando por colunas
select nome, email from cliente;

-- EX 3: inserindo apelido nas colunas -- ALIAS
select nome as cliente
FROM cliente;
select nome as cliente, telefone as contato, ativo as status
from cliente;
select nome, preco, preco * 0.90 as preço_promocional
from produto;

-- EX 4: DISTINCT - eliminar repetições
select cidade from cliente;
select DISTINCT cidade
from cliente;
-- SEM DISTINCT O ITEM IRÁ APARECER VÁRIAS VEZES
-- COM DISTINCT O ITEM IRÁ APARECER APENAS UMA VEZ

-- EX 5: WHERE - Filtro em registros
select nome, preco
from produto
where preco > 10;

-- retorna valores acima de 10 reais em seus preços --

select nome, preco
from cliente
where ativo = TRUE;

select id_pedido, data-pedido, valor_total
from pedido
where valor_total >= 25.00;
----- retorna pedidos acima de determinado valor -------
-- = IGUAL
-- <> OU != DIFERENTE
-- >= MAIOR OU IGUAL
-- > MAIOR QUE
-- < MENOR QUE
-- <= MENOR OU IGUAL

-- EX 6: Uso do end, or e not
-- AND - todas as condições precisam ser verdadeiras
select nome, preco
from produto
where preco >= 8.00 and preco <= 20.00;

-- OR - pelo menos uma condição verdadeira
select nome, cidade
from cliente
where cidade = 'Limeira' or cidade = 'Piracicaba';

NOT - NEGAR NÃO TRAZER RSEULTADO QUE FOI APRESENTADO
select nome, cidade
from cliente
where not cidade = 'Limeira';

-- juntos - and e or
select nome, cidade, ativo AS Status
from cliente
where ativo = TRUE
AND (cidade = 'Limeira' OR cidade = 'Americana');

-- EX 7: pesquisando por intervalos - BETWEEN
select nome, preco
from produto
where preco BETWEEN 8.00 and 15.00;

select id_pedido, data_pedido, valor_total
from pedido
where data_pedido BETWEEN '2026-09-01' and '2026-09-30 23:59:59';

-- EX 8: in com várias possibilidades
select nome, cidade
from cliente
where cidade in ('Limeira', 'Americana', 'Piracicaba');

select nome, cidade
from cliente
where cidade not in ('Limeira', 'Campinas');

-- EX 9: exemplo com textos ou pesquisar por textos - like
-- coringas
-- % vários caracteres
-- _ exatamente um caracter

select nome
from produto
where nome LIKE'Café%';
-- retornar produtos que possuem a palavra café e que começam com ela

select nome
from produto
where nome LIKE '%chocolate%';
-- retornar produtos que possuem a palavra chocolate

select nome
from produto
where nome LIKE '%Silva%';
-- retornar nomes que terminam com silva

select nome
from produto
where nome like '_afé%';

-- Ex 10: NULL - AUSÊNCIA DE VALOR
select nome, telefone
from cliente
where telefone is null;

-- EX 11: order by - ordenar resultados
-- ASC significa cerscente
-- DESC significa decrescente

select nome, preco
from produto
order by preco ASC;

select nome,preco
from produto
order by preco DESC;

select cidade, nome
from cliente
order by cidade asc, nome desc;

-- EX 12: LIMIT - limitando a quantidade de linha
select nome, preco
from produto
order by preco DESC
limit 5;

select nome, preco
from produto
order by nome
limit 5 OFFSET 5;

-- EX 13: cálculo de colunas
select nome, preco * 1.10 as preco_atualizado
from produto;

select id_item, quantidade, preco_unitario, quantidade * preco_unitario AS total_compra
from item_pedido;

-- EX 14: funções pra consulta
-- textos
select upper(nome) as nome_Cliente, LOWER(email) AS Email
from cliente;

select concat(nome, ' - ', cidade) as Cliente_Cidade
from cliente;

-- NÚMEROS
SELECT nome, preco, ROUND(preco * 1.90, 2) AS Preço_Desconto
FROM produto;

-- DATAS
SELECT id_pedido, data_pedido, DATE(data_pedido) AS DIAS, MONTH(data_pedido) AS MÊS, YEAR(data_pedido) AS ANO
FROM pedido;

-- SUBSTITUINDO O NULL NO RESULTADO - COALESCE
SELECT nome, COALESCE(telefone, 'Não Informado') AS Contato
FROM cliente;

-- EX 15: FUNÇÕES DE AGREGAÇÃO - SUM, AVG, MIN, MAX, COUNT
-- COUNT - CONTAR QUANTIDADE DE REGISTROS
-- SUM - SOMA DE VALORES
-- AVG - MÉDIA DE VALORES
-- MIN - MENOR VALOR
-- MAX - MAIOR VALOR
SELECT COUNT(*) AS Total_Clientes
from cliente;
-- resultado de quantidade de clientes

select AVG(preco) as média_preços
from produto;
-- média do valor dos produtos

select min(preco) as promoção, max(preco) as reajuste, avg(preco) as média_preços
from produto

select sum(valor_total) as faturamento mensal
from pedido
where status = 'FINALIZADO'
-- total de pedidos finalizados

-- EX 16: group by - agrupar dados
select cidade, COUNT(*) as qtde_cidades
from cliente
group by cidade;
select id_categoria, count(*) as qtde_produtos
from produto
group by id_categoria;
-- quantidade de produtos por categoria

-- EX 17: having - filtro por grupos
select cidade, count(*) as quantidade_clientes
from cliente
group by cidade
having count(*) >= 2;
-- dica: usar o having e não esquecer o group by

-- EX 18: consulta completa
select colunas
from tabelas
where condicao
group by colunas_agrupar
HAVING condicao
order by colunas
limit quantidade;
-- dica para seguir em ordem lógica para uma consulta parcial ou completa
-------------------------------------------------------------------------

-- PARTE II - RELACIONAMENTOS ENTRE TABELAS - JOINS
-- JOIN - JUNÇÃO DE TABELAS
-- EX 19: PEDIDOS COM NOME DO CLIENTE
-- INNER JOIM - RETORNA REGISTROS QUE POSSUEM CORRESPONDÊNCIAS ENTRE TABELAS
SELECT P.ID_PEDIDO, P.DATA_PEDIDO, C.NOME AS CLIENTE , P.VALOR_TOTAL
FROM PEDIDO AS P
INNER JOIN CLIENTE AS C
ON C.ID_CLIENTE = P.ID_CLIENTE;


-- OBS: RELACIONE O CLIENTE CUJO ID_CLIENTE É IGUAL AP ID_CLIENTE É IGUAL AP ID_CLIENTE GRAVADO NO PEDIDO
-- P E C SÃO APELIDOS OU ALIASES PARA DEIXAR MAIS CURTAS E LEGIVEIS

-- LEFT JOIN - MANTÉM TODOS OS REGISTROS DA TABELA DA ESQUERDA MESMO QUANDO NÃO POSSUI CORRESPONDÊNCIA NA TABELA DA DIREITA
-- EX 20: TODOS OS CLIENTES , INCLUSIVE QUEM NUNCA COMPROU OU QUEM NUNCA REALIZOU PEDIDO
SELECT C.NOME, P.ID_PEDIDO, P.DATA_PEDIDO
FROM CLIENTE AS C
LEFT JOIN PEDIDO AS P
ON P.ID_CLIENTE = C.ID_CLIENTE
ORDER BY C.NOME;



-- EX 21: CLIENTES SEM PEDIDOS
SELECT C.ID_CLIENTE, C.NOME
FROM CLIENTE AS C
LEFT JOIN PEDIDO AS P
ON P.ID_CLIENTE = C.ID_CLIENTE
WHERE P.ID_PEDIDO IS NULL;


-- JOIN COM TRÊS TABELAS
-- EX 22: ITENS DE PEDIDO COM NOME DO PRODUTO
SELECT P.ID_PEDIDO, PR.NOME AS PRODUTO, IP.QUANTIDADE, IP.PRECO_UNITARIO,
IP.QUANTIDADE * IP.PRECO_UNITARIO AS SUBTOTAL
FROM PEDIDO AS P
INNER JOIN ITEM_PEDIDO AS IP
ON IP.ID_PEDIDO = P.ID_PEDIDO
INNER JOIN PRODUTO AS PR
ON PR.ID_PRODUTO = IP.ID_PRODUTO
ORDER BY P.ID_PEDIDO;

-- EX 23 - AGREGAÇÃO + JOINS
-- QUANTIDADE DE PRODUTOS POR CATEGORIA
SELECT CA.NOME AS CATEGORIA, COUNT(PR.ID_PRODUTO) AS QTDE_PRODUTOS
FROM CATEGORIA AS CA
LEFT JOIN PRODUTO AS PR
ON PR.ID_CATEGORIA = CA.ID_CATEGORIA
GROUP BY CA.ID_CATEGORIA, CA.NOME
ORDER BY QTDE_PRODUTOS DESC

-- EX 24: TOTAL COMPRADO POR CLIENTE 
SELECT C.NOME AS CLIENTE, COUNT(P.ID_PEDIDO) AS QTDE_PEDIDOS, SUM(P.
VALOR_TOTAL) AS TOTAL_COMPRADO
FROM CLIENTE AS C
INNER JOIN PEDIDO AS P
ON P.ID_CLIENTE = C.ID_CLIENTE
WHERE P.STATUS = 'FINALIZADO'
GROUP BY C.ID_CLIENTE, C.NOME
ORDER BY TOTAL_COMPRADO DESC;

-- RELATÓRIO COMPLETO DO PEDIDO
-- 25: COMBINAR VÁRIAS TABELAS EM UMA CONSULTA
SELECT P.ID_PEDIDO, DATE_FORMAT(P.DATA_PEDIDO, '%d %m %Y %H:%i') AS DATA,
C.NOME AS CLIENTE, PR.NOME AS PRODUTO, IP.QUANTIDADE, IP.PRECO_UNITARIO,
IP.QUANTIDADE * IP.PRECO_UNITARIO AS SUBTOTAL
FROM PEDIDO AS P
INNER JOIN CLIENTE AS C
ON C.ID_CLIENTE = P.ID_CLIENTE
INNER JOIN ITEM_PEDIDO AS IP
ON IP.ID_PEDIDO = P.ID_PEDIDO
INNER JOIN PRODUTO AS PR
ON PR.ID_PRODUTO = IP.ID_PRODUTO
ORDER BY P.ID_PEDIDO, PR.NOME;

-- OBS: PADRÃODE FORMATAÇÃO DE DATA NO BRASIL
-- DATE_FORMAT(P.DATA_PEDIDO, '%d %m %Y %H %i')

-- CRIANDO CLASSIFICAÇÕES
-- EX 26 - CASE - PERMITE CONSTRUIR UMA CLASSIFICAÇÃO BASEADA EM REGRAS
SELECT NOME, PRECO,
CASE
    WHEN PRECO < 8.00 THEN 'Econômico'
    WHEN PRECO <= 15.00 THEN 'Intermediário'
    ELSE 'Premium'
END AS CLASSIFICAÇÃO
FROM PRODUTO
ORDER BY PRECO;

-- SUBCONDUTA
-- É UMA CONSULTA DENTRO DE OUTRA CONSULTA
-- EX 27: PRODUTOS ACIMA DO PREÇO MÉDIO
SELECT NOME, PRECO
FROM PRODUTO
WHERE PRECO > (SELECT AVG(PRECO)
FROM PRODUTO
)
ORDER BY PRECO DESC;

-- PASSO 1 - VISUALIZAR PRODUTOS
▷Run | +Tab | JSON
SELECT * FROM PRODUTO;

-- PASSO 2 - SELECIONAR SOMENTE O NECESSÁRIO
▷Run | +Tab | JSON | 📋Select
SELECT NOME, PRECO FROM PRODUTO

-- PASSO 3 - FILTRO
SELECT NOME, PRECO FROM PRODUTO
WHERE PRECO >= 10;

-- PASSO 4 - ORDENAR INFORMAÇÕES
▷Run | +Tab | JSON
SELECT NOME, PRECO FROM PRODUTO
WHERE PRECO >= 10.00
ORDER BY PRECO DESC;

-- PASSO 5 - MOSTRAR CATEGORIA
▷Run | +Tab | JSON | 📋Select
SELECT PR.NOME AS PRODUTO, CA.NOME AS CATEGORIA, PR.PRECO
FROM PRODUTO AS PR
INNER JOIN CATEGORIA AS CA
ON CA.ID_CATEGORIA = PR.ID_CATEGORIA
WHERE PR.PRECO >= 10.00
ORDER BY PR.PRECO DESC;
-- PASSO 6 -  PERGUNTA GERENCIAL
SELECT CA.NOME AS CATEGORIA, COUNT(PR.ID_PRODUTO) AS PRODUTOS, ROUND(AVG(PR.PRECO),2) AS PREÇO_MÉDIO
FROM CATEGORIA AS CA
INNER JOIN PRODUTO AS PR
ON PR.ID_CATEGORIA = CA.ID_CATEGORIA
GROUP BY CA.ID_CATEGORIA, CA.NOME
ORDER BY PREÇO_MÉDIO DESC;
