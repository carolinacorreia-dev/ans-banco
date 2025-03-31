USE ans_database;

-- Habilitar carga de arquivos locais
SET GLOBAL local_infile = 1;
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Carregar dados das operadoras

LOAD DATA LOCAL INFILE 'C:\Users\User\Desktop\ans-banco\data/operadoras_ativas.csv'
INTO TABLE operadoras
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(registro_ans, cnpj, razao_social, nome_fantasia, modalidade, 
 logradouro, numero, complemento, bairro, cidade, uf, cep, 
 ddd, telefone, fax, endereco_eletronico, representante, 
 cargo_representante, regiao_de_comercializacao, @data_registro_ans)
SET data_registro_ans = STR_TO_DATE(@data_registro_ans, '%d/%m/%Y');

-- 2. Carregar dados contábeis 
-- Arquivo 2024-06-12
LOAD DATA LOCAL INFILE 'C:\Users\User\Desktop\ans-banco\data\demonstracoes_contabeis\2024/2024-06-12.csv'
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SET data = STR_TO_DATE(@data, '%d/%m/%Y');

-- Repetir para os outros arquivos (2024-09-03, 2024-12-10, 2025-03-18)
-- 

-- Restaurar configurações
SET FOREIGN_KEY_CHECKS = 1;

-- Verificar dados carregados
SELECT 
    CONCAT('Operadoras: ', COUNT(*)) AS total_registros 
FROM operadoras
UNION ALL
SELECT 
    CONCAT('Demonstrações: ', COUNT(*)) 
FROM demonstracoes_contabeis;