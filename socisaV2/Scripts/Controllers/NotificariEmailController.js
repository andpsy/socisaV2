'use strict';
//var spinner = new Spinner(opts);

app.controller('NotificariEmailController',
    function ($scope, $http, $filter, $rootScope, $window, ngDialog) {
        $scope.model = {};
        $scope.model.EmailNotifications = null;
        $scope.curItem = {};

        $scope.timeStampFilter = $filter('date')(new Date(), $rootScope.DATE_FORMAT);

        $scope.generalQueryText = {};
        $scope.generalQueryText.$ = null;
        $scope.queryText = {};
        $scope.propertyName = 'MESSAGE_ID';
        $scope.notificariEmailFiltrate = null;

        $scope.sortBy = function (propertyName) {
            $scope.reverse = ($scope.propertyName === propertyName) ? !$scope.reverse : false;
            $scope.propertyName = propertyName;
        };

        $scope.recursiveSearch = function (item) {
            var toReturn1 = false;
            for (var key_1 in item) {
                try {
                    if (item.hasOwnProperty(key_1))
                    {
                        var str = item[key_1];
                        if (typeof str == 'object') {
                            toReturn1 = $scope.recursiveSearch(str);
                            if (toReturn1) { return true; }
                        }
                        else {
                            if (str.toString().toLowerCase().indexOf($scope.generalQueryText.$.toLowerCase()) > -1) {
                                return true;
                            }
                        }
                    }
                } catch (e) { ; }
            }
            return toReturn1;
        };

        $scope.$watch('generalQueryText', function (newValue, oldValue) {
            $scope.applyFilter();
        });

        $scope.$watch('generalQueryText.$', function (newValue, oldValue) {
            $scope.applyFilter();
        });

        $scope.$watchCollection('model.EmailNotifications', function (newValue, oldValue) {
            $scope.applyFilter();
        });

        $scope.$watchCollection('queryText', function (newValue, oldValue) {
            $scope.applyFilter();
        });

        $scope.applyFilter = function () {
            $scope.notificariEmailFiltrate = $filter('filter')($scope.model.EmailNotifications, $scope.filterByColumns);
        };

        $scope.recursiveSearchByColumns = function (item) {
            var toReturn2 = false;
            for (var key_1 in item) {
                try {
                    if (item.hasOwnProperty(key_1)) {
                        var str = item[key_1];
                        if (typeof str == 'object') {
                            toReturn2 = $scope.recursiveSearchByColumns(str);
                            if (toReturn2) { return true; }
                        }
                        else {
                            for (var key_2 in $scope.queryText) {
                                if (key_1.indexOf(key_2) > -1) {
                                    var qText = $scope.queryText[key_2];
                                    if (str.toString().toLowerCase().indexOf(qText.toLowerCase()) > -1) {
                                        return true;
                                    }
                                }
                            }
                        }
                    }
                } catch (e) { ; }
            }
            return toReturn2;
        }

        $scope.filterByColumns = function (item) {
            var toReturn1 = false;
            var toReturn2 = false;

            if (isNullOrEmptyJson($scope.generalQueryText) || $scope.generalQueryText.$ == null) {
                toReturn1 = true;
            } else {
                toReturn1 = $scope.recursiveSearch(item);
            }

            if (isNullOrEmptyJson($scope.queryText)) {
                toReturn2 = true;
            } else {
                toReturn2 = $scope.recursiveSearchByColumns(item);
            }

            return toReturn1 && toReturn2;
        };

        $scope.filterByTimestamp = function () {
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            $http.post('/NotificariEmail/Filter', { _data: $scope.timeStampFilter })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        if (!response.data.Status)
                            $scope.model.EmailNotifications = JSON.parse(response.data).EmailNotifications;
                        else {
                            $scope.result = response.data;
                            $rootScope.toogleOperationMessage($scope.result);
                        }
                    }
                    else {
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                });
        }

        $scope.updateCheckDates = function () {
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            angular.copy({}, $scope.curItem);
            $http.post('/NotificariEmail/UpdateCheckDates', { _timestamp: $scope.timeStampFilter })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        $scope.result = response.data;
                        $rootScope.toogleOperationMessage($scope.result);
                        if ($scope.result.Status) {
                            $scope.filterByTimestamp();
                        }
                    }
                    else {
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                });
        };

        $scope.setCurItem = function (item) {
            angular.copy(item, $scope.curItem);
        };
    });
