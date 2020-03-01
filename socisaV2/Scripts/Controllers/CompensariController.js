'use strict';
app.controller('CompensariController',
    function ($scope, $http, $filter, $rootScope, $window, Upload, ngDialog) {
        $scope.model = {};
        $scope.model.DateCompensari = [];
        $scope.CurData = null;

        $scope.GetCompensariFromLog = function (data) {
            $scope.CurData = data;
        };

        $scope.TiparirePdf = function (_tip) {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#compensariMainDiv', spinner, ACTIVE_DIV_ID, true, false);
            $http.post('/Compensari/Print', { data: $scope.CurData, tip: _tip }, { responseType: 'arraybuffer' })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        try {
                            var blob = new Blob([response.data], { type: "application/pdf" });
                            var objectUrl = URL.createObjectURL(blob);
                            window.open(objectUrl);
                            //spinner.stop();
                            EnableDisableInputs('#compensariMainDiv', spinner, ACTIVE_DIV_ID, false, false)
                        } catch (e) { ; }
                    }
                    //spinner.stop();
                    EnableDisableInputs('#compensariMainDiv', spinner, ACTIVE_DIV_ID, false, false);
                }, function (response) {
                    //spinner.stop();
                    EnableDisableInputs('#compensariMainDiv', spinner, ACTIVE_DIV_ID, false, false);
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };
});