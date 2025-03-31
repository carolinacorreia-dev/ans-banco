# Projeto de Análise de Dados da ANS

Este projeto realiza a análise de dados abertos da Agência Nacional de Saúde Suplementar (ANS), focando nas demonstrações contábeis e informações cadastrais das operadoras de planos de saúde.

## 📌 Visão Geral

O sistema permite:
- Carregar dados cadastrais das operadoras
- Importar demonstrações contábeis trimestrais
- Identificar as operadoras com maiores despesas em eventos/sinistros de saúde
- Analisar tendências trimestrais e anuais

## 📋 Pré-requisitos

- MySQL 8.0+ instalado localmente
- Python 3.8+ (para scripts auxiliares)
- VS Code (recomendado) com extensões:
  - SQLTools
  - MySQL Syntax

## 🚀 Configuração Inicial

1. Clone o repositório:
```bash
git clone https://github.com/carolinacorreia-dev/ans-banco.git
cd ans-banco
```

2. Configure o MySQL para permitir carga de arquivos locais:
   - Edite `my.cnf` ou `my.ini`:
     ```
     [mysqld]
     local_infile=1
     secure-file-priv=""
     ```
   - Reinicie o serviço MySQL

3. Crie o banco de dados (opcional):
```sql
CREATE DATABASE ans_analysis;
```

## 🗂 Estrutura de Arquivos

```
projeto-ans/
├── data/                   # Dados brutos 
│   └── demonstracoes_contabeis/
│       ├── 1T2024.csv
│       ├── 2T2024.csv
│       ├── 3T2024.csv
│       └── 4T2024.csv
├── scripts/
│   ├── 01_create_tables.sql
│   ├── 02_load_data.sql
│   └── 03_analytical_queries.sql
├── .gitignore
└── README.md
```

## ⚙️ Como Executar

1. Execute os scripts SQL em ordem:

```bash
mysql -u root -p --local-infile=1 < scripts/01_create_tables.sql
mysql -u root -p --local-infile=1 < scripts/02_load_data.sql
mysql -u root -p ans_analysis < scripts/03_analytical_queries.sql
```

2. Para executar no VS Code:
   - Conecte-se ao MySQL usando SQLTools
   - Execute cada script na ordem numérica

## 🔍 Principais Análises

O projeto inclui consultas para:
- Top 10 operadoras com maiores despesas por trimestre
- Evolução trimestral das despesas médicas
- Comparativo anual de desempenho

## 📊 Exemplo de Saída

```
+----------------+-------------------------+------+------------------+
| trimestre      | razao_social           | uf   | total_despesas   |
+----------------+-------------------------+------+------------------+
| 1T2024         | OPERADORA X SAUDE      | SP   | 1250000000.00    |
| 1T2024         | SAUDE Y PLANOS         | RJ   | 1120000000.00    |
| 2T2024         | OPERADORA X SAUDE      | SP   | 1350000000.00    |
+----------------+-------------------------+------+------------------+
```

