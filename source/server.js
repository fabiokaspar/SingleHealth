	//servidor nodejs
	// http://nodeexamples.com/2012/09/21/connecting-to-a-postgresql-database-from-node-js-using-the-pg-module/
	 
	var http = require('http');
	var pg = require('pg');
	var fs = require('fs');
	var formidable = require("formidable");
	var util = require('util');

	var conString = "postgres://postgres:felinonino@localhost/Computadores";
	
	var client = new pg.Client(conString);

	client.connect();
	client.query('set search_path to mac439_aula10')
    
	var jsonTxt;
	var json;
	var query;
	var fields;
	var html;

	//var query = showTable("impressora")
	
	/*query.on("row", function (row, result) {
		result.addRow(row);
		jsonTxt = JSON.stringify(result.rows, null, "  ")
		json = result.rows
	});
	*/


	var server = http.createServer(
		function(req, res) {
			if (req.method.toLowerCase() == 'get') {
	    		displayForm(res);
	    	} else if (req.method.toLowerCase() == 'post') {
				//console.log(req)
				processAllFieldsOfTheForm(req, res);
			}
		}
	);

	function displayForm(res) {
    	fs.readFile('form.html', function (err, data) {
	        res.writeHead(200, {
	            'Content-Type': 'text/html',
	            'Content-Length': data.length
	        });
	        res.write(data);
	        res.end();
    	});
	}
	
	function processAllFieldsOfTheForm(req, res) {
	    var form = new formidable.IncomingForm();

	    form.parse(req, function (err, fields, files) {
	        //Store the data from the fields in your data store.
	        //The data store could be a file or database or any other store based
	        //on your application.
	        res.writeHead(200, {
            	'content-type': 'text/plain'
	        });
	        
	        res.write('dados recebidos:\n\n');
	        
	        res.end(util.inspect({
	            fields: fields,
	            files: files
	        }));

			//console.log(fields)
			//var atrs = atributosTabela(fields)
			
			if (fields.botao == 'Insere') {
				var register  = ["oi","x@x", "bla"];

				client.query('insert into teste values($1, $2, $3)', 
					register);
			}

			else if (fields.botao == 'Busca') {
				query = client.query('select * from teste');
				console.log(teste)
				
				query.on("row", function (row, result) {
					console.log("--- enter -----")
					result.addRow(row);
					jsonTxt = JSON.stringify(result.rows, null, "  ")
					json = result.rows
				});
				
				console.log(json)
				fields = atributosTabela(json)
				html = geraHTMLTabela(fields, json)
				res.write(html);
			}

	    });
	}

	server.listen(3000);
	console.log('Servidor iniciado em localhost:3000. Ctrl+C para encerrar…');

	
	query.on("end", function (result) {
		console.log("quero sair!")
		client.end();
	});


/*===================== Funções ============================*/

	function showTable (nomeTabela) {
		var query = client.query('select * from '+ nomeTabela);
		return query;
	}

	function geraHTMLTabela (fields, json) {
		var html = "<table><tr>"; 
			
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
		return html;
	}

	function atributosTabela (json) {
		var fields = [];
		var html;

		for (key in json) {
			fields.push(key)
		}

		return fields;
	}
	
	/*
	function displayForm(res) {
    	fs.readFile('form.html', function (err, data) {
        	res.writeHead(200, {
            	'Content-Type': 'text/html; charset=utf-8',
                'Content-Length': data.length
        	});
        	
        	res.write(data);
			var fields = atributosTabela(json[0])
			html = geraHTMLTabela(fields, json)
			
			res.write(jsonTxt)
			res.write("<br><br>")
			res.write(html)
			res.end()
    	});
	}
	*/
	
	function processFormFieldsIndividual(req, res) {
	    //Store the data from the fields in your data store.
	    //The data store could be a file or database or any other store based
	    //on your application.
	    var fields = [];
	    var form = new formidable.IncomingForm();
	    form.on('field', function (field, value) {
	        console.log(field);
	        console.log(value);
	        fields[field] = value;
	    });

	    form.on('end', function () {
	        res.writeHead(200, {
	            'content-type': 'text/plain'
	        });
	        res.write('***dados recebidos***:\n\n');
	        res.end(util.inspect({
	            fields: fields
	        }));
	    });
	    form.parse(req);
	} 

