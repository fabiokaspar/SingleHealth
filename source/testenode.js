	//servidor nodejs
	// http://nodeexamples.com/2012/09/21/connecting-to-a-postgresql-database-from-node-js-using-the-pg-module/
	 
	var http = require('http');
	var pg = require('pg');

	console.log('Servidor iniciado em localhost:3000. Ctrl+C para encerrar…');

	//bancoA
	var conString = "postgres://postgres:felinonino@localhost/Computadores";
	
	var client1 = new pg.Client(conString);

	client1.connect();
	client1.query('set search_path to mac439_aula10')
    
	var jsonTxt;
	var json;
	var query = showTable("laptop")
	
	query.on("row", function (row, result) {
		result.addRow(row);
		jsonTxt = JSON.stringify(result.rows, null, "  ")
		json = result.rows
	});

	
	http.createServer(
		function(req, res) {
			res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });

			res.write(jsonTxt)
			res.write("<br><br>")
			
			var fields = [];
			var html;

			for (key in json[0]) {
				fields.push(key)
			}
			console.log(fields)
			
			html = "<table><tr>"; 
			for (var i = 0; i < fields.length; i++) {
				html += ("<td> <b>| "+ fields[i] +"</b></td>");
			}
			html += ("</tr>")

			for (var i = 0; i < json.length; i++) {
				html += ("<tr>")

				var campo;
				for (var j = 0; j < fields.length; j++) {
					campo = fields[j]
					html += ("<td>| "+ json[i][campo]+ " </td>")
				}
				
				html += ("</tr>")
			}

			html += ("</table>")

			res.write(html)

			res.end()
			//res.end('<h6>'+json+'</h6>');
		}
	).listen(3000);
	

	query.on("end", function (result) {
		client1.end();
	});



/*===================== Funções ============================*/

	function showTable (nomeTabela) {
		var query2 = client1.query('select * from '+ nomeTabela);
		return query2;	
	}

	function geraHTMLTabela () {

	}


	

