
create database vendas;

GO
use vendas;
GO

create table tblclientes ( 
Id int identity(1,1) primary key,
Nome varchar(100) not null,
Email varchar(100),
Cidade varchar(100)
);

GO
-- Inserindo dados de exemplo
insert into tblclientes (Nome, Email, Cidade) values ('Pedro da Silva','pedro@email.com','São Paulo');
insert into tblclientes (Nome, Email, Cidade) values ('Maria Pereira','maria@email.com','Rio de Janeiro');
insert into tblclientes (Nome, Email, Cidade) values ('Leonora Alvez','leonora@email.com','Belo Horizonte');
insert into tblclientes (Nome, Email, Cidade) values ('Virtual Tecnologia S/A','contato@virtual.com','São Paulo');
insert into tblclientes (Nome, Email, Cidade) values ('J&M Associados Ltda.','contato@jmeassociados.com','Curitiba');
insert into tblclientes (Nome, Email, Cidade) values ('Alvorada Empreendimentos S/A','contato@alvorada.com','Porto Alegre');

select * from tblclientes;

