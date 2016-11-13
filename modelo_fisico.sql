set search_path to public;

create domain login_type as varchar(30);
create domain farmaco_type as varchar(40);

-- 11
create table users (
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
	loginsh login_type unique primary key
);


-- 14
create table directors (
	loginsh login_type unique primary key,
	foreign key(loginsh) references users(loginsh) on delete cascade on update cascade
);

-- 1
create table health_units (
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
	foreign key(loginsh_dir) references directors(loginsh) on delete cascade on update cascade	
);

-- 2
create table hospital_rooms (
	andar int,
	sala int unique,
	bloco char(1) unique,
	cod_us int unique,
	primary key(sala, bloco, cod_us),
	foreign key(cod_us) references health_units(cod) on delete cascade on update cascade	
);

-- 3
create table consulting_rooms (
	sala int unique,
	bloco char(1) unique,
	cod_us int unique,
	primary key(sala, bloco, cod_us),
	foreign key(sala, bloco, cod_us) references consulting_rooms (sala, bloco, cod_us) on delete cascade on update cascade	
);


-- 4
create table pharmacies (
	nome varchar(20),
	capacidade int,
	qtdTotalRem int, -- *
	valTotalRem decimal(10,2), --*
	sala int unique,
	bloco char(1) unique, 
	cod_us int unique,
	primary key(sala, bloco, cod_us),
	foreign key(sala, bloco, cod_us) references consulting_rooms(sala, bloco, cod_us) on delete cascade on update cascade	
);


-- 5 (wardss)
create table wards (
	total_remed_disp int,
	capacidade_rem int,
	sala int unique,
	bloco char(1) unique,
	cod_us int unique,
	primary key(sala, bloco, cod_us),
	foreign key(sala, bloco, cod_us) references consulting_rooms(sala, bloco, cod_us) on delete cascade on update cascade	
);



-- 6 (salas de observação)
create table observation_rooms (
	alimentacao_geral varchar(60),
	num_leitos_uso int,
	num_leitos int,
	grau_risco varchar(20),
	tempo_visita interval,
	sala int unique,
	bloco char(1) unique,
	cod_us int unique,
	primary key(sala, bloco, cod_us),
	foreign key(sala, bloco, cod_us) references consulting_rooms(sala, bloco, cod_us) on delete cascade on update cascade	
);


-- 7 (drug_types)
create table drug_types (
	fabricante varchar(20),
	tarja varchar(20),
	descricao varchar(300),
	contraindicacoes varchar(300),
	nome farmaco_type unique,
	primary key(nome)
);


-- 8
create table pharmacy_drugs (
	preco_unit numeric(6,2),
	num_unidades int,
	data_valid date,
	data_fabr date,
	sala int unique,
	bloco char(1) unique,
	cod_us int unique,
	nome_farmaco farmaco_type unique,
	primary key(sala, bloco, cod_us, nome_farmaco),
	foreign key(sala, bloco, cod_us) references pharmacies(sala, bloco, cod_us) on delete cascade on update cascade,
	foreign key(nome_farmaco) references drug_types(nome) on delete cascade on update cascade	
);


-- 9 (fornecedores)
create table providers (
	cnpj_fornc int unique,
	sala int unique,
	bloco char(1) unique,
	cod_us int unique,
	primary key(sala, bloco, cod_us),
	foreign key(sala, bloco, cod_us) references pharmacies(sala, bloco, cod_us) on delete cascade on update cascade	
);


-- 10
create table ward_drugs (
	fracao_restante float, -- *
	dt_val date,	
	sala int unique,
	bloco char(1) unique,
	cod_us int unique,
	nome_farmaco farmaco_type unique,
	primary key(sala, bloco, cod_us, nome_farmaco),
	foreign key(sala, bloco, cod_us) references wards(sala, bloco, cod_us) on delete cascade on update cascade,
	foreign key(nome_farmaco) references drug_types(nome) on delete cascade on update cascade
);

-- 12 (specialtiess)
create table specialties (
	nome varchar(30),
	codCBO int unique primary key
);


-- 13
create table patients (
	num_carteira int unique, --*
	loginsh login_type unique primary key,
	foreign key(loginsh) references users(loginsh) on delete cascade on update cascade
);



-- 15
create table employees (
	cpf int unique,
	loginsh login_type unique primary key,
	foreign key(loginsh) references users(loginsh) on delete cascade on update cascade
);


-- 16 (farmaceuticos)
create table pharmacists (
	crf int unique,
	loginsh login_type unique primary key,
	foreign key(loginsh) references employees(loginsh) on delete cascade on update cascade
);


-- 17 
create table doctors (
	crm int unique,
	loginsh login_type unique primary key,
	foreign key(loginsh) references employees(loginsh) on delete cascade on update cascade
);


-- 18 (enfermeiros)
create table nurses (
	coren int unique,
	loginsh login_type unique primary key,
	foreign key(loginsh) references employees(loginsh) on delete cascade on update cascade
);


-- 19
create table employee_works (
	num_hrs_por_dia int,
	num_dias_por_semana int,
	loginsh login_type unique,
	sala int unique,
	bloco char(1) unique,
	cod_us int unique,
	foreign key(loginsh) references employees(loginsh) on delete cascade on update cascade,
	foreign key(bloco, sala, cod_us) references consulting_rooms(bloco, sala, cod_us) on delete cascade on update cascade
);


-- 20
create table doctor_specialties (
	codCBO int unique,
	loginsh_med login_type unique,
	primary key(codCBO, loginsh_med),
		
	foreign key(loginsh_med) references doctors(loginsh) on delete cascade on update cascade,
	foreign key(codCBO) references specialties(codCBO) on delete cascade on update cascade
);


-- 21 (compras)
create table purchases (
	data date,
	--cod_us_pharmacies int,
	formaPgto varchar(20),
	valorCompra decimal(6,2), --*

	cpf int unique,
	num int unique,
	loginsh_pac login_type unique,
	primary key(cpf, num, loginsh_pac),
		
	foreign key(loginsh_pac) references patients(loginsh) on delete cascade on update cascade
);


-- 22
create table patient_units (
	data_vinculo date,
	ehConveniado boolean,  -- um id adicional ?
	mensalidade decimal(6,2), --*
	
	cod_us int unique,
	loginsh_pac login_type unique,
	primary key(cod_us, loginsh_pac),
		
	foreign key(loginsh_pac) references patients(loginsh) on delete cascade on update cascade,
	foreign key(cod_us) references health_units(cod) on delete cascade on update cascade
);


-- 23 (consultas)
create table consultations (
	dt_hora date,
	relato_doenca varchar(50),
	dt_retorno date,
	
	id int unique,
	loginsh_pac login_type unique,
	loginsh_med login_type unique,
	primary key(id, loginsh_pac, loginsh_med),
	
	foreign key(loginsh_pac) references patients(loginsh) on delete cascade on update cascade,
	foreign key(loginsh_med) references doctors(loginsh) on delete cascade on update cascade
);


-- 24 (receitas)
create table recipes (
	num int unique,
	id_consulta int unique,
	loginsh_pac login_type unique,
	loginsh_med login_type unique,
	primary key(num, id_consulta, loginsh_pac, loginsh_med),
	foreign key(id_consulta, loginsh_pac, loginsh_med) references consultations(id, loginsh_pac, loginsh_med) on delete cascade on update cascade
);


-- 25
create table recipe_drugs (
	dosagem varchar(30),
	periodo interval, --*
	quem_ministra varchar(20),
	
	num_receita int unique,
	id_consulta int unique,
	loginsh_pac login_type unique,
	loginsh_med login_type unique,
	farmaco farmaco_type unique,
	primary key(id_consulta, num_receita, loginsh_pac, loginsh_med, farmaco),

	foreign key(num_receita, id_consulta, loginsh_pac, loginsh_med) references 
		recipes(num, id_consulta, loginsh_pac, loginsh_med) on delete cascade on update cascade,
	
	foreign key(farmaco) references drug_types(nome) on delete cascade on update cascade
	
);


-- 26
create table purchase_drugs (
	num_unidades int,
	dt_valid date,
	preco_unit decimal(6,2), --*
	
	nome_farmaco farmaco_type unique,
	num int unique,
	cpf int unique,
	loginsh_pac login_type unique,
	
	primary key(loginsh_pac, num, cpf, nome_farmaco),
	
	foreign key(nome_farmaco) references drug_types(nome) on delete cascade on update cascade,
	
	foreign key(loginsh_pac, num, cpf) references 
		purchases(loginsh_pac, num, cpf) on delete cascade on update cascade
	
);

-- 27
create table requisitions (
	cod_us_farm_pedido int,
	dt_hora_pedido date,
	dt_hora_entrega date,

	id_req int unique,
	cod_us_solicitante int unique,
	sala int unique,
	bloco char(1) unique,
	primary key(id_req, cod_us_solicitante, sala, bloco),

	foreign key(bloco, sala, cod_us_solicitante) references wards(bloco, sala, cod_us) on delete cascade on update cascade
);

-- 28
create table requisition_drugs (
	num_unidades int,

	farmaco farmaco_type unique,
	id_req int unique,
	cod_us_sol int unique,
	sala int unique,
	bloco char(1) unique,
	primary key(farmaco, id_req, cod_us_sol, sala, bloco),
	foreign key(farmaco) references drug_types(nome) on delete cascade on update cascade,
	foreign key(id_req, cod_us_sol, sala, bloco) references requisitions(id_req, cod_us_solicitante, sala, bloco) 
		on delete cascade on update cascade
);

-- 29
create table unit_specialties (
	codCBO_esp int unique,
	cod_us int unique,

	primary key(cod_us, codCBO_esp),

	foreign key(codCBO_esp) references specialties(codCBO) on delete cascade on update cascade,
	foreign key(cod_us) references health_units(cod) on delete cascade on update cascade
);

