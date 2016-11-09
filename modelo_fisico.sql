set search_path to public;


create table unidade_saude(
	tipo varchar(30), 
	edificacao varchar(30),
	reg_juridico varchar(20), 
	bandeira varchar(20), 
	porte varchar(20), 
	qualidade varchar(30), 
	ehGeral boolean, 
	end_cidade varchar(20), 
	end_rua varchar(30), 
	end_bairro varchar(30), 
	end_num int

);

-- cria a tabela batalhas
create table batalhas(
	nome varchar(20),
	data date
);

-- cria a tabela resultados
create table resultados(
	navio varchar(20),
	batalha varchar(20),
	desfecho varchar(10)
);

-- cria a tabela navios
create table navios(
	nome varchar(20),
	classe varchar(20),
	lancamento int
);


ALTER TABLE classes ADD PRIMARY KEY (classe);
ALTER TABLE classes ADD CHECK (tipo = 'ne' OR tipo = 'nc');
ALTER TABLE classes ADD CHECK (numarmas >= 0 AND calibre >= 0 AND deslocamento >= 0);

ALTER TABLE navios ADD PRIMARY KEY (nome);
ALTER TABLE navios ALTER lancamento SET NOT NULL;

ALTER TABLE batalhas ADD PRIMARY KEY (nome);
ALTER TABLE batalhas ALTER data SET NOT NULL;

ALTER TABLE resultados ADD PRIMARY KEY (navio,batalha);
ALTER TABLE resultados ADD CHECK (desfecho = 'afundado' OR desfecho = 'danificado' OR desfecho = 'ok');

-- popula a tabela classes
insert into classes (classe, tipo, pais, numarmas, calibre, deslocamento) values 
	('Bismark', 'ne', 'Germany', 8, 15, 42000);
insert into classes (classe, tipo, pais, numarmas, calibre, deslocamento) values
	('Iowa', 'ne', 'USA', 9, 16, 46000);
insert into classes (classe, tipo, pais, numarmas, calibre, deslocamento) values
	('Kongo', 'nc', 'Japan', 8, 14, 32000);
insert into classes (classe, tipo, pais, numarmas, calibre, deslocamento) values
	('North Carolina', 'ne', 'USA', 9, 16, 37000);
insert into classes (classe, tipo, pais, numarmas, calibre, deslocamento) values
	('Renown', 'nc', 'Gt. Britain', 6, 15, 32000);
insert into classes (classe, tipo, pais, numarmas, calibre, deslocamento) values
	('Revenge', 'ne', 'Gt. Britain', 8, 15, 32000);
insert into classes (classe, tipo, pais, numarmas, calibre, deslocamento) values
	('Tennessee', 'ne', 'USA', 12, 14, 32000);
insert into classes (classe, tipo, pais, numarmas, calibre, deslocamento) values
	('Yamato', 'ne', 'Japan', 9, 18, 65000);

