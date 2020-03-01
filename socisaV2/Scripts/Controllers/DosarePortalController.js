'use strict';
function toggleChecks(e) {
    $('.checkForImport').prop('checked', e.checked);
}
//var spinner = new Spinner(opts);

app.controller('DosarePortalController',
    function ($scope, $http, $filter, $rootScope, $window, ngDialog) {
        $scope.model = {};
        $scope.curSedintaPortal = {};
        $scope.newItem = {};
        $scope.model.DosarePortal = [];
        $scope.editMode = 0;
        $scope.model.SedintePortal = [];

        $scope.generalQueryText = {};
        $scope.generalQueryText.$ = null;
        $scope.query = '1';
        $scope.propertyName = 'DATA';
        $scope.sedintePortalFiltrate = [];
        $scope.curIndex = -1;
        $scope.XZile = true;
        $scope.Depasite = true;

        $scope.sortBy = function (propertyName) {
            $scope.reverse = ($scope.propertyName === propertyName) ? !$scope.reverse : false;
            $scope.propertyName = propertyName;
        };

        $scope.filterByColumns = function (item) {
            if ($scope.generalQueryText.$ == null || $scope.generalQueryText.$ == "") return true;

            var toReturn1 = false;

            if ($scope.generalQueryText.$ != null && $scope.generalQueryText.$ != "") {
                for (var key_1 in item) { // sub objects (Dosar, AsiguratCasco, AutoCasco etc...)
                    try {
                        var str = item[key_1];

                        if (str.toString().toLowerCase().indexOf($scope.generalQueryText.$.toLowerCase()) > -1) {
                            //return true;
                            toReturn1 = true;
                            break;
                        }
                    } catch (e) { ; }
                    if (toReturn1) break;
                }
            }
            else {
                toReturn1 = true;
            }

            return toReturn1;
        };

        $scope.applyFilter = function (element) {
            var d = new Date();
            var d1 = new Date(d.getFullYear(), d.getMonth(), d.getDate());
            var strData = element.DATA_SEDINTA.split('.');
            var d2 = new Date(strData[2], strData[1] - 1, strData[0]);
            return ($scope.XZile == true && d2.getTime() >= d1.getTime()) || ($scope.Depasite == true && d2.getTime() < d1.getTime());            
        };

        $scope.IsDepasit = function (item) {
            var d = new Date();
            var d1 = new Date(d.getFullYear(), d.getMonth(), d.getDate());
            var strData = item.DATA_SEDINTA.split('.');
            var d2 = new Date(strData[2], strData[1] - 1, strData[0]);
            return d2.getTime() < d1.getTime();
        };

        $scope.EditMode = function (sedintaPortal, index) {
            angular.copy(sedintaPortal, $scope.curSedintaPortal);
            $scope.curIndex = index;
            $scope.editMode = 1;
        };

        $scope.AddMode = function () {
            angular.copy($scope.newItem, $scope.curSedintaPortal);
            //$scope.curIndex = index;
            $scope.editMode = 2;
        };

        $scope.Save = function () {
            spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            $http.post('/SedintePortal/Edit', { sedintaPortal: $scope.curSedintaPortal })
                .then(function (response) {
                    if (response.data.InsertedId != null) {
                        $scope.curSedintaPortal.ID = response.data.InsertedId;
                        $scope.model.SedintePortal.push($scope.curSedintaPortal);
                    }
                    else {
                        for (var i = 0; i < $scope.model.SedintePortal.length; i++) {
                            if ($scope.curSedintaPortal.ID == $scope.model.SedintePortal[i].ID) {
                                angular.copy($scope.curSedintaPortal, $scope.model.SedintePortal[i]);
                                break;
                            }
                        }
                    }
                    $scope.curSedintaPortal = {};
                    $scope.editMode = 0;
                    $rootScope.toogleOperationMessage(response.data);
                    spinner.stop();
                }, function (response) {
                    spinner.stop();
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.Cancel = function () {
            $scope.curSedintaPortal = {};
            $scope.editMode = 0;
        };

        $scope.ImportMode = function (item, index) {
            EnableDisableInputs('#mainSedintePortalDashboard', spinner, ACTIVE_DIV_ID, true, true);
            $scope.curIndex = index;
            $.ajax({
                async: true,
                type: 'GET',
                url: '/DosarePortal/ImportSedintaPortalIndex/' + item.ID,
                dataType: 'html'
            }).done(function (data) {
                EnableDisableInputs('#mainSedintePortalDashboard', spinner, ACTIVE_DIV_ID, false, true);

                ngDialog.openConfirm({
                    template: data,
                    plain: true,
                    className: 'ngdialog-theme-default custom-width',
                    //controller: 'ProceseStadiiController',
                    width: 800,
                    scope: $scope
                }).then(
                    function (value) {
                        //alert('succes');
                        $scope.ImportSedintaPortal(value);
                    },
                    function (reason) {
                        //alert(reason);
                    });
            }).fail(function (jqXHR, textStatus) {
                alert(textStatus);
                EnableDisableInputs('#mainSedintePortalDashboard', spinner, ACTIVE_DIV_ID, false, true);
            });
        };

        $scope.ImportSedintaPortal = function (value) {
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            var id = $scope.model.SedintePortal[$scope.curIndex].ID;
            $http.post('/DosarePortal/ImportSedintaPortal', { IdSedintaPortal: id, ProcesStadiu: value.ProcesStadiuExtended.ProcesStadiu, Sentinta: value.ProcesStadiuExtended.Sentinta })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        $scope.result = response.data;
                        $rootScope.toogleOperationMessage($scope.result);
                        //alert('succes');
                        $scope.model.SedintePortal.splice($scope.curIndex, 1);
                        $scope.curIndex = -1;
                        EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                    }
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    $scope.curIndex = -1;
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                });
        };
    });
