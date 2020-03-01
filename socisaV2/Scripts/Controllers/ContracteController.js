'use strict';

app.controller('ContracteController', function ($scope, $http, $filter, $rootScope, $compile, $interval, myService, ngDialog) {
    $scope.model = {};
    $scope.model.Contracte = [];
    $scope.model.CurContract = null;
    $scope.editMode = 0;
    $scope.searchMode = 1;

    $scope.$watch('searchMode', function (newValue, oldValue) {
        $rootScope.searchMode = newValue;
        console.log('contracte - search: ' + newValue)
    });

    $scope.$watch('editMode', function (newValue, oldValue) {
        $rootScope.editMode = newValue;
        console.log('contracte - edit: ' + newValue)
    });

    $scope.EnterEditMode = function (contract) {
        $scope.model.CurContract = {};
        angular.copy(contract, $scope.model.CurContract);
        $scope.oldContract = angular.copy($scope.model.CurContract);
        $scope.editMode = 1;
        //$scope.$apply();
    };

    $scope.SaveEdit = function () {
        $scope.editMode = 2;
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);

        $http.post('/Contracte/Edit', { Contract: $scope.model.CurContract })
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.result = response.data;
                    $rootScope.toogleOperationMessage($scope.result);

                    if ($scope.result.Status) {
                        $scope.editMode = 0;
                        $scope.newContract = angular.copy($scope.model.CurContract);

                        if ($scope.result.InsertedId != null) {
                            $scope.updateType = 'insert';
                            $scope.model.CurContract.ID = $scope.result.InsertedId;

                            if ($scope.model.Contracte == undefined || $scope.model.Contracte == null) {
                                $scope.model.Contracte = [];
                            }
                            var tmpContract = angular.copy($scope.model.CurContract);
                            $scope.model.Contracte.push(tmpContract);
                        }
                        else {
                            $scope.updateType = 'update';
                            var index = $rootScope.getIndex($scope.model.Contracte, $scope.model.CurContract);
                            if (index != null)
                                angular.copy($scope.model.CurContract, $scope.model.Contracte[index]);                            
                        }
                        if ($scope.$parent != null) { // este deschis ca dialog
                            //angular.copy($scope.model.Contracte, $scope.$parent.model.Contracte);
                            $scope.$parent.model.CurProces.Proces.ID_CONTRACT = $scope.model.CurContract.ID;
                            angular.copy($scope.model.CurContract, $scope.$parent.model.CurProces.Contract);
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

    $scope.EnterDeleteMode = function (contract, msg) {
        $scope.newContract = null;
        $rootScope.confirmMessage = msg;
        ngDialog.openConfirm({
            template: 'confirmationDialogId',
            className: 'ngdialog-theme-default'
        }).then(
            function (value) {
                $scope.Delete(contract);
            },
            function (reason) {

            });
    };

    $scope.Delete = function (contract) {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
        $http.post('/Contracte/Delete', { id: contract.ID })
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.result = response.data;
                    $rootScope.toogleOperationMessage($scope.result);
                    if ($scope.result.Status) {
                        $scope.updateType = 'delete';
                        $scope.oldContract = angular.copy(contract);
                        var index = $rootScope.getIndex($scope.model.Contracte, contract);
                        if(index != null)
                            $scope.model.Contracte.splice(index, 1);
                        
                        if ($scope.$parent != null) { // este deschis ca dialog
                            //angular.copy($scope.model.Contracte, $scope.$parent.model.Contracte);
                            $scope.$parent.model.CurProces.Proces.ID_CONTRACT = null;
                            $scope.$parent.model.CurProces.Contract = {};
                        }                        
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
        $scope.model.CurContract = {};
        $scope.oldContract = null;
        $scope.editMode = 1;
    };

    $scope.CancelEdit = function () {
        $scope.updateType = null;
        $scope.model.CurContract = {};
        $scope.editMode = 0;
    };

});