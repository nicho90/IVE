var colors = require('colors');
var async = require('async');
var neo4j = require('neo4j-driver').v1;
var _ = require('underscore');
var moment = require('moment');
var driver = require('../../server.js').driver;
var fs = require("fs");
var query_get_video = fs.readFileSync(__dirname + '/../../queries/videos/get.cypher', 'utf8').toString();
var query_delete_video = fs.readFileSync(__dirname + '/../../queries/videos/delete.cypher', 'utf8').toString();


// DELETE
exports.request = function(req, res) {

    // Start session
    var session = driver.session();

    async.waterfall([
        function(callback) { // Find entry by Id
            session
                .run(query_get_video, {
                    video_id: req.params.video_id
                })
                .then(function(result) {
                    // Check if Video exists
                    if (result.records.length === 0) {
                        callback(new Error("Video with id '" + req.params.video_id + "' not found!"), 404);
                    } else {
                        callback(null, result);
                    }
                })
                .catch(function(err) {
                    callback(err, 500);
                });
        },
        function(result, callback){ // Delete entry
            session
                .run(query_delete_video, {
                    video_id: req.params.video_id
                })
                .then(function(result) {
                    callback(null, 204, null);
                })
                .catch(function(err) {
                    callback(err, 500);
                });
        }
    ], function(err, code, result){
        // Close session
        session.close();

        // Send response
        if(err){
            console.error(colors.red(err));
            res.status(code).send(err.message);
        } else {
            res.status(code).send(result);
        }
    });
};
