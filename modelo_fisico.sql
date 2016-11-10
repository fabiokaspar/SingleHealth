set search_path to public;

create domain login_type as varchar(30);

-- 11
create table usuario (
	email varchar(30),
	cargo varchar(20),
	senhaSH varchar(30) unique,
	end_cidade varchar(20), 
	end_rua varchar(30), 
	end_bairro varchar(30), 
	end_num int,
	dt_nasc date,
	rg int unique,
	nome_completo varchar(80),
	filiacao_pai  varchar(80),
	filiacao_mae  varchar(80),
	loginsh login_type primary key
);


-- 14
create table diretor (
	loginsh login_type primary key,
	foreign key(loginsh) references usuario(loginsh) on delete cascade on update cascade
);

-- 1
create table unidade_saude (
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
	end_num int,
	cod int unique,
	loginsh_dir login_type unique,
	primary key(cod, loginsh_dir),
	foreign key(loginsh_dir) references diretor(loginsh) on delete cascade on update cascade	
);

-- 2
create table sala_hospitalar (
	andar int,
	sala int,
	bloco char(1),
	cod_us int,
	primary key(sala, bloco, cod_us),
	foreign key(cod_us) references unidade_saude(cod) on delete cascade on update cascade	
);

-- 3
create table sala_de_consulta (
	sala int,
	bloco char(1),
	cod_us int,
	primary key(sala, bloco, cod_us),
	foreign key(sala, bloco, cod_us) references sala_hospitalar (sala, bloco, cod_us) on delete cascade on update cascade	
);


-- 4
create table farmacia (
	nome varchar(20),
	capacidade int,
	qtdTotalRem int, -- *
	valTotalRem decimal(10,2), --*
	sala int,
	bloco varchar(2), 
	cod_us int,
	primary key(sala, bloco, cod_us),
	foreign key(sala, bloco, cod_us) references sala_hospitalar(sala, bloco, cod_us) on delete cascade on update cascade	
);


-- 5
create table enfermaria (
	total_remed_disp int,
	capacidade_rem int,
	sala int,
	bloco varchar(2),
	cod_us int,
	primary key(sala, bloco, cod_us),
	foreign key(sala, bloco, cod_us) references sala_hospitalar(sala, bloco, cod_us) on delete cascade on update cascade	
);



-- 6
create table sala_observacao (
	alimentacao_geral varchar(60),
	num_leitos_uso int,
	num_leitos int,
	grau_risco varchar(20),
	tempo_visita interval,
	sala int,
	bloco varchar(2),
	cod_us int,
	primary key(sala, bloco, cod_us),
	foreign key(sala, bloco, cod_us) references sala_hospitalar(sala, bloco, cod_us) on delete cascade on update cascade	
);


-- 7
create table tipo_farmaco (
	fabricante varchar(20),
	tarja varchar(20),
	descricao varchar(300),
	contraindicacoes varchar(300),
	nome varchar(40) primary key
);


-- 8
create table farmacia_farmaco (
	preco_unit numeric(6,2),
	num_unidades int,
	data_valid date,
	data_fabr date,
	sala int,
	bloco varchar(2),
	cod_us int,
	nome_farmaco varchar(40),
	primary key(sala, bloco, cod_us, nome_farmaco),
	foreign key(sala, bloco, cod_us) references farmacia(sala, bloco, cod_us) on delete cascade on update cascade,
	foreign key(nome_farmaco) references tipo_farmaco(nome) on delete cascade on update cascade	
);


-- 9
create table fornecedor (
	cnpj_fornc int unique,
	sala int,
	bloco varchar(2),
	cod_us int,
	primary key(sala, bloco, cod_us),
	foreign key(sala, bloco, cod_us) references farmacia(sala, bloco, cod_us) on delete cascade on update cascade	
);


-- 10
create table enfermaria_farmaco (
	fracao_restante float, -- *
	dt_val date,	
	sala int,
	bloco varchar(2),
	cod_us int,
	nome_farmaco varchar(40),
	primary key(sala, bloco, cod_us, nome_farmaco),
	foreign key(sala, bloco, cod_us) references enfermaria(sala, bloco, cod_us) on delete cascade on update cascade,
	foreign key(nome_farmaco) references tipo_farmaco(nome) on delete cascade on update cascade
);

-- 12
create table Especialidade (
	nome varchar(30),
	codCBO int primary key
);


-- 13
create table Paciente (
	num_carteira int unique, --*
	loginsh varchar(30) primary key,
	foreign key(loginsh) references usuario(loginsh) on delete cascade on update cascade
);



-- 15
create table Funcionario (
	cpf int unique,
	loginsh varchar(30) primary key,
	foreign key(loginsh) references usuario(loginsh) on delete cascade on update cascade
);


-- 16
create table Farmaceutico (
	crf int unique,
	loginsh varchar(30) primary key,
	foreign key(loginsh) references Funcionario(loginsh) on delete cascade on update cascade
);


-- 17
create table Medico (
	crm int unique,
	loginsh varchar(30) primary key,
	foreign key(loginsh) references Funcionario(loginsh) on delete cascade on update cascade
);


-- 18
create table Enfermeiro (
	coren int unique,
	loginsh varchar(30) primary key,
	foreign key(loginsh) references Funcionario(loginsh) on delete cascade on update cascade
);


-- 19
create table Func_trabalha_em (
	num_hrs_por_dia int,
	num_dias_por_semana int,
	loginsh varchar(30),
	sala int,
	bloco varchar(2),
	cod_us int,
	foreign key(loginsh) references Funcionario(loginsh) on delete cascade on update cascade,
	foreign key(bloco, sala, cod_us) references sala_hospitalar(bloco, sala, cod_us) on delete cascade on update cascade
);


-- 20
create table Medico_espec (
	codCBO int,
	loginsh_med varchar(30),
	primary key(codCBO, loginsh_med),
		
	foreign key(loginsh_med) references Medico(loginsh) on delete cascade on update cascade,
	foreign key(codCBO) references Especialidade(codCBO) on delete cascade on update cascade
);


-- 21
create table Compra (
	data date,
	cod_us_farmacia int,
	formaPgto varchar(20),
	valorCompra decimal(6,2), --*

	cpf int,
	num int,
	loginsh_pac varchar(30),
	primary key(cpf, num, loginsh_pac),
		
	foreign key(loginsh_pac) references Paciente(loginsh) on delete cascade on update cascade
);


-- 22
create table Paciente_vinc_us (
	data_vinculo date,
	ehConveniado boolean,  -- um id adicional ?
	mensalidade decimal(6,2), --*
	
	cod_us int,
	loginsh_pac varchar(30),
	primary key(cod_us, loginsh_pac),
		
	foreign key(loginsh_pac) references Paciente(loginsh) on delete cascade on update cascade,
	foreign key(cod_us) references unidade_saude(cod) on delete cascade on update cascade
);


-- 23
create table Consulta (
	dt_hora date,
	relato_doenca varchar(50),
	dt_retorno date,
	
	id int,
	loginsh_pac varchar(30),
	loginsh_med varchar(30),
	primary key(id, loginsh_pac, loginsh_med),
	
	foreign key(loginsh_pac) references Paciente(loginsh) on delete cascade on update cascade,
	foreign key(loginsh_med) references Medico(loginsh) on delete cascade on update cascade
);


-- 24
create table Receita (
	num int,
	id_consulta int,
	loginsh_pac varchar(30),
	loginsh_med varchar(30),
	primary key(num, id_consulta, loginsh_pac, loginsh_med),
	foreign key(id_consulta, loginsh_pac, loginsh_med) references Consulta(id, loginsh_pac, loginsh_med) on delete cascade on update cascade
);


-- 25
create table Receita_tipo_farmaco (
	dosagem varchar(30),
	periodo interval, --*
	quem_ministra varchar(20),
	
	num_receita int,
	id_consulta int,
	loginsh_pac varchar(30),
	loginsh_med varchar(30),
	farmaco varchar(40),
	primary key(id_consulta, num_receita, loginsh_pac, loginsh_med, farmaco),

	foreign key(num_receita, id_consulta, loginsh_pac, loginsh_med) references 
		Receita(num, id_consulta, loginsh_pac, loginsh_med) on delete cascade on update cascade,
	
	foreign key(farmaco) references tipo_farmaco(nome) on delete cascade on update cascade
	
);


-- 26
create table Compra_Farmaco (
	num_unidades int,
	dt_valid date,
	preco_unit decimal(6,2), --*
	
	nome_farmaco varchar(40),
	num int,
	cpf int,
	loginsh_pac varchar(30),
	
	primary key(loginsh_pac, num, cpf, nome_farmaco),
	
	foreign key(nome_farmaco) references tipo_farmaco(nome) on delete cascade on update cascade,
	
	foreign key(loginsh_pac, num, cpf) references 
		Compra(loginsh_pac, num, cpf) on delete cascade on update cascade
	
);

-- 27
create table Requisicao (
	cod_us_farm_pedido int,
	dt_hora_pedido date,
	dt_hora_entrega date,

	id_req int,
	cod_us_solicitante int,
	sala int,
	bloco varchar(2),
	primary key(id_req, cod_us_solicitante, sala, bloco),

	foreign key(bloco, sala, cod_us_solicitante) references enfermaria(bloco, sala, cod_us) on delete cascade on update cascade
);

-- 28
create table Requisicao_Farmacos (
	num_unidades int,

	farmaco varchar(40),
	id_req int,
	cod_us_sol int,
	sala int,
	bloco varchar(2),
	primary key(farmaco, id_req, cod_us_sol, sala, bloco),
	foreign key(farmaco) references tipo_farmaco(nome) on delete cascade on update cascade,
	foreign key(id_req, cod_us_sol, sala, bloco) references Requisicao(id_req, cod_us_solicitante, sala, bloco) 
		on delete cascade on update cascade
);

-- 29
create table US_espec (
	codCBO_esp int,
	cod_us int,

	primary key(cod_us, codCBO_esp),

	foreign key(codCBO_esp) references Especialidade(codCBO) on delete cascade on update cascade,
	foreign key(cod_us) references unidade_saude(cod) on delete cascade on update cascade
);

