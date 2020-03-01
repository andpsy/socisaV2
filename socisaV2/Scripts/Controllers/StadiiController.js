'use strict';

app.controller('StadiiController', function ($scope, $http, $filter, $rootScope, $compile, $interval, myService, ngDialog) {
    $scope.model = {};
    $scope.model.Stadii = [];
    $scope.model.CurStadiu = null;
    $scope.editMode = 0;

    $scope.EnterEditMode = function (stadiu) {
        $scope.model.CurStadiu = {};
        angular.copy(stadiu, $scope.model.CurStadiu);
        $scope.oldStadiu = angular.copy($scope.model.CurStadiu);
        $scope.editMode = 1;
        //$scope.$apply();
    };

    $scope.SaveEdit = function () {
        $scope.editMode = 2;
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);

        $http.post('/Stadii/Edit', { Stadiu: $scope.model.CurStadiu })
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.result = response.data;
                    $rootScope.toogleOperationMessage($scope.result);

                    if ($scope.result.Status) {
                        $scope.editMode = 0;
                        $scope.newStadiu = angular.copy($scope.model.CurStadiu);

                        if ($scope.result.InsertedId != null) {
                            $scope.updateType = 'insert';
                            $scope.model.CurStadiu.ID = $scope.result.InsertedId;

                            if ($scope.model.Stadii == undefined || $scope.model.Stadii == null) {
                                $scope.model.Stadii = [];
                            }
                            var tmpStadiu = angular.copy($scope.model.CurStadiu);
                            $scope.model.Stadii.push(tmpStadiu);
                        }
                        else {
                            $scope.updateType = 'update';
                            var index = $rootScope.getIndex($scope.model.Stadii, $scope.model.CurStadiu);
                            if (index != null)
                                angular.copy($scope.model.CurStadiu, $scope.model.Stadii[index]);                            
                        }
                    }
                    else {
                        $scope.editMode = 1;
                    }
                } else {
                    $scope.editMode = 1;
                }
                //spinner.stop();
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
                //spinner.stop();
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
            });
    };

    $scope.EnterDeleteMode = function (stadiu, msg) {
        $scope.newStadiu = null;
        $rootScope.confirmMessage = msg;
        ngDialog.openConfirm({
            template: 'confirmationDialogId',
            className: 'ngdialog-theme-default'
        }).then(
            function (value) {
                $scope.Delete(stadiu);
            },
            function (reason) {

            });
    };

    $scope.Delete = function (stadiu) {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
        $http.post('/Stadii/Delete', { id: stadiu.ID })
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.result = response.data;
                    $rootScope.toogleOperationMessage($scope.result);
                    if ($scope.result.Status) {
                        $scope.updateType = 'delete';
                        $scope.oldStadiu = angular.copy(stadiu);
                        var index = $rootScope.getIndex($scope.model.Stadii, stadiu);
                        if(index != null)
                            $scope.model.Stadii.splice(index, 1);
                    }
                }
                //spinner.stop();
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
                //spinner.stop();
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
            });
    };

    $scope.EnterAddMode = function () {
        $scope.model.CurStadiu = {};
        $scope.oldStadiu = null;
        $scope.editMode = 1;
    };

    $scope.CancelEdit = function () {
        $scope.updateType = null;
        $scope.model.CurStadiu = {};
        $scope.editMode = 0;
    };

});