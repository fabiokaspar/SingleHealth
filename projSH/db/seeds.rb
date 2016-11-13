# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).



# remove todas as tuplas de drug_types, se existerem
DrugType.all.each do |d|
	d.destroy
end

d = DrugType.create(nome: 'atenollol', fabricante: 'A', tarja: 'amarela', descricao: 'controle de pressão arterial', contraindicacoes: 'suspeita de dengue; alergia a algum componente da fórmula')
d = DrugType.create(nome: 'sertralina', fabricante: 'B', tarja: 'vermelha', descricao: 'depressão, ansiedade; causa dependência química', contraindicacoes: 'sensibilidade a algum componente da fórmula; uso não recomendado a gestantes a partir de 6 meses;')
d = DrugType.create(nome: 'sertralinaB', fabricante: 'B', tarja: 'preta', descricao: 'depressão, ansiedade; causa dependência química', contraindicacoes: 'sensibilidade a algum componente da fórmula; uso não recomendado a gestantes a partir de 6 meses;')
d = DrugType.create(nome: 'Azatioprina', fabricante: 'C', tarja: 'preta', descricao: 'controle de ácido úrico', contraindicacoes: 'sensibilidade a algum componente da formula; uso não recomendado a portadores de diabetes')
d = DrugType.create(nome: 'Captopril', fabricante: 'Ache', tarja: 'preta', descricao: 'controle de colesterol e triglicérides', contraindicacoes: 'sensibilidade a algum componente da formula')
d = DrugType.create(nome: 'CaptoprilB', fabricante: 'Ache', tarja: 'vermelha', descricao: 'controle de colesterol e triglicérides', contraindicacoes: 'sensibilidade a algum componente da formula')

puts "\n========================= DrugTypes =========================\n\n"
DrugType.all.each do |d|
	puts "#{d.nome} - #{d.fabricante} - #{d.tarja} - #{d.descricao} - #{d.contraindicacoes} \n\n"
end



User.all.each do |u|
	u.destroy
end

u = User.create(loginsh: 'fabio@@kaspar', email: 'fabiokaspar@gmail.com', cargo: 'nenhum', senhash: '123456', end_cidade: 'são paulo', end_rua: 'rua Olavo Bilac', end_bairro: 'Pimentas', end_num: 121, dt_nasc: DateTime.now.strftime('%12/%2/%1992'), rg: 368609261, nome_completo: 'fabio eduardo kaspar', filiacao_pai: 'paulo kaspar', filiacao_mae: 'normelia ap. kaspar')
u = User.create(loginsh: 'x@@x', email: 'x@mail.com', cargo: 'medico', senhash: '654321', end_cidade: 'são paulo', end_rua: 'rua xxx', end_bairro: 'xyz', end_num: 100, dt_nasc: DateTime.now.strftime('%10/%4/%1972'), rg: 12323, nome_completo: 'joao carlos', filiacao_pai: 'joao pai', filiacao_mae: 'joana mae')
u = User.create(loginsh: 'y@@y', email: 'y@mail.com', cargo: 'enfermeiro', senhash: '1111111', end_cidade: 'santos', end_rua: 'rua aaa', end_bairro: 'bbb', end_num: 2900, dt_nasc: DateTime.now.strftime('%10/%15/%1982'), rg: 321321, nome_completo: 'roberto carlos jr', filiacao_pai: 'roberto carlos', filiacao_mae: 'roberta aparecida')
u = User.create(loginsh: 'zezinho@@ze', email: 'zezinho@mail.com', cargo: 'enfermeiro', senhash: '000111', end_cidade: 'santos', end_rua: 'rua aaa', end_bairro: 'bbb', end_num: 2900, dt_nasc: DateTime.now.strftime('%11/%5/%1982'), rg: 9999, nome_completo: 'roberto carlos jr', filiacao_pai: 'roberto carlos', filiacao_mae: 'roberta aparecida')


puts "\n========================= Users =========================\n\n"
User.all.each do |u|
	puts "#{u.loginsh} - #{u.email} - #{u.cargo} - #{u.end_cidade} - #{u.end_bairro} - #{u.end_num} - #{u.end_rua} - #{u.dt_nasc} - #{u.nome_completo} \n\n"
end



Specialty.all.each do |esp|
	esp.destroy
end

esp = Specialty.create([{codcbo: 225133, nome: 'médico psiquiatra'}, 
						{codcbo: 225125, nome: 'Médico Clínico'},
						{codcbo: 225127, nome: 'Médico Pneumologista'},
						{codcbo: 225135, nome: 'Médico Dermatologista'},
						{codcbo: 225124, nome: 'Médico Pediatra'},
						{codcbo: 225120, nome: 'Médico Cardiologista'}
					   ])

puts "\n========================= Specialties =========================\n\n"
Specialty.all.each do |s|
	puts "#{s.codcbo} - #{s.nome}\n\n"
end


puts "\nAlguns exemplos de consultas:\n\n"


puts "\n\nUsuario de login fabio@@kaspar:\n"

u = User.find_by(loginsh: "fabio@@kaspar")
puts "#{u.loginsh} - #{u.email} - #{u.cargo} - #{u.end_cidade} - #{u.end_bairro} - #{u.end_num} - #{u.end_rua} - #{u.dt_nasc} - #{u.nome_completo} \n\n"


puts "\n\nLista de usuarios que residem na cidade de são paulo e projeta os campos do select:\n"

lu = User.where(end_cidade: 'são paulo').select("nome_completo, dt_nasc, loginsh")

puts "\nnome_completo | dt_nasc | loginsh\n\n"
lu.each do |u|
	puts "#{u.nome_completo} - #{u.dt_nasc} - #{u.loginsh}\n"
end


u = User.find_by(rg: 321321)
# remove o usuario de rg 321321
u.destroy
puts "\n\nUsuario de rg 321321 removido com sucesso!\n\n"

puts "\n========================= Users =========================\n\n"
User.all.each do |u|
	puts "#{u.loginsh} - #{u.email} - #{u.cargo} - #{u.end_cidade} - #{u.end_bairro} - #{u.end_num} - #{u.end_rua} - #{u.dt_nasc} - #{u.nome_completo} \n\n"
end


u = User.first
puts "\n1º usuario: nome_completo | dt_nasc | loginsh\n\n"
puts "#{u.nome_completo} - #{u.dt_nasc} - #{u.loginsh}"
	
ut = User.last
puts "\n\nUltimo usuario: nome_completo | dt_nasc | loginsh\n\n"
puts "#{ut.nome_completo} - #{ut.dt_nasc} - #{ut.loginsh}"
	



puts "\n\nUsuario a ser atualizado:\n\n"
u = User.find_by(loginsh: 'fabio@@kaspar')
puts "#{u.loginsh} - #{u.email} - #{u.cargo} - #{u.end_cidade} - #{u.end_bairro} - #{u.end_num} - #{u.end_rua} - #{u.dt_nasc} - #{u.nome_completo} \n\n"

User.update('fabio@@kaspar', email: 'fabiokaspar@hotmail.com', cargo: 'médico', end_cidade: 'Guarulhos', dt_nasc: DateTime.now.strftime('%25/%11/%1980'))

u = User.find_by(loginsh: 'fabio@@kaspar')

puts "\n\nUsuário atualizado com sucesso!\n\n"
puts "#{u.loginsh} - #{u.email} - #{u.cargo} - #{u.end_cidade} - #{u.end_bairro} - #{u.end_num} - #{u.end_rua} - #{u.dt_nasc} - #{u.nome_completo} \n\n"



meu_hash = {'atenollol' => {fabricante: 'novoA', tarja: 'vermelha', descricao: 'controle de pressão arterial e tratamento pós-infarto; uso adulto', contraindicacoes: 'sem restrição'}, 
			'sertralina' => {fabricante: 'novoB', tarja: 'amarela'} 
		   }

DrugType.update(meu_hash.keys, meu_hash.values)

puts "\n\n Atualização de múltiplos registros feita com sucesso!"
puts "\n========================= DrugTypes =========================\n\n"
DrugType.all.each do |d|
	puts  "#{d.nome} - #{d.fabricante} - #{d.tarja} - #{d.descricao} - #{d.contraindicacoes} \n\n"
end