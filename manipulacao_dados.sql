-- ============================================
-- SCRIPT DE MANIPULAÇÃO DE DADOS
-- Clínica Médica - INSERT, UPDATE, DELETE
-- ============================================

USE clinica_medica;
GO

-- ============================================
-- INSERÇÃO DE DADOS (INSERT)
-- ============================================

-- Inserindo Pacientes
INSERT INTO paciente (cpf, nome, telefone, numero_plano, tipo_plano) VALUES
('123.456.789-00', 'Maria Silva', '(11) 98765-4321', 1001, 'Premium'),
('234.567.890-11', 'João Santos', '(11) 97654-3210', 1002, 'Básico'),
('345.678.901-22', 'Ana Costa', '(11) 96543-2109', 1003, 'Premium'),
('456.789.012-33', 'Pedro Oliveira', '(11) 95432-1098', 1004, 'Básico'),
('567.890.123-44', 'Carla Souza', '(11) 94321-0987', 1005, 'Premium');
GO

-- Inserindo Médicos
INSERT INTO medico (crm, nome, especialidade) VALUES
(12345, 'Dr. Carlos Mendes', 'Cardiologia'),
(23456, 'Dra. Fernanda Lima', 'Pediatria'),
(34567, 'Dr. Roberto Alves', 'Ortopedia'),
(45678, 'Dra. Juliana Santos', 'Dermatologia'),
(56789, 'Dr. Marcos Pereira', 'Neurologia');
GO

-- Inserindo Exames
INSERT INTO exame (codigo, descricao, valor) VALUES
(1, 'Hemograma Completo', 150.00),
(2, 'Raio-X Tórax', 200.00),
(3, 'Eletrocardiograma', 180.00),
(4, 'Ultrassom Abdominal', 350.00),
(5, 'Teste de Glicemia', 80.00),
(6, 'Colesterol Total', 120.00),
(7, 'Ressonância Magnética', 800.00);
GO

-- Inserindo Consultas
INSERT INTO consulta (data_consulta, horario_consulta, fk_paciente_cpf, fk_medico_crm) VALUES
('2024-01-15', '09:00:00', '123.456.789-00', 12345),
('2024-01-15', '10:30:00', '234.567.890-11', 23456),
('2024-01-16', '14:00:00', '345.678.901-22', 12345),
('2024-01-16', '15:30:00', '456.789.012-33', 34567),
('2024-01-17', '08:00:00', '567.890.123-44', 45678),
('2024-01-17', '11:00:00', '123.456.789-00', 56789);
GO

-- Inserindo Pedidos de Exame
INSERT INTO pedido_exame (resultado, data_pedido, fk_consulta_numero_consulta, fk_exame_codigo) VALUES
('Normal', '2024-01-15', 1000, 1),
('Normal', '2024-01-15', 1000, 3),
('Alterado', '2024-01-15', 1001, 2),
('Normal', '2024-01-16', 1002, 1),
('Normal', '2024-01-16', 1002, 5),
('Alterado', '2024-01-16', 1003, 4),
('Normal', '2024-01-17', 1004, 6),
('Normal', '2024-01-17', 1005, 7);
GO

-- ============================================
-- ATUALIZAÇÃO DE DADOS (UPDATE)
-- ============================================

-- Atualizar telefone de um paciente
UPDATE paciente 
SET telefone = '(11) 98888-8888'
WHERE cpf = '123.456.789-00';
GO

-- Atualizar tipo de plano de um paciente
UPDATE paciente 
SET tipo_plano = 'Premium', numero_plano = 2001
WHERE cpf = '234.567.890-11';
GO

-- Atualizar especialidade de um médico
UPDATE medico 
SET especialidade = 'Cardiologia Pediátrica'
WHERE crm = 23456;
GO

-- Atualizar valor de um exame
UPDATE exame 
SET valor = 250.00
WHERE codigo = 2;
GO

-- Atualizar resultado de um pedido de exame
UPDATE pedido_exame 
SET resultado = 'Normal'
WHERE numero_pedido = 2002;
GO

-- Atualizar horário de uma consulta
UPDATE consulta 
SET horario_consulta = '10:00:00'
WHERE numero_consulta = 1000;
GO

-- ============================================
-- EXCLUSÃO DE DADOS (DELETE)
-- ============================================

-- Excluir um pedido de exame específico
DELETE FROM pedido_exame 
WHERE numero_pedido = 2007;
GO

-- Excluir todas as consultas de um paciente específico
-- (Como há CASCADE, os pedidos de exame também serão excluídos)
DELETE FROM consulta 
WHERE fk_paciente_cpf = '567.890.123-44';
GO

-- Excluir um exame que não está sendo usado
-- (Só funciona se não houver pedidos de exame referenciando)
DELETE FROM exame 
WHERE codigo = 7 AND NOT EXISTS (
    SELECT 1 FROM pedido_exame WHERE fk_exame_codigo = 7
);
GO

-- Excluir um paciente e todas suas consultas (CASCADE)
DELETE FROM paciente 
WHERE cpf = '456.789.012-33';
GO

-- ============================================
-- CONSULTAS DE VERIFICAÇÃO
-- ============================================

-- Verificar todos os pacientes
SELECT * FROM paciente;
GO

-- Verificar todos os médicos
SELECT * FROM medico;
GO

-- Verificar todas as consultas com nomes
SELECT 
    c.numero_consulta,
    c.data_consulta,
    c.horario_consulta,
    p.nome AS paciente,
    m.nome AS medico,
    m.especialidade
FROM consulta c
INNER JOIN paciente p ON c.fk_paciente_cpf = p.cpf
INNER JOIN medico m ON c.fk_medico_crm = m.crm;
GO

-- Verificar pedidos de exame com detalhes
SELECT 
    pe.numero_pedido,
    pe.resultado,
    pe.data_pedido,
    e.descricao AS exame,
    e.valor,
    c.numero_consulta,
    p.nome AS paciente
FROM pedido_exame pe
INNER JOIN exame e ON pe.fk_exame_codigo = e.codigo
INNER JOIN consulta c ON pe.fk_consulta_numero_consulta = c.numero_consulta
INNER JOIN paciente p ON c.fk_paciente_cpf = p.cpf;
GO

