const express = require('express');
const router = express.Router();

const mainController = require('../controllers/mainController');
const SeriesController = require('../controllers/seriesController');

router.get('/', mainController.index);

module.exports = router;
