const bodyParser = require('body-parser');
const express = require('express');
const cors = require('cors');
const app = express();
const morgan = require('morgan');

const mainRoute = require('./routers/mainRoute');

//middleware
app.use(morgan('dev'));

app.use(bodyParser.json({ limit: '10mb' }));
app.use(express.json());
app.use(cors());

app.use('/', mainRoute);

module.exports = app;