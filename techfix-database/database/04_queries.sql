-- ============================================================
-- TECHFIX - CONSULTAS SQL DIDÁTICAS
-- Arquivo: 04_queries.sql
-- Banco: MySQL 8+
-- ============================================================

USE techfix;

-- ============================================================
-- 1. SELECT BÁSICO
-- Mostra todos os clientes.
-- SELECT = define as colunas que serão exibidas.
-- FROM = define a tabela de origem.
-- ============================================================
SELECT *
FROM clientes;

-- ============================================================
-- 2. SELECT + ORDER BY
-- Lista os clientes em ordem alfabética.
-- ORDER BY = ordena o resultado.
-- ASC = crescente (A -> Z).
-- ============================================================
SELECT id_cliente, nome, cidade
FROM clientes
ORDER BY nome ASC;

-- ============================================================
-- 3. WHERE
-- Busca somente clientes de Diamantina.
-- WHERE = filtra registros antes de apresentar o resultado.
-- ============================================================
SELECT id_cliente, nome, email, cidade
FROM clientes
WHERE cidade = 'Diamantina';

-- ============================================================
-- 4. WHERE + ORDER BY
-- Busca clientes de Diamantina e ordena por nome.
-- ============================================================
SELECT id_cliente, nome, telefone
FROM clientes
WHERE cidade = 'Diamantina'
ORDER BY nome ASC;

-- ============================================================
-- 5. LIKE - começa com M
-- O % representa qualquer sequência de caracteres.
-- ============================================================
SELECT id_cliente, nome
FROM clientes
WHERE nome LIKE 'M%';

-- ============================================================
-- 6. LIKE - contém a letra A
-- '%a%' significa que existe um 'a' em qualquer posição.
-- ============================================================
SELECT id_cliente, nome
FROM clientes
WHERE nome LIKE '%a%';

-- ============================================================
-- 7. IN
-- Permite comparar com vários valores.
-- ============================================================
SELECT id_cliente, nome, cidade
FROM clientes
WHERE cidade IN ('Diamantina', 'Belo Horizonte');

-- ============================================================
-- 8. BETWEEN
-- Busca peças com preço entre R$ 100 e R$ 400.
-- BETWEEN inclui os dois limites.
-- ============================================================
SELECT id_peca, nome, preco
FROM pecas
WHERE preco BETWEEN 100 AND 400
ORDER BY preco;

-- ============================================================
-- 9. ESTOQUE BAIXO
-- Busca peças com menos de 10 unidades disponíveis.
-- ============================================================
SELECT id_peca, nome, estoque
FROM pecas
WHERE estoque < 10
ORDER BY estoque ASC;

-- ============================================================
-- 10. SERVIÇOS MAIS CAROS
-- DESC = ordem decrescente.
-- ============================================================
SELECT id_servico, nome, preco
FROM servicos
ORDER BY preco DESC;

-- ============================================================
-- 11. INNER JOIN
-- Mostra cada equipamento junto ao seu cliente.
-- JOIN = combina dados de tabelas relacionadas.
-- ON = informa como as tabelas se relacionam.
-- INNER JOIN retorna somente registros que possuem correspondência.
-- ============================================================
SELECT
    c.nome AS cliente,
    e.tipo,
    e.marca,
    e.modelo
FROM clientes c
INNER JOIN equipamentos e
    ON c.id_cliente = e.id_cliente
ORDER BY c.nome;

-- ============================================================
-- 12. JOIN DE 3 TABELAS
-- Cliente -> Equipamento -> Ordem de Serviço.
-- ============================================================
SELECT
    c.nome AS cliente,
    e.modelo,
    os.id_ordem,
    os.status
FROM clientes c
INNER JOIN equipamentos e
    ON c.id_cliente = e.id_cliente
INNER JOIN ordens_servico os
    ON e.id_equipamento = os.id_equipamento
ORDER BY os.id_ordem;

-- ============================================================
-- 13. ORDEM + TÉCNICO
-- Relaciona cada ordem ao técnico responsável.
-- ============================================================
SELECT
    os.id_ordem,
    t.nome AS tecnico,
    os.status,
    os.problema
FROM ordens_servico os
LEFT JOIN tecnicos t
    ON os.id_tecnico = t.id_tecnico
ORDER BY os.id_ordem;

-- ============================================================
-- 14. VISÃO COMPLETA DA ORDEM
-- Junta cliente, equipamento e técnico.
-- ============================================================
SELECT
    os.id_ordem,
    c.nome AS cliente,
    e.tipo,
    e.marca,
    e.modelo,
    t.nome AS tecnico,
    os.status,
    os.data_abertura
FROM ordens_servico os
INNER JOIN equipamentos e
    ON os.id_equipamento = e.id_equipamento
INNER JOIN clientes c
    ON e.id_cliente = c.id_cliente
LEFT JOIN tecnicos t
    ON os.id_tecnico = t.id_tecnico
ORDER BY os.data_abertura DESC;

-- ============================================================
-- 15. COUNT
-- Conta o número total de ordens.
-- COUNT(*) = quantidade de linhas encontradas.
-- ============================================================
SELECT COUNT(*) AS total_ordens
FROM ordens_servico;

-- ============================================================
-- 16. GROUP BY + COUNT
-- Conta quantas ordens existem em cada status.
-- GROUP BY = transforma linhas em grupos.
-- ============================================================
SELECT
    status,
    COUNT(*) AS quantidade
FROM ordens_servico
GROUP BY status
ORDER BY quantidade DESC;

-- ============================================================
-- 17. COUNT POR TÉCNICO
-- Mostra quantas ordens cada técnico possui.
-- ============================================================
SELECT
    t.nome AS tecnico,
    COUNT(os.id_ordem) AS quantidade_ordens
FROM tecnicos t
LEFT JOIN ordens_servico os
    ON t.id_tecnico = os.id_tecnico
GROUP BY t.id_tecnico, t.nome
ORDER BY quantidade_ordens DESC;

-- ============================================================
-- 18. HAVING
-- HAVING filtra grupos depois do GROUP BY.
-- Aqui mostramos técnicos com pelo menos 3 ordens.
-- WHERE filtra linhas; HAVING filtra grupos.
-- ============================================================
SELECT
    t.nome AS tecnico,
    COUNT(os.id_ordem) AS quantidade_ordens
FROM tecnicos t
INNER JOIN ordens_servico os
    ON t.id_tecnico = os.id_tecnico
GROUP BY t.id_tecnico, t.nome
HAVING COUNT(os.id_ordem) >= 3
ORDER BY quantidade_ordens DESC;

-- ============================================================
-- 19. FATURAMENTO POR SERVIÇO
-- SUM = soma valores.
-- Multiplicamos quantidade pelo valor unitário para obter o total.
-- ============================================================
SELECT
    s.nome AS servico,
    SUM(oss.quantidade * oss.valor_unitario) AS faturamento
FROM servicos s
INNER JOIN ordem_servico_servicos oss
    ON s.id_servico = oss.id_servico
GROUP BY s.id_servico, s.nome
ORDER BY faturamento DESC;

-- ============================================================
-- 20. AVG
-- Calcula o preço médio dos serviços cadastrados.
-- ============================================================
SELECT
    AVG(preco) AS preco_medio_servicos
FROM servicos;

-- ============================================================
-- 21. MAX + MIN
-- Mostra o maior e o menor preço de serviço.
-- ============================================================
SELECT
    MAX(preco) AS maior_preco,
    MIN(preco) AS menor_preco
FROM servicos;

-- ============================================================
-- 22. LEFT JOIN + IS NULL
-- Localiza ordens que ainda não possuem nenhum pagamento.
-- LEFT JOIN mantém todas as ordens, mesmo sem pagamento.
-- Quando não existe correspondência, os campos de pagamentos ficam NULL.
-- ============================================================
SELECT
    os.id_ordem,
    c.nome AS cliente,
    os.status
FROM ordens_servico os
INNER JOIN equipamentos e
    ON os.id_equipamento = e.id_equipamento
INNER JOIN clientes c
    ON e.id_cliente = c.id_cliente
LEFT JOIN pagamentos p
    ON os.id_ordem = p.id_ordem
WHERE p.id_pagamento IS NULL
ORDER BY os.id_ordem;

-- ============================================================
-- 23. CASE
-- Cria uma classificação legível para o status da ordem.
-- CASE funciona como uma estrutura condicional.
-- ============================================================
SELECT
    id_ordem,
    status,
    CASE
        WHEN status = 'CONCLUIDA' THEN 'Serviço finalizado'
        WHEN status = 'CANCELADA' THEN 'Serviço cancelado'
        WHEN status = 'ABERTA' THEN 'Aguardando atendimento'
        WHEN status = 'AGUARDANDO_PECA' THEN 'Aguardando peça'
        ELSE 'Serviço em andamento'
    END AS situacao
FROM ordens_servico
ORDER BY id_ordem;

-- ============================================================
-- 24. VALOR DE SERVIÇOS POR ORDEM
-- Soma os serviços de cada ordem.
-- ============================================================
SELECT
    os.id_ordem,
    SUM(oss.quantidade * oss.valor_unitario) AS valor_servicos
FROM ordens_servico os
INNER JOIN ordem_servico_servicos oss
    ON os.id_ordem = oss.id_ordem
GROUP BY os.id_ordem
ORDER BY valor_servicos DESC;

-- ============================================================
-- 25. VALOR TOTAL POR ORDEM - FORMA SEGURA
-- IMPORTANTE:
-- Não devemos juntar diretamente duas tabelas 1:N (serviços e peças)
-- e depois somar tudo, pois isso pode multiplicar as linhas.
--
-- Primeiro calculamos os serviços por ordem.
-- Depois calculamos as peças por ordem.
-- Finalmente juntamos os dois resultados.
--
-- COALESCE transforma NULL em 0 para ordens que não possuem serviços
-- ou peças.
-- ============================================================
WITH totais_servicos AS (
    SELECT
        id_ordem,
        SUM(quantidade * valor_unitario) AS total_servicos
    FROM ordem_servico_servicos
    GROUP BY id_ordem
),

-- Calcula separadamente o total de peças de cada ordem.
totais_pecas AS (
    SELECT
        id_ordem,
        SUM(quantidade * valor_unitario) AS total_pecas
    FROM ordem_servico_pecas
    GROUP BY id_ordem
)

SELECT
    os.id_ordem,
    COALESCE(ts.total_servicos, 0) AS total_servicos,
    COALESCE(tp.total_pecas, 0) AS total_pecas,
    COALESCE(ts.total_servicos, 0) + COALESCE(tp.total_pecas, 0) AS valor_total
FROM ordens_servico os
LEFT JOIN totais_servicos ts
    ON os.id_ordem = ts.id_ordem
LEFT JOIN totais_pecas tp
    ON os.id_ordem = tp.id_ordem
ORDER BY valor_total DESC;

-- ============================================================
-- 26. TOTAL PAGO POR ORDEM
-- Mostra quanto já foi pago em cada ordem.
-- ============================================================
SELECT
    os.id_ordem,
    COALESCE(SUM(p.valor), 0) AS total_pago
FROM ordens_servico os
LEFT JOIN pagamentos p
    ON os.id_ordem = p.id_ordem
GROUP BY os.id_ordem
ORDER BY total_pago DESC;

-- ============================================================
-- 27. ORDENS CONCLUÍDAS COM CLIENTE E VALOR TOTAL
-- Exemplo de consulta mais próxima de um relatório real.
-- ============================================================
WITH totais_servicos AS (
    SELECT
        id_ordem,
        SUM(quantidade * valor_unitario) AS total_servicos
    FROM ordem_servico_servicos
    GROUP BY id_ordem
),
totais_pecas AS (
    SELECT
        id_ordem,
        SUM(quantidade * valor_unitario) AS total_pecas
    FROM ordem_servico_pecas
    GROUP BY id_ordem
)
SELECT
    os.id_ordem,
    c.nome AS cliente,
    os.status,
    COALESCE(ts.total_servicos, 0) + COALESCE(tp.total_pecas, 0) AS valor_total
FROM ordens_servico os
INNER JOIN equipamentos e
    ON os.id_equipamento = e.id_equipamento
INNER JOIN clientes c
    ON e.id_cliente = c.id_cliente
LEFT JOIN totais_servicos ts
    ON os.id_ordem = ts.id_ordem
LEFT JOIN totais_pecas tp
    ON os.id_ordem = tp.id_ordem
WHERE os.status = 'CONCLUIDA'
ORDER BY valor_total DESC;
