var app = angular.module("ive");

// Relationship belongs_to edit controller
app.controller("belongsToEditController", function($scope, $rootScope, $routeParams, $translate, $location, config, $window, $authenticationService, $relationshipService) {

    /*************************************************
        FUNCTIONS
     *************************************************/

    /**
     * [changeTab description]
     * @param  {[type]} tab [description]
     * @return {[type]}     [description]
     */
    $scope.changeTab = function(tab){
        $scope.tab = tab;
    };

    /**
     * [redirect description]
     * @param  {[type]} path [description]
     * @return {[type]}      [description]
     */
    $scope.redirect = function(path){
        $location.url(path);
    };

    /**
     * [send description]
     * @return {[type]} [description]
     */
    $scope.send = function(){
        // Validate input
        if($scope.editRelationshipForm.$invalid) {
            // Update UI
        } else {
            $scope.changeTab(0);
            $relationshipService.edit('belongs_to', $scope.relationship.relationship_id, $scope.label, $scope.relationship)
            .then(function onSuccess(response) {
                $scope.relationship = response.data;
                $scope.redirect("/relationship/belongs_to/" + $scope.label + "/" + $scope.relationship.relationship_id);
            })
            .catch(function onError(response) {
                $window.alert(response.data);
            });
        }
    };


    /*************************************************
        INIT
     *************************************************/
    $scope.changeTab(0);
    $scope.label = $routeParams.label;

    $relationshipService.retrieve_by_id('belongs_to', $routeParams.relationship_id, $scope.label)
    .then(function onSuccess(response) {
        $scope.relationship = response.data;
        $scope.changeTab(1);
    })
    .catch(function onError(response) {
        $window.alert(response.data);
    });

});
