	//servidor nodejs
	// http://nodeexamples.com/2012/09/21/connecting-to-a-postgresql-database-from-node-js-using-the-pg-module/
     
	var http = require('http');

    console.log('Servidor iniciado em localhost:3000. Ctrl+C para encerrar…');

	//bancoA
    var pg = require('pg');
	var conString = "postgres://postgres:felinonino@localhost/Computadores";
	
	var client1 = new pg.Client(conString);

	client1.connect();
	client1.query('set search_path to mac439_aula10')

	var query = client1.query('select * from produto');
    var json = 0;

	query.on("row", function (row, result) {
   		result.addRow(row);
   		console.log(row)
		json = JSON.stringify(result.rows, null, "<br>")
	});

    
    http.createServer(
    	function(req, res) {
    		res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    		res.end('<h3>'+json+'</h3>');
    		
			//res.end(json)
    	}
    ).listen(3000);
	
	query.on("end", function (result) {
		client1.end();
	});