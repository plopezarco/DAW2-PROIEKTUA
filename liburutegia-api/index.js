const express = require('express');
const port = 8081;
const bodyParser = require('body-parser');
const routes = require('./routes/routes')
//const jsonErrorHandler = require('express-json-error-handler');
const app = express();
const cors = require("cors");


app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true,
}));
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
    next();
});


routes(app);

const server = app.listen(port, (error) => {
    if (error) return console.log(`Error: ${error}`);

    console.log(`Server listening on port ${server.address().port}`);
});