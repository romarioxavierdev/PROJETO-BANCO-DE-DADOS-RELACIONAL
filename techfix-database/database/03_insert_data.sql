

USE techfix;

INSERT INTO clientes (nome, email, telefone, cidade) VALUES
('João da Silva', 'joao.silva@email.com', '(38) 99999-1001', 'Diamantina'),
('Maria Oliveira', 'maria.oliveira@email.com', '(38) 99999-1002', 'Diamantina'),
('Carlos Mendes', 'carlos.mendes@email.com', '(31) 99999-1003', 'Belo Horizonte'),
('Ana Paula Souza', 'ana.souza@email.com', '(38) 99999-1004', 'Montes Claros'),
('Lucas Ferreira', 'lucas.ferreira@email.com', '(38) 99999-1005', 'Diamantina'),
('Fernanda Alves', 'fernanda.alves@email.com', '(38) 99999-1006', 'Serro'),
('Rafael Costa', 'rafael.costa@email.com', '(38) 99999-1007', 'Diamantina'),
('Juliana Martins', 'juliana.martins@email.com', '(31) 99999-1008', 'Belo Horizonte'),
('Pedro Henrique', 'pedro.henrique@email.com', '(38) 99999-1009', 'Gouveia'),
('Camila Rocha', 'camila.rocha@email.com', '(38) 99999-1010', 'Diamantina');

INSERT INTO tecnicos (nome, especialidade, email, telefone) VALUES
('André Martins', 'Hardware', 'andre@techfix.com', '(38) 98888-2001'),
('Beatriz Souza', 'Software', 'beatriz@techfix.com', '(38) 98888-2002'),
('Diego Ferreira', 'Redes', 'diego@techfix.com', '(38) 98888-2003'),
('Marcos Oliveira', 'Eletrônica', 'marcos@techfix.com', '(38) 98888-2004'),
('Patrícia Lima', 'Hardware e Software', 'patricia@techfix.com', '(38) 98888-2005');

INSERT INTO equipamentos (id_cliente, tipo, marca, modelo, numero_serie) VALUES
(1, 'Notebook', 'Dell', 'Inspiron 15 3000', 'DELL001'),
(2, 'Smartphone', 'Samsung', 'Galaxy S22', 'SAM002'),
(3, 'Notebook', 'Lenovo', 'IdeaPad 3', 'LEN003'),
(4, 'Desktop', 'HP', 'Pavilion', 'HP004'),
(5, 'Smartphone', 'Apple', 'iPhone 13', 'APL005'),
(6, 'Notebook', 'Acer', 'Aspire 5', 'ACE006'),
(7, 'Notebook', 'Dell', 'Vostro 3500', 'DELL007'),
(8, 'Smartphone', 'Motorola', 'Edge 30', 'MOT008'),
(9, 'Desktop', 'ASUS', 'ExpertCenter', 'ASU009'),
(10, 'Notebook', 'Xiaomi', 'RedmiBook 15', 'XIA010'),
(1, 'Desktop', 'Dell', 'OptiPlex 3080', 'DELL011'),
(5, 'Notebook', 'HP', '15-DY', 'HP012');

INSERT INTO servicos (nome, descricao, preco) VALUES
('Formatação', 'Formatação completa e preparação do equipamento', 120.00),
('Instalação de Sistema', 'Instalação e configuração do sistema operacional', 100.00),
('Limpeza Interna', 'Limpeza interna e manutenção física', 80.00),
('Troca de Tela', 'Substituição do display do equipamento', 250.00),
('Configuração de Rede', 'Configuração de rede local e internet', 150.00),
('Remoção de Vírus', 'Diagnóstico e remoção de malware', 90.00),
('Manutenção Preventiva', 'Revisão geral e prevenção de falhas', 180.00),
('Recuperação de Dados', 'Tentativa de recuperação de arquivos', 300.00);


INSERT INTO pecas (nome, codigo, estoque, preco) VALUES
('SSD 480GB', 'SSD480', 15, 280.00),
('SSD 1TB', 'SSD1TB', 10, 450.00),
('Memória RAM 8GB DDR4', 'RAM8DDR4', 20, 160.00),
('Memória RAM 16GB DDR4', 'RAM16DDR4', 12, 280.00),
('Bateria Notebook Dell', 'BATDELL', 6, 350.00),
('Tela Notebook 15.6"', 'TELA156', 8, 520.00),
('Tela iPhone 13', 'TELAIP13', 5, 780.00),
('Teclado Notebook', 'TECNOTE', 10, 180.00),
('Pasta Térmica', 'PASTA01', 30, 35.00),
('Fonte Notebook Universal', 'FONTEUNI', 7, 150.00);


INSERT INTO ordens_servico
(id_equipamento, id_tecnico, problema, diagnostico, status, data_abertura, data_conclusao)
VALUES
(1, 1, 'Notebook não liga', 'Falha na bateria e necessidade de manutenção interna', 'CONCLUIDA', '2025-10-01 09:00:00', '2025-10-03 16:00:00'),
(2, 4, 'Tela apresentando manchas', 'Display danificado', 'CONCLUIDA', '2025-10-02 10:30:00', '2025-10-05 14:00:00'),
(3, 2, 'Computador muito lento', 'Sistema com excesso de arquivos e programas', 'EM_MANUTENCAO', '2025-10-04 08:30:00', NULL),
(4, 3, 'Não conecta à internet', 'Configuração incorreta da rede', 'CONCLUIDA', '2025-10-05 11:00:00', '2025-10-06 17:00:00'),
(5, 4, 'Tela quebrada', 'Display danificado por impacto', 'AGUARDANDO_PECA', '2025-10-06 13:00:00', NULL),
(6, 1, 'Superaquecimento', 'Acúmulo de poeira e pasta térmica ressecada', 'CONCLUIDA', '2025-10-07 09:30:00', '2025-10-08 15:00:00'),
(7, 5, 'Travamentos frequentes', 'Memória insuficiente para o uso atual', 'EM_MANUTENCAO', '2025-10-08 10:00:00', NULL),
(8, 2, 'Aplicativos fechando sozinhos', 'Possível conflito de software', 'EM_ANALISE', '2025-10-09 14:00:00', NULL),
(9, 3, 'Computador sem acesso à rede', 'Configuração de IP incorreta', 'CONCLUIDA', '2025-10-10 08:00:00', '2025-10-10 16:30:00'),
(10, 5, 'Sistema infectado por vírus', 'Malware identificado', 'CONCLUIDA', '2025-10-11 09:00:00', '2025-10-12 13:00:00'),
(11, 1, 'Computador fazendo muito barulho', 'Ventoinha com excesso de poeira', 'ABERTA', '2025-10-12 10:00:00', NULL),
(12, 2, 'Notebook não inicia o sistema', 'Falha no armazenamento', 'AGUARDANDO_PECA', '2025-10-13 11:00:00', NULL),
(1, 1, 'Manutenção preventiva', 'Necessária limpeza e revisão geral', 'CONCLUIDA', '2025-10-14 09:00:00', '2025-10-15 12:00:00'),
(5, 4, 'Tela com linhas e falhas', 'Necessidade de substituição do display', 'EM_MANUTENCAO', '2025-10-15 13:30:00', NULL),
(7, 5, 'Arquivos importantes apagados', 'Tentativa de recuperação de dados', 'CONCLUIDA', '2025-10-16 08:30:00', '2025-10-18 17:00:00');


INSERT INTO ordem_servico_servicos (id_ordem, id_servico, quantidade, valor_unitario) VALUES
(1, 3, 1, 80.00),
(2, 4, 1, 250.00),
(3, 1, 1, 120.00),
(3, 2, 1, 100.00),
(4, 5, 1, 150.00),
(5, 4, 1, 250.00),
(6, 3, 1, 80.00),
(7, 7, 1, 180.00),
(8, 6, 1, 90.00),
(9, 5, 1, 150.00),
(10, 6, 1, 90.00),
(11, 3, 1, 80.00),
(12, 1, 1, 120.00),
(13, 3, 1, 80.00),
(13, 7, 1, 180.00),
(14, 4, 1, 250.00),
(15, 8, 1, 300.00);


INSERT INTO ordem_servico_pecas (id_ordem, id_peca, quantidade, valor_unitario) VALUES
(1, 5, 1, 350.00),
(1, 9, 1, 35.00),
(2, 7, 1, 780.00),
(3, 1, 1, 280.00),
(3, 3, 1, 160.00),
(5, 7, 1, 780.00),
(6, 9, 1, 35.00),
(7, 4, 1, 280.00),
(10, 9, 1, 35.00),
(12, 2, 1, 450.00),
(14, 6, 1, 520.00),
(15, 1, 1, 280.00);


INSERT INTO pagamentos (id_ordem, valor, forma_pagamento, data_pagamento) VALUES
(1, 465.00, 'PIX', '2025-10-03 16:30:00'),
(2, 1030.00, 'CARTAO_CREDITO', '2025-10-05 14:30:00'),
(4, 150.00, 'DINHEIRO', '2025-10-06 17:30:00'),
(5, 300.00, 'PIX', '2025-10-06 14:00:00'),
(6, 115.00, 'CARTAO_DEBITO', '2025-10-08 15:30:00'),
(9, 150.00, 'PIX', '2025-10-10 17:00:00'),
(10, 125.00, 'DINHEIRO', '2025-10-12 13:30:00'),
(13, 260.00, 'CARTAO_CREDITO', '2025-10-15 12:30:00'),
(15, 580.00, 'PIX', '2025-10-18 17:30:00');
