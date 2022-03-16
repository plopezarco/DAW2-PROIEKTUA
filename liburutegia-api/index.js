const express = require('express');
const port = 8081;
const bodyParser = require('body-parser');
const routes = require('./routes/routes')
//const jsonErrorHandler = require('express-json-error-handler');
const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true,
}));

routes(app);

const server = app.listen(port, (error) => {
    if (error) return console.log(`Error: ${error}`);

    console.log(`Server listening on port ${server.address().port}`);
});