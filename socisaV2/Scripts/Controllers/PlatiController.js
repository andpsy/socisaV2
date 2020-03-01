'use strict';

app.controller('PlatiController', function ($scope, $http, $filter, $rootScope, $compile, $interval, myService, ngDialog) {
    $scope.model = {};
    $scope.model.Plati = [];
    $scope.model.TipuriPlati = [];
    $scope.model.CurPlata = null;
    $scope.model.ID_DOSAR = null;
    $scope.editMode = 0;
    $scope.searchMode = 1;
    $scope.Totaluri = {};

    $rootScope.$watch('ID_DOSAR', function (newValue, oldValue) {
        if (newValue != null && newValue != undefined && $rootScope.activeTab.Value == 'plati') {
            $scope.model = {};
            $scope.model.CurPlata = null;
            $scope.model.Plati = [];
            $scope.model.TipuriPlati = [];
            $scope.model.ID_DOSAR = newValue;
            $scope.ShowPlati(newValue);
        }
    });

    $rootScope.$watch('activeTab.Value', function (newValue, oldValue) {
        if (newValue == 'plati' && $rootScope.ID_DOSAR != null && $rootScope.ID_DOSAR != undefined && $scope.lastActiveIdDosar != $rootScope.ID_DOSAR) {
            $scope.model = {};
            $scope.model.TipuriPlati = [];
            $scope.model.Plati = [];
            $scope.model.CurPlata = null;
            $scope.model.ID_DOSAR = $rootScope.ID_DOSAR;
            $scope.ShowPlati($rootScope.ID_DOSAR);
        }
    });

    $scope.$watch('searchMode', function (newValue, oldValue) {
        $rootScope.searchMode = newValue;
        console.log('plati - search: ' + newValue)
    });

    $scope.$watch('editMode', function (newValue, oldValue) {
        $rootScope.editMode = newValue;
        console.log('plati - edit: ' + newValue)
    });

    $scope.getTipPlata = function (id_tip_plata) {
        var toReturn = "";
        for (var i = 0; i < $scope.model.TipuriPlati.length; i++) {
            if (id_tip_plata == $scope.model.TipuriPlati[i].ID) {
                toReturn = $scope.model.TipuriPlati[i].DENUMIRE;
                break;
            }
        }
        return toReturn;
    }

    $scope.ShowPlati = function (id_dosar) {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, true, true);

        console.log('showplati');
        myService.getlist('GET', '/Plati/Details/' + id_dosar, null)
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {                    
                    $scope.model = JSON.parse(response.data);
                    $scope.model.CurPlata = {};
                    $scope.calculateRestDePlata();
                }
                else {
                    $scope.model.Plati = [];
                    $scope.model.CurPlata = {};
                }
                //spinner.stop();
                EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);

            }, function (response) {
                //spinner.stop();
                EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);

                alert('Erroare: ' + response.status + ' - ' + response.data);
            });
    };

    $scope.EnterEditMode = function (plata) {
        angular.copy(plata, $scope.model.CurPlata);
        $scope.oldPlata = angular.copy($scope.model.CurPlata);
        $scope.editMode = 1;
    };

    $scope.SaveEdit = function () {
        $scope.editMode = 2;
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);

        $http.post('/Plati/Edit', { Plata: $scope.model.CurPlata })
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.result = response.data;
                    $rootScope.toogleOperationMessage($scope.result);

                    if ($scope.result.Status) {
                        $scope.editMode = 0;
                        $scope.newPlata = angular.copy($scope.model.CurPlata);

                        if ($scope.result.InsertedId != null) {
                            $scope.updateType = 'insert';
                            $scope.model.CurPlata.ID = $scope.result.InsertedId;

                            if ($scope.model.Plati == undefined || $scope.model.Plati == null) {
                                $scope.model.Plati = [];
                            }
                            var tmpPlata = angular.copy($scope.model.CurPlata);
                            $scope.model.Plati.push(tmpPlata);
                            $scope.$emit('refreshCounterEmitEvent', { object: 'plati', value: 1 });
                            $scope.$emit('refreshDashboardEmitEvent', { object: 'plati', value: 1 });
                        }
                        else {
                            $scope.updateType = 'update';
                            var index = $rootScope.getIndex($scope.model.Plati, $scope.model.CurPlata);
                            if (index != null)
                                angular.copy($scope.model.CurPlata, $scope.model.Plati[index]);                            
                        }
                        $scope.calculateRestDePlata();
                        $scope.$emit('paymentUpdateEmitEvent', { updateType: $scope.updateType, oldPlata: $scope.oldPlata, newPlata: $scope.newPlata });
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

    $scope.EnterDeleteMode = function (plata, msg) {
        $scope.newPlata = null;
        $rootScope.confirmMessage = msg;
        ngDialog.openConfirm({
            template: 'confirmationDialogId',
            className: 'ngdialog-theme-default'
        }).then(
            function (value) {
                $scope.Delete(plata);
            },
            function (reason) {

            });
    };

    $scope.Delete = function (plata) {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
        $http.post('/Plati/Delete', { id: plata.ID })
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.result = response.data;
                    $rootScope.toogleOperationMessage($scope.result);
                    if ($scope.result.Status) {
                        $scope.updateType = 'delete';
                        $scope.oldPlata = angular.copy(plata);
                        var index = $rootScope.getIndex($scope.model.Plati, plata);
                        if(index != null)
                            $scope.model.Plati.splice(index, 1);

                        $scope.$emit('refreshCounterEmitEvent', { object: 'plati', value: -1 });
                        $scope.$emit('refreshDashboardEmitEvent', { object: 'plati', value: -1 });

                        $scope.calculateRestDePlata();
                        $scope.$emit('paymentUpdateEmitEvent', { updateType: $scope.updateType, oldPlata: $scope.oldPlata, newPlata: $scope.newPlata });
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

    $scope.calculateRestDePlata = function () {
        var sumaPlati = 0;
        for (var i = 0; i < $scope.model.Plati.length; i++) {
            // TO DDO: sa cautam doar platile directe
            sumaPlati += parseFloat($scope.model.Plati[i].SUMA);
        }
        //return $rootScope.VALOARE_REGRES - sumaPlati;
        $scope.Totaluri.TotalPlati = sumaPlati;
        $scope.Totaluri.RestDePlata = $rootScope.VALOARE_REGRES - sumaPlati;
    };

    /*
    $scope.getIndex = function (plata) {
        try {
            for (var i = 0; i < $scope.model.Plati.length; i++) {
                if (plata.ID == $scope.model.Plati[i].ID) {
                    return i;
                }
            }
            return null;
        } catch(err){
            return null;
        }
    }
    */

    $scope.EnterAddMode = function () {
        $scope.model.CurPlata = {};
        $scope.model.CurPlata.ID_DOSAR = $rootScope.ID_DOSAR;
        $scope.oldPlata = null;
        $scope.editMode = 1;
    };

    $scope.CancelEdit = function () {
        $scope.updateType = null;
        $scope.model.CurPlata = {};
        $scope.editMode = 0;
    };

});