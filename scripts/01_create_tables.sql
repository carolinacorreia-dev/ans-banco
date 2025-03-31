-- Criar o banco de dados se não existir
CREATE DATABASE IF NOT EXISTS ans_database CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE ans_database;

-- Tabela de operadoras
CREATE TABLE IF NOT EXISTS operadoras (
    registro_ans VARCHAR(20) PRIMARY KEY,
    cnpj VARCHAR(20),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(2),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(100),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    regiao_de_comercializacao VARCHAR(100),
    data_registro_ans DATE,
    INDEX idx_razao_social (razao_social),
    INDEX idx_uf (uf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de demonstrações contábeis
CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    reg_ans VARCHAR(20),
    cd_conta_contabil VARCHAR(50),
    descricao VARCHAR(255),
    vl_saldo_inicial DECIMAL(15,2),
    vl_saldo_final DECIMAL(15,2),
    FOREIGN KEY (reg_ans) REFERENCES operadoras(registro_ans),
    INDEX idx_data (data),
    INDEX idx_descricao (descricao(100)),
    INDEX idx_reg_ans (reg_ans)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;