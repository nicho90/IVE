var express = require('express');
var router = express.Router();
var isAuthenticated = require('../server.js').isAuthenticated;

var multipart = require('connect-multiparty');
var multipartMiddleware = multipart();

var list = require('../controllers/videos/list');
var post = require('../controllers/videos/post');
var del_all = require('../controllers/videos/delete_all');

var get = require('../controllers/videos/get');
var put = require('../controllers/videos/put');
var del = require('../controllers/videos/delete');

var list_by_scenario = require('../controllers/videos/list_by_scenario');
var list_by_location = require('../controllers/videos/list_by_location');

var uploadVideo = require('../controllers/videos/upload_video');

var get_by_video = require('../controllers/feedback/get_by_video');
var get_rating_by_video = require(  '../controllers/feedback/get_rating_by_video');
var post_by_video = require('../controllers/feedback/post_by_video');


// LIST
router.get('/videos', list.request);

// POST
router.post('/videos', isAuthenticated, post.request);

// DELETE
router.delete('/videos', isAuthenticated, del_all.request);


// GET
router.get('/videos/:video_id', get.request);

// PUT
router.put('/videos/:video_id', isAuthenticated, put.request);

// DELETE
router.delete('/videos/:video_id', isAuthenticated, del.request);


// LIST BY SCENARIO
router.get('/scenarios/:scenario_id/videos', list_by_scenario.request);

// LIST BY LOCATION
router.get('/locations/:location_id/videos', list_by_location.request);

// UPLOAD NEW IVE VIDEO
router.post('/videos/uploadVideo/:folderUrl', multipartMiddleware, isAuthenticated, uploadVideo.request);



// GET FEEDBACK POSTS
router.get('/videos/:video_id/posts', get_by_video.request);

// GET FEEDBACK (AVERAGE) RATING
router.get('/videos/:video_id/rating', get_rating_by_video.request);

// POST FEEDBACK
router.post('/videos/:video_id/posts', post_by_video.request);


module.exports = router;
