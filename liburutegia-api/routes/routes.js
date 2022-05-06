const { response } = require('express');
const req = require('express/lib/request');
const pool = require('../data/config');
const router = app => {
    app.get('/', (request, response) => {
        response.send({
            message: 'Welcome to the Node.js Express REST API!'
        });
    });

    app.get('/liburuak', (request, response) => {
        pool.query('SELECT * FROM liburua', (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            response.send(result);
        });
    });

    app.post('/liburuak', (request, response) => {
        pool.query('INSERT INTO liburua SET ?', request.body, (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            response.status(201).send(`Liburua added with ID: ${result.insertId}`);
        });
    });

    app.get('/liburuak/:id', (request, response) => {
        const id = request.params.id;

        pool.query('SELECT * FROM liburua WHERE idLiburua = ?', id, (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            response.send(result);
        });
    });

    app.get('/liburuak/idazlea/:id', (request, response) => {
        const id = request.params.id;

        pool.query('SELECT * FROM liburua WHERE idIdazlea = ?', id, (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            response.send(result);
        });
    });

    app.get('/idazleak', (request, response) => {
        pool.query('SELECT * FROM idazlea', (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            response.send(result);
        });
    });

    app.post('/idazleak', (request, response) => {
        pool.query('INSERT INTO idazlea SET ?', request.body, (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            response.status(201).send(`Idazlea added with ID: ${result.insertId}`);
        });
    });

    app.get('/idazleak/:id', (request, response) => {
        const id = request.params.id;

        pool.query('SELECT * FROM idazlea WHERE idIdazlea = ?', id, (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            response.status(200).send(result);
        });
    });

    app.post('/signup', (request, response) => {
        var email = request.body["email"];
        var pass = request.body["password"];

        pool.query('insert into erabiltzailea (email, pasahitza) values (?,?)', [email,pass], (error,result) => {
            if (error) {
                if(error.errno === 1062){
                    response.status(409).send();
                    return;
                }
                sendError(error,response)
                return;
            }

            response.status(201).send(true);
        });
    });

    app.post('/login', (request, response) => {
        var email = request.body["email"];
        var pass = request.body["password"];

        pool.query('SELECT * FROM erabiltzailea WHERE email = ? and pasahitza = ?', [email, pass],  (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            if (result  && result.length > 0){
                response.send(true);
                return;
            }
            response.send(false);
        });
    });

    app.get('/login/:user', (request, response) => {
        var user = request.params.user;

        pool.query('SELECT idErabiltzailea FROM erabiltzailea WHERE email = ? ', [user],  (error, result) => {
            if (error) {
                sendError(error,response)
            }
            response.status(200).send(result);
        });
    });

    app.post('/eskaerak', (request, response) => {
        var eData = request.body["eskaeraData"];
        var iData = request.body["itzultzeData"];
        var idErab = request.body["idErabiltzailea"];
        var izena = request.body["izena"];
        var abizena = request.body["abizena"];
        var helbidea = request.body["helbidea"];
        var liburuak = request.body["liburuak"];

        pool.query('INSERT INTO eskaera(EskaeraData, ItzultzeData, idErabiltzailea, izena, abizena, helbidea) values (?, ?, ?, ?, ?, ?)', [eData, iData, idErab, izena,abizena,helbidea], (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }
            
            var idEskaera = result.insertId;

            for(var i of liburuak){
                pool.query('INSERT INTO eskaeralerroa(idLiburua,idEskaera) values (?, ?)', [i, idEskaera]);
            }

            response.status(201).send(true);
        });
    });

    app.get('/eskaerak/:id', (request, response) => {
        const id = request.params.id;

        pool.query('SELECT * FROM eskaera WHERE idErabiltzailea = ?', id, (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            response.send(result);
        });
    });

    app.get('/eskaerak/:id/lerroak', (request, response) => {
        const id = request.params.id;

        pool.query('SELECT * FROM eskaeralerroa WHERE idEskaera = ?', id, (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            response.send(result);
        });
    });

    app.post('/eskaerak/:id/lerroak', (request, response) => {
        const id = request.params.id;
        const lerro = request.body["idLerroa"];

        pool.query('update eskaeralerroa set itzulita = 1 where idEskaera = ? and idEskaeralerroa = ?', [id, lerro], (error, result) => {
            if (error) {
                sendError(error,response)
                return;
            }

            response.send(result);
        });
    });
}

function sendError(error, response){
    for (var k in error) {
        console.log(`${k}: ${error[k]}`);
        //response.status(500).send(error.code);
    }
}

module.exports = router;