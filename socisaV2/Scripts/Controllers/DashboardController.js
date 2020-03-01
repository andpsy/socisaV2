'use strict';

app.controller('DashboardController', function ($scope, $http, $filter, $rootScope, $compile, $interval, myService, ngDialog) {
    $scope.model = {};
    //$scope.labels = ["Download Sales", "In-Store Sales", "Mail-Order Sales"];
    //$scope.data = [300, 500, 100];
    console.log('dashboard');

    $scope.ExportToExcel = function (_objectType, _sort, _order, _filter, _limit) {
        var jDivId = "#" + _objectType;
        EnableDisableInputs(jDivId, spinnerSmall, _objectType, true, false);

        var url = "";
        if (_objectType.indexOf('DOSARE') > -1) {
            url = '/Dashboard/ExportDosareToExcel';
        }
        if (_objectType.indexOf('TERMENE') > -1) {
            url = '/Dashboard/ExportTermeneToExcel';
        }
        if (_objectType.indexOf('PROCESE') > -1) {
            url = '/Dashboard/ExportProceseToExcel';
        }

        var jsonFilter = null;
        if (_filter != null) {
            jsonFilter = {};
            jsonFilter.filterName = _filter[0];
            jsonFilter.filterKey = _filter[1];
            jsonFilter.args = _filter[2];
        }

        $http.post(url, { _sort: _sort, _order: _order, _filter: JSON.stringify(jsonFilter), _limit: _limit }, { responseType: 'arraybuffer' })
            .then(function (response2) {
                if (response2 != 'null' && response2 != null && response2.data != null) {
                    var blob = new Blob([response2.data], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                    var objectUrl = URL.createObjectURL(blob);
                    window.open(objectUrl);
                    EnableDisableInputs(jDivId, spinnerSmall, _objectType, false, false);
                }
            }, function (response2) {
                EnableDisableInputs(jDivId, spinnerSmall, _objectType, false, false);
                alert('Erroare: ' + response2.status + ' - ' + response2.data);
            });
    };

    /*
    $scope.ExportDosareToExcel = function (_sort, _order, _filter, _limit) {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        //EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, true, false)

        $http.post('/Dashboard/ExportDosareToExcel', { _sort: _sort, _order: _order, _filter: _filter, _limit: _limit }, { responseType: 'arraybuffer' })
            .then(function (response2) {
            if (response2 != 'null' && response2 != null && response2.data != null) {
                var blob = new Blob([response2.data], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                var objectUrl = URL.createObjectURL(blob);
                window.open(objectUrl);
                //spinner.stop();
                //EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false)
            }
        }, function (response2) {
            //spinner.stop();
            //EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false)
            alert('Erroare: ' + response2.status + ' - ' + response2.data);
        });
    };
    */
    $scope.FilterInInterface = function (_tip_export) {
        alert("Aceasta functionalitate nu este inca implementata!");
    };

    $scope.$on('refreshDashboardBroadcastEvent', function (event, data) {
        $http.get('/Dashboard/Refresh', { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } })
            .then(function (response) {
                if (response != 'null' && response != null) {
                    $scope.model = response.data;
                }
                else {
                }
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
            });               
    });
});