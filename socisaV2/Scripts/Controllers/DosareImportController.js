'use strict';
function toggleChecks(e) {
    $('.checkForImport').prop('checked', e.checked);
}
//var spinner = new Spinner(opts);

app.controller('DosareImportController',
function ($scope, $http, $filter, $rootScope, $window, Upload) {
    $scope.model = {};
    $scope.curDosar = [];
    $scope.sheet = "Sheet1";
    $scope.model.ImportDates = [];
    $scope.editMode = 0;

    $scope.generalQueryText = {};
    $scope.generalQueryText.$ = null;
    $scope.query = '1';
    $scope.propertyName = 'Dosar.NR_DOSAR_CASCO';
    $scope.dosareFiltrate = [];
    $scope.curIndex = -1;

    $scope.sortBy = function (propertyName) {
        $scope.reverse = ($scope.propertyName === propertyName) ? !$scope.reverse : false;
        $scope.propertyName = propertyName;
    };

    $scope.filterByColumns = function (item) {
        if (($scope.generalQueryText.$ == null || $scope.generalQueryText.$ == "") && ($scope.generalQueryText.DATA_SCA == null || $scope.generalQueryText.DATA_SCA == "") && ($scope.generalQueryText.DATA_EVENIMENT == null || $scope.generalQueryText.DATA_EVENIMENT == "")) return true;

        var toReturn1 = false;
        var toReturn2 = false;
        var toReturn3 = false;

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

        if ($scope.generalQueryText.DATA_SCA != null && $scope.generalQueryText.DATA_SCA != "") {
            str = $filter('date')(item[1].Dosar.DATA_SCA, $rootScope.DATE_FORMAT);
            if (str.indexOf($scope.generalQueryText.DATA_SCA) > -1) {
                //return true;
                toReturn2 = true;
            }
        }
        else {
            toReturn2 = true;
        }

        if ($scope.generalQueryText.DATA_EVENIMENT != null && $scope.generalQueryText.DATA_EVENIMENT != "") {
            str = $filter('date')(item[1].Dosar.DATA_EVENIMENT, $rootScope.DATE_FORMAT);
            if (str.indexOf($scope.generalQueryText.DATA_EVENIMENT) > -1) {
                //return true;
                toReturn3 = true;
            }
        }
        else {
            toReturn3 = true;
        }
        return toReturn1 && toReturn2 && toReturn3;
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
        EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, true, true);

        Upload.upload({
            url: '/Dosare/PostExcelFile',
            data: { file: file, sheet: $scope.sheet }
        }).then(function (response) {
            if (!response.data.Status && response.data.Message != null && response.data.Result == null) {
                $scope.result = response.data;
                $rootScope.toogleOperationMessage($scope.result);
            }
            else {
                $scope.model.ImportDosarView = response.data.Result;
                document.getElementById("IncarcareFisierExcel").style.display = document.getElementById("IncarcareFisierExcel").style.display == 'none' ? 'block' : 'none';
            }
            //spinner.stop();
            EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
        }, function (response) {
            alert(response.status + ' - ' + response.data);
            console.log('Error status: ' + response.status);
            //spinner.stop();
            EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
        }, function (evt) {
            var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            console.log('progress: ' + progressPercentage + '% ' + evt.config.data.file.name);
        });
    };

    $scope.toggleDiv = function () {
        document.getElementById("IncarcareFisierExcel").style.display = document.getElementById("IncarcareFisierExcel").style.display == 'none' ? 'block' : 'none';
        $scope.model.ImportDosarView = null;
    };

    $scope.GetDosareFromLog = function (date) {
        document.getElementById("IncarcareFisierExcel").style.display = 'none';
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, true, true);
        $http.post('/Dosare/GetDosareFromLog', { ImportDate: date })
            .then(function (response) {
                $scope.model.ImportDosarView = response.data.Result;
                //spinner.stop();
                EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                //spinner.stop();
                EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
                alert('Erroare: ' + response.status + ' - ' + response.data);
            });
    };

    $scope.itemHasError = function (item, err) {
        if (item[0] != null && item[0].Error != null && item[0].Error.length > 0) {
            for (var i = 0; i < item[0].Error.length; i++) {
                var errI = item[0].Error[i].ERROR_CODE;
                if (err == errI)
                    return true;
            }
        }
        return false;
    };

    $scope.setStyle = function (item) {
        var style = 'font-size:24px;';
        if (item[0] != null && item[0].Error != null && item[0].Error.length > 0) {
            var errType = item[0].Error[0].ERROR_TYPE;
            if (errType != 'Critical') {
                for (var i = 0; i < item[0].Error.length; i++) {
                    errType = item[0].Error[i].ERROR_TYPE;
                    if (errType == 'Critical') {
                        break;
                    }
                }
            }
            style += 'cursor:pointer;';
            style += ('color:' + (errType == 'Critical' ? 'red' : 'yellow'));
        }
        else {
            style += 'color:green;';
        }
        return style;
        //return item[0].Status ? 'color:green;font-size:24px;' : 'color:red;cursor:pointer;';
    };

    $scope.EditMode = function (dosar, index) {
        if (dosar[0].Status) return;
        angular.copy(dosar, $scope.curDosar);
        $scope.curIndex = index;
        $scope.editMode = 1;
    };

    $scope.Save = function (dosar) {
        $scope.curDosar[1].selected = true;
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, true, true);
        $http.post('/Dosare/MovePendingToOk', { dosar: $scope.curDosar[1] })
            .then(function (response) {
                $scope.result = response.data;
                $rootScope.toogleOperationMessage($scope.result);
                $scope.curDosar[1].selected = false;
                angular.copy($scope.curDosar, dosar);
                dosar[0].Status = response.data.Status;
                dosar[0].Message = response.data.Message;
                dosar[0].Error = response.data.Error;
                dosar[0].Result = response.data.Result;
                dosar[0].InsertedId = response.data.InsertedId;
                $scope.curDosar = [];
                $scope.editMode = 0;

                //spinner.stop();
                EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                //spinner.stop();
                EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
                alert('Erroare: ' + response.status + ' - ' + response.data);
            });
    };

    $scope.Cancel = function () {
        $scope.curDosar = [];
        $scope.editMode = 0;
    };

    $scope.importDocumente = function () {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, true, true);
        $http.post('/Dosare/ImportDocumente', { cale: $('#caleFisiere').val })
            .then(function (response) {
                $scope.result = response.data;
                $rootScope.toogleOperationMessage($scope.result);

                angular.copy($scope.curDosar, dosar);
                dosar[0].Status = response.data.Status;
                dosar[0].Message = response.data.Message;
                dosar[0].Errors = response.data.Errors;
                dosar[0].InsertedId = response.data.InsertedId;
                $scope.curDosar = [];
                $scope.editMode = 0;

                //spinner.stop();
                EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                //spinner.stop();
                EnableDisableInputs('#dosareImportMainDiv', spinner, ACTIVE_DIV_ID, false, true);
                alert('Erroare: ' + response.status + ' - ' + response.data);
            });
    };

    $scope.setCurAsigRca = function () {
        for (var i = 0; i < $scope.model.SocietatiRCA.length; i++) {
            if ($scope.model.SocietatiRCA[i].ID == $scope.curDosar[1].Dosar.ID_SOCIETATE_RCA) {
                angular.copy($scope.model.SocietatiRCA[i], $scope.curDosar[1].SocietateRca);
                break;
            }
        }
    };
});