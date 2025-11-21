
-- Database creation
drop database clinica_medica;
create database clinica_medica;
use clinica_medica;

-- Tables
CREATE TABLE paciente (
    cpf varchar(14) PRIMARY KEY,
    nome varchar(40),
    telefone varchar(14),
    numero_plano int,
    tipo_plano varchar(20)
);

CREATE TABLE medico (
    crm int PRIMARY KEY,
    nome varchar(40),
    especialidade varchar(20)
);

CREATE TABLE exame (
    codigo int PRIMARY KEY,
    descricao varchar(20),
    valor money
);

CREATE TABLE consulta (
    numero_consulta int PRIMARY KEY identity (1000,1),
    data_consulta date,
    horario_consulta time,
    fk_paciente_cpf varchar(14),
    fk_medico_crm int
);

CREATE TABLE pedido_exame (
    numero_pedido int PRIMARY KEY identity (2000,1),
    resultado varchar(10),
    data_pedido date,
    fk_consulta_numero_consulta int,
    fk_exame_codigo int
);

-- Foreign keys
ALTER TABLE consulta ADD CONSTRAINT FK_consulta_1 FOREIGN KEY (fk_paciente_cpf) REFERENCES paciente (cpf) ON DELETE CASCADE;
ALTER TABLE consulta ADD CONSTRAINT FK_consulta_2 FOREIGN KEY (fk_medico_crm) REFERENCES medico (crm) ON DELETE CASCADE;
ALTER TABLE pedido_exame ADD CONSTRAINT FK_pedido_exame_1 FOREIGN KEY (fk_consulta_numero_consulta) REFERENCES consulta (numero_consulta) ON DELETE CASCADE;
ALTER TABLE pedido_exame ADD CONSTRAINT FK_pedido_exame_2 FOREIGN KEY (fk_exame_codigo) REFERENCES exame (codigo) ON DELETE CASCADE;
