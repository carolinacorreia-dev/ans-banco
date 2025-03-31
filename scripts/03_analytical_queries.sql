USE ans_database;

-- 1. Verificar datas disponíveis
SELECT 
    MIN(data) AS data_mais_antiga,
    MAX(data) AS data_mais_recente,
    COUNT(DISTINCT DATE_FORMAT(data, '%Y-%m')) AS meses_com_dados
FROM demonstracoes_contabeis;

-- 2. Top 10 operadoras com maiores despesas no último trimestre
WITH datas_referencia AS (
    SELECT 
        MAX(data) AS data_fim,
        DATE_SUB(MAX(data), INTERVAL 3 MONTH) AS data_inicio
    FROM demonstracoes_contabeis
)
SELECT 
    o.razao_social,
    o.nome_fantasia,
    o.uf,
    SUM(d.vl_saldo_final) AS total_despesas,
    CONCAT(dr.data_inicio, ' a ', dr.data_fim) AS periodo
FROM 
    demonstracoes_contabeis d
JOIN 
    operadoras o ON d.reg_ans = o.registro_ans
CROSS JOIN
    datas_referencia dr
WHERE 
    d.descricao LIKE '%EVENTOS/%SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
    AND d.data BETWEEN dr.data_inicio AND dr.data_fim
GROUP BY 
    o.razao_social, o.nome_fantasia, o.uf, dr.data_inicio, dr.data_fim
ORDER BY 
    total_despesas DESC
LIMIT 10;

-- 3. Top 10 operadoras com maiores despesas no último ano completo
WITH ano_mais_recente AS (
    SELECT MAX(YEAR(data)) AS ano FROM demonstracoes_contabeis
)
SELECT 
    o.razao_social,
    o.nome_fantasia,
    o.uf,
    SUM(d.vl_saldo_final) AS total_despesas,
    amr.ano
FROM 
    demonstracoes_contabeis d
JOIN 
    operadoras o ON d.reg_ans = o.registro_ans
CROSS JOIN
    ano_mais_recente amr
WHERE 
    d.descricao LIKE '%EVENTOS/%SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
    AND YEAR(d.data) = amr.ano
GROUP BY 
    o.razao_social, o.nome_fantasia, o.uf, amr.ano
ORDER BY 
    total_despesas DESC
LIMIT 10;