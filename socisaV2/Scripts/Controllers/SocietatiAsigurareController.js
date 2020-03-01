'use strict';
function toggleChecks(e) {
    $('.checkForImport').prop('checked', e.checked);
}
//var spinner = new Spinner(opts);

app.controller('SocietatiAsigurareController',
    function ($scope, $http, $filter, $rootScope, $window, Upload) {
        $scope.model = {};
        $scope.curSocietate = {};
        $scope.newItem = {};
        $scope.model.SocietatiAsigurare = [];
        $scope.editMode = 0;

        $scope.generalQueryText = {};
        $scope.generalQueryText.$ = null;
        $scope.query = '1';
        $scope.propertyName = 'DENUMIRE';
        $scope.societatiFiltrate = [];
        $scope.curIndex = -1;

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
            spinner.spin(document.getElementById(ACTIVE_DIV_ID));

            Upload.upload({
                url: '/Dosare/PostExcelFile',
                data: { file: file }
            }).then(function (response) {
                if (!response.data.Status && response.data.Message != null && response.data.Result == null) {
                    $scope.result = response.data;
                    $scope.showMessage = true;
                }
                else {
                    $scope.model.ImportDosarView = response.data.Result;
                    document.getElementById("IncarcareFisierExcel").style.display = document.getElementById("IncarcareFisierExcel").style.display == 'none' ? 'block' : 'none';
                }
                spinner.stop();
            }, function (response) {
                alert(response.status + ' - ' + response.data);
                console.log('Error status: ' + response.status);
                spinner.stop();
            }, function (evt) {
                var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
                console.log('progress: ' + progressPercentage + '% ' + evt.config.data.file.name);
            });
        };

        $scope.toggleDiv = function () {
            document.getElementById("IncarcareFisierExcel").style.display = document.getElementById("IncarcareFisierExcel").style.display == 'none' ? 'block' : 'none';
            $scope.model.ImportDosarView = null;
        };

        $scope.EditMode = function (societate, index) {
            angular.copy(societate, $scope.curSocietate);
            $scope.curIndex = index;
            $scope.editMode = 1;
        };

        $scope.AddMode = function () {
            angular.copy($scope.newItem, $scope.curSocietate);
            //$scope.curIndex = index;
            $scope.editMode = 2;
        };

        $scope.Save = function () {
            spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            $http.post('/SocietatiAsigurare/Edit', { societate: $scope.curSocietate })
                .then(function (response) {
                    if (response.data.InsertedId != null) {
                        $scope.curSocietate.ID = response.data.InsertedId;
                        $scope.model.SocietatiAsigurare.push($scope.curSocietate);
                    }
                    else {
                        //angular.copy($scope.curSocietate, $scope.model.SocietatiAsigurare[$scope.curIndex]);
                        for (var i = 0; i < $scope.model.SocietatiAsigurare.length; i++) {
                            if ($scope.curSocietate.ID == $scope.model.SocietatiAsigurare[i].ID) {
                                angular.copy($scope.curSocietate, $scope.model.SocietatiAsigurare[i]);
                                break;
                            }
                        }
                    }
                    $scope.curSocietate = {};
                    $scope.editMode = 0;
                    $rootScope.toogleOperationMessage(response.data);
                    spinner.stop();
                }, function (response) {
                    spinner.stop();
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.Cancel = function () {
            $scope.curSocietate = {};
            $scope.editMode = 0;
        };

        $scope.confirmEmail = function (item) {
            spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            $http.post('/SocietatiAsigurare/ConfirmEmailAddress', { societate: item })
                .then(function (response) {
                    $rootScope.toogleOperationMessage(response.data);
                    spinner.stop();
                }, function (response) {
                    spinner.stop();
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.checkHostName = function ($event) {
            $scope.myForm[$event.currentTarget.name].$setValidity("invalidHost", true);
            if (!isNullOrEmptyJson($scope.myForm[$event.currentTarget.name].$error)) return; //verificam hostul doar daca e adresa valida

            spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            $http.post('/SocietatiAsigurare/CheckHostName', { emailAddress: $event.currentTarget.value })
                .then(function (response) {
                    //$rootScope.toogleOperationMessage(response.data);
                    $scope.myForm[$event.currentTarget.name].$setValidity("invalidHost", response.data);
                    spinner.stop();
                }, function (response) {
                    $scope.myForm[$event.currentTarget.name].$setValidity("invalidHost", true);
                    spinner.stop();
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.setRequiredError = function (type, input_name) {
            try {
                switch (type) {
                    case "required":
                        return this.myForm[input_name].$error.required;
                    case "email":
                        return this.myForm[input_name].$error.email;
                    case "invalidHost":
                        return this.myForm[input_name].$error.invalidHost;
                }
            } catch (e) {
                return null;
            }
        }
    });