const { response } = require('express');
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
            }

            response.send(result);
        });
    });

    app.get('/liburuak/:id', (request, response) => {
        const id = request.params.id;

        pool.query('SELECT * FROM liburua WHERE idLiburua = ?', id, (error, result) => {
            if (error) {
                sendError(error,response)
            }

            response.send(result);
        });
    });

    app.get('/liburuak/idazlea/:id', (request, response) => {
        const id = request.params.id;

        pool.query('SELECT * FROM liburua WHERE idIdazlea = ?', id, (error, result) => {
            if (error) {
                sendError(error,response)
            }

            response.send(result);
        });
    });

    app.post('/login', (request, response) => {
        var email = request.body["email"];
        var pass = request.body["password"];

        pool.query('SELECT * FROM erabiltzailea WHERE email = ? and pasahitza = ?', [email, pass],  (error, result) => {
            if (error) {
                sendError(error,response)
            }

            if (result  && result.length > 0){
                response.send(true);
                return;
            }
            response.send(false);
        });
    });

    app.post('/liburuak', (request, response) => {
        pool.query('INSERT INTO liburua SET ?', request.body, (error, result) => {
            if (error) {
                sendError(error,response)
            }

            response.status(201).send(`Liburua added with ID: ${result.insertId}`);
        });
    });

    app.get('/idazleak', (request, response) => {
        pool.query('SELECT * FROM idazlea', (error, result) => {
            if (error) {
                sendError(error,response)
            }

            response.send(result);
        });
    });

    app.get('/idazleak/:id', (request, response) => {
        const id = request.params.id;

        pool.query('SELECT * FROM idazlea WHERE idIdazlea = ?', id, (error, result) => {
            if (error) {
                sendError(error,response)
            }

            response.status(200).send(result);
        });
    });

    app.post('/idazleak', (request, response) => {
        pool.query('INSERT INTO idazlea SET ?', request.body, (error, result) => {
            if (error) {
                sendError(error,response)
            }

            response.status(201).send(`Idazlea added with ID: ${result.insertId}`);
        });
    });


    /*// Add a new user
    app.post('/users', (request, response) => {
        pool.query('INSERT INTO users SET ?', request.body, (error, result) => {
            if (error) throw error;

            response.status(201).send(`User added with ID: ${result.insertId}`);
        });
    });

    // Update an existing user
    app.put('/users/:id', (request, response) => {
        const id = request.params.id;

        pool.query('UPDATE users SET ? WHERE id = ?', [request.body, id], (error, result) => {
            if (error) throw error;

            response.send('User updated successfully.');
        });
    });

    // Delete a user
    app.delete('/users/:id', (request, response) => {
        const id = request.params.id;

        pool.query('DELETE FROM users WHERE id = ?', id, (error, result) => {
            if (error) throw error;
            response.send('User deleted.');
        });
    });*/
}

function sendError(error, response){
    for (var k in error) {
        console.log(`${k}: ${error[k]}`);
        response.status(500).send(error.code);
    }
}

module.exports = router;