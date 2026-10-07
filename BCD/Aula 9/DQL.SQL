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
