require 'mongo'

client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')

collection = client[:tipo_exames]

collection.delete_many({})

docs = [ 
		{ _id: 1, codigoAMB: '00010014', descricao: 'Consulta Médica (em Consultório (no Horário Normal ou Preestabelecido))', preco: 100.0},
		{ _id: 2, codigoAMB: '00010061', descricao: 'Consulta (Pronto Atendimento)', preco: 100.0},
		{ _id: 3, codigoAMB: '13010034', descricao: 'Biópsia de Músculo', preco: 167.0},
		{ _id: 4, codigoAMB: '20010133', descricao: 'Ecodopplercardiograma Transtorácico - Pulsado e Contínuo', preco: 380.0},
		{ _id: 5, codigoAMB: '22010017', descricao: 'Eletroencefalograma de Rotina', preco: 120.0},
		{ _id: 6, codigoAMB: '22010068', descricao: 'Ecoencefalograma', preco: 180.0},
		{ _id: 7, codigoAMB: '26100126', descricao: 'Hormônio Gonodotrofico Corionico Quantitativo (Hcg-Beta-Hcg)', preco: 180.0},
		{ _id: 8, codigoAMB: '27040470', descricao: 'Biópsia de Medula Óssea (por Agulha)', preco: 150.0},
		{ _id: 9, codigoAMB: '28040180', descricao: 'Hemograma Completo (Eritrograma)', preco: 20.0},
		{ _id: 10, codigoAMB: '25010034', descricao: 'Eletrodiagnóstico', preco: 45.0} 
       ]

collection.insert_many(docs)

doc = { _id: 11, codigoAMB: '20010079', descricao: 'Sistema Holter - 12 Horas - 2 Canais', preco: 280.0} 

collection.insert_one(doc)

lista = collection.find({})
puts "\n\n-------------------------- TODOS EXAMES ------------------------------------\n\n"
lista.each do |e|
	puts e
end

puts "\n\n---------------------------- UM EXAME X ------------------------------------\n\n"
puts collection.find( { codigoAMB: '25010034' } ).first


collection.delete_one( { codigoAMB: '25010034' } )

lista = collection.find({})
puts "\n\n----------------------- TODOS EXAMES SEM O X -----------------------------\n\n"
lista.each do |e|
	puts e
end

collection.update_many( {}, { '$set' => { 'preco' => 100.0 } } )

lista = collection.find({})
puts "\n\n------------------ TODOS EXAMES COM PRECO ATUALIZADO -------------------------\n\n"
lista.each do |e|
	puts e
end

collection.update_one( { 'descricao' => 'Sistema Holter - 12 Horas - 2 Canais' }, 
					   { '$set' => { 'tempo_uso' => '24h' } } )


lista = collection.find({})
puts "\n\n----------------------- EXAME HOLTER ALTERADO -------------------------\n\n"
lista.each do |e|
	puts e
end


colecao = client[:clinicas]

docs = [ 
		{ _id: 1, codigo: 1, end_rua: 'Albert Einstein', end_bairro: 'Jardim Moreira', end_cidade: 'Guarulhos', end_num: '121', end_estado: 'São Paulo', bandeira: 'CLINICA_A', reg_jur: 'particular', tel: '11-111111', site: 'www.clinica_a.com.br' },	
		{ _id: 2, codigo: 2, end_rua: 'Thomas Edson', end_bairro: 'Jardim Adriana', end_cidade: 'Santo André', end_num: '122', end_estado: 'São Paulo', bandeira: 'CLINICA_B', reg_jur: 'público', tel: '11-222222', site: 'www.clinica_b.com.br' },	
		{ _id: 3, codigo: 3, end_rua: 'Max Planck', end_bairro: 'Jardim Camargo', end_cidade: '	Diadema', end_num: '123', end_estado: 'São Paulo', bandeira: 'CLINICA_C', reg_jur: 'particular', tel: '11-333333', site: 'www.clinica_c.com.br' },	
		{ _id: 4, codigo: 4, end_rua: 'Isaac Newton', end_bairro: 'Jardim Moreira', end_cidade: 'Osasco', end_num: '124', end_estado: 'São Paulo', bandeira: 'CLINICA_D', reg_jur: 'particular', tel: '11-444444', site: 'www.clinica_d.com.br' },	
		{ _id: 5, codigo: 5, end_rua: 'Nikola Tesla', end_bairro: 'Jardim Adriana', end_cidade: 'São Bernardo do Campo', end_num: '125', end_estado: 'São Paulo', bandeira: 'CLINICA_E', reg_jur: 'particular', tel: '11-555555', site: 'www.clinica_e.com.br' },	
		{ _id: 6, codigo: 6, end_rua: 'Alessandro Volta', end_bairro: 'Jardim Camargo', end_cidade: 'São Paulo', end_num: '126', end_estado: 'São Paulo', bandeira: 'CLINICA_F', reg_jur: 'público', tel: '11-666666', site: 'www.clinica_f.com.br' },	
       ]

colecao.delete_many({})
colecao.insert_many(docs)

lista = colecao.find({})

puts "\n\n------------------------ NOVA COLECAO: CLÍNICAS -----------------------------\n\n"
lista.each do |c|
	puts c
end

