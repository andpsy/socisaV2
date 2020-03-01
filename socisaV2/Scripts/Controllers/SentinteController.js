'use strict';
//var spinner = new Spinner(opts);

app.controller('SentinteController',
    function ($scope, $http, $filter, $rootScope, $window, Upload) {
        $scope.model = {};
        $scope.model.ID_PROCES_STADIU = null;
        $scope.model.CurSentinta = {};
        $scope.model.Sentinte = [];
        $scope.newItem = {};
        $scope.editMode = 0;
        $scope.searchMode = 1;
        $scope.curIndex = -1;

        $scope.$watch('searchMode', function (newValue, oldValue) {
            $rootScope.searchMode = newValue;
            console.log('sen - search: ' + newValue)
        });

        $scope.$watch('editMode', function (newValue, oldValue) {
            $rootScope.editMode = newValue;
            console.log('sen - edit: ' + newValue)
        });

        $scope.EditMode = function (sentinta, index) {
            angular.copy(sentinta, $scope.model.CurSentinta);
            $scope.curIndex = index;
            $scope.editMode = 1;
        };

        $scope.AddMode = function () {
            $scope.model.CurSentinta = {};
            $scope.model.CurSentinta.ID_PROCES_STADIU = $scope.model.ID_PROCES_STADIU;
            $scope.editMode = 2;
        };

        $scope.Save = function () {
            spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            $http.post('/Sentinte/Edit', { Sentinta: $scope.model.CurSentinta })
                .then(function (response) {
                    if (response.data.InsertedId != null) {
                        $scope.model.CurSentinta.ID = response.data.InsertedId;
                        var tmpPS = angular.copy($scope.model.CurSentinta);
                        $scope.model.Sentinte.splice(0, 0, tmpPS);
                    }
                    else {
                        for (var i = 0; i < $scope.model.Sentinte.length; i++) {
                            if ($scope.model.CurSentinta.ID == $scope.model.Sentinte[i].ID) {
                                var tmpPS = angular.copy($scope.model.CurSentinta);
                                angular.copy(tmpPS, $scope.model.Sentinte[i]);
                                break;
                            }
                        }
                    }
                    //$scope.$apply();
                    $scope.$emit('sentintaChanged', true);
                    $scope.model.CurSentinta = {};
                    $scope.editMode = 0;
                    $rootScope.toogleOperationMessage(response.data);
                    spinner.stop();
                }, function (response) {
                    spinner.stop();
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.Cancel = function () {
            $scope.model.CurSentinta = {};
            $scope.editMode = 0;
        };
    });