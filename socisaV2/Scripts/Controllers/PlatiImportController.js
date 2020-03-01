'use strict';
function toggleChecks(e) {
    $('.checkForImport').prop('checked', e.checked);
}
//var spinner = new Spinner(opts);

app.controller('PlatiImportController',
function ($scope, $http, $filter, $rootScope, $window, Upload) {
    $scope.model = {};
    $scope.curPlata = [];
    $scope.model.ImportDates = [];
    $scope.editMode = 0;

    $scope.generalQueryText = {};
    $scope.generalQueryText.$ = null;
    $scope.query = '1';
    $scope.propertyName = 'Plata.NR_DOCUMENT';
    $scope.platiFiltrate = [];
    $scope.curIndex = -1;

    $scope.sortBy = function (propertyName) {
        $scope.reverse = ($scope.propertyName === propertyName) ? !$scope.reverse : false;
        $scope.propertyName = propertyName;
    };

    $scope.filterByColumns = function (item) {
        if (($scope.generalQueryText.$ == null || $scope.generalQueryText.$ == "") && ($scope.generalQueryText.DATA_DOCUMENT == null || $scope.generalQueryText.DATA_DOCUMENT == "")) return true;

        var toReturn1 = false;
        var toReturn2 = false;

        if ($scope.generalQueryText.$ != null && $scope.generalQueryText.$ != "") {
            for (var key_1 in item[1]) { // sub objects (Dosar, AsiguratCasco, AutoCasco etc...)
                var subItem = item[1][key_1];
                for (var key_2 in subItem) {
                    try {
                        var str = subItem[key_2];
                        if (key_2.indexOf("DATA_") > -1) {
                            str = $filter('date')(str, $rootScope.DATE_FORMAT);
                        }
                        if (str.toString().toLowerCase().indexOf($scope.generalQueryText.$.toLowerCase()) > -1) {
                            //return true;
                            toReturn1 = true;
                            break;
                        }
                    } catch (e) { ; }
                }
                if (toReturn1) break;
            }
        }
        else {
            toReturn1 = true;
        }

        if ($scope.generalQueryText.DATA_DOCUMENT != null && $scope.generalQueryText.DATA_DOCUMENT != "") {
            str = $filter('date')(item[1].Plata.DATA_DOCUMENT, $rootScope.DATE_FORMAT);
            if (str.indexOf($scope.generalQueryText.DATA_DOCUMENT) > -1) {
                //return true;
                toReturn2 = true;
            }
        }
        else {
            toReturn2 = true;
        }
        return toReturn1 && toReturn2;
    };

    $scope.applyFilter = function (element) {
        switch ($scope.query) {
            case '1':
                return true;
                break;
            case '2':
                return element[0].Status == false;
                break;
            case '3':
                return element[0].Status == true;
                break;
        }
    };

    $scope.upload = function (file) {
        if (file == null || !Upload.isFile(file)) return;
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        EnableDisableInputs('#platiImportMainDiv', spinner, ACTIVE_DIV_ID, true, true);

        Upload.upload({
            url: '/Plati/PostExcelFile',
            data: { file: file }
        }).then(function (response) {
            if (!response.data.Status && response.data.Message != null && response.data.Result == null) {
                $scope.result = response.data;
                $rootScope.toogleOperationMessage($scope.result);
            }
            else {
                $scope.model.ImportPlataView = response.data.Result;
                document.getElementById("IncarcareFisierExcel").style.display = document.getElementById("IncarcareFisierExcel").style.display == 'none' ? 'block' : 'none';
            }
            //spinner.stop();
            EnableDisableInputs('#platiImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
        }, function (response) {
            alert(response.status + ' - ' + response.data);
            console.log('Error status: ' + response.status);
            //spinner.stop();
            EnableDisableInputs('#platiImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
        }, function (evt) {
            var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            console.log('progress: ' + progressPercentage + '% ' + evt.config.data.file.name);
        });
    };

    $scope.toggleDiv = function () {
        document.getElementById("IncarcareFisierExcel").style.display = document.getElementById("IncarcareFisierExcel").style.display == 'none' ? 'block' : 'none';
        $scope.model.ImportPlataView = null;
    };

    $scope.GetPlatiFromLog = function (date) {
        document.getElementById("IncarcareFisierExcel").style.display = 'none';
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        EnableDisableInputs('#platiImportMainDiv', spinner, ACTIVE_DIV_ID, true, true);
        $http.post('/Plati/GetPlatiFromLog', { ImportDate: date })
            .then(function (response) {
                $scope.model.ImportPlataView = response.data.Result;
                //spinner.stop();
                EnableDisableInputs('#platiImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                //spinner.stop();
                EnableDisableInputs('#platiImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
                alert('Erroare: ' + response.status + ' - ' + response.data);
            });
    };

    $scope.EditMode = function (plata, index) {
        if (plata[0].Status) return;
        angular.copy(plata, $scope.curPlata);
        $scope.curIndex = index;
        $scope.editMode = 1;
    };

    $scope.Save = function (plata) {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        EnableDisableInputs('#platiImportMainDiv', spinner, ACTIVE_DIV_ID, true, true);
        $http.post('/Plati/MovePendingToOk', { plata: $scope.curPlata[1] })
            .then(function (response) {
                $scope.result = response.data;
                $rootScope.toogleOperationMessage($scope.result);

                angular.copy($scope.curPlata, plata);
                plata[0].Status = response.data.Status;
                plata[0].Message = response.data.Message;
                plata[0].Errors = response.data.Errors;
                plata[0].InsertedId = response.data.InsertedId;
                $scope.curPlata = [];
                $scope.editMode = 0;

                //spinner.stop();
                EnableDisableInputs('#platiImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                //spinner.stop();
                EnableDisableInputs('#platiImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
                alert('Erroare: ' + response.status + ' - ' + response.data);
            });
    };

    $scope.Cancel = function () {
        $scope.curPlata = [];
        $scope.editMode = 0;
    };
});