CREATE DATABASE OFICINA_DO_JUAN;
USE OFICINA_DO_JUAN;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(14),
    telefone VARCHAR(15),
    endereco VARCHAR(150),
    email VARCHAR(100)
);

CREATE TABLE marcas (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    pais_origem VARCHAR(50),
    ano_fundacao INT,
    site VARCHAR(100),
    descricao VARCHAR(100)
);

CREATE TABLE modelos (
    id_modelo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    ano_lancamento INT,
    categoria VARCHAR(30),
    motorizacao VARCHAR(30),
    combustivel VARCHAR(20)
);

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(14),
    telefone VARCHAR(15),
    cargo VARCHAR(50),
    salario DECIMAL(10,2)
);

CREATE TABLE fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(100),
    cnpj VARCHAR(18),
    telefone VARCHAR(15),
    email VARCHAR(100),
    endereco VARCHAR(150)
);

CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10),
    ano INT,
    cor VARCHAR(30),
    quilometragem INT,
    chassi VARCHAR(30)
);

CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(150),
    valor DECIMAL(10,2),
    duracao INT,
    data_execucao DATE,
    status VARCHAR(20)
);

CREATE TABLE pecas (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    valor DECIMAL(10,2),
    quantidade INT,
    fabricante VARCHAR(100),
    garantia VARCHAR(50)
);

CREATE TABLE ordens_servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    data_abertura DATE,
    data_fechamento DATE,
    status VARCHAR(20),
    valor_total DECIMAL(10,2),
    observacoes VARCHAR(200)
);

CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10,2),
    data_pagamento DATE,
    forma_pagamento VARCHAR(30),
    status VARCHAR(20),
    comprovante VARCHAR(100)
);

ALTER TABLE clientes ADD observacao VARCHAR(100);
ALTER TABLE marcas ADD observacao VARCHAR(100);
ALTER TABLE modelos ADD observacao VARCHAR(100);
ALTER TABLE funcionarios ADD observacao VARCHAR(100);
ALTER TABLE fornecedores ADD observacao VARCHAR(100);
ALTER TABLE veiculos ADD observacao VARCHAR(100);
ALTER TABLE servicos ADD observacao VARCHAR(100);
ALTER TABLE pecas ADD observacao VARCHAR(100);
ALTER TABLE ordens_servico ADD observacao_extra VARCHAR(100);
ALTER TABLE pagamentos ADD observacao VARCHAR(100);

ALTER TABLE clientes DROP COLUMN observacao;
ALTER TABLE marcas DROP COLUMN observacao;
ALTER TABLE modelos DROP COLUMN observacao;
ALTER TABLE funcionarios DROP COLUMN observacao;
ALTER TABLE fornecedores DROP COLUMN observacao;
ALTER TABLE veiculos DROP COLUMN observacao;
ALTER TABLE servicos DROP COLUMN observacao;
ALTER TABLE pecas DROP COLUMN observacao;
ALTER TABLE ordens_servico DROP COLUMN observacao_extra;
ALTER TABLE pagamentos DROP COLUMN observacao;

ALTER TABLE modelos RENAME TO modelos_fab;