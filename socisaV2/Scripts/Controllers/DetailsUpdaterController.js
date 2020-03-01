app.controller('DetailsUpdaterController', function ($rootScope, $scope, $http, ngDialog) {
    $scope.model = {};
    //$scope.objectType = "";
    $scope.editMode = 0;
    $scope.searchMode = 1;

    $scope.$on('refreshBroadcastEvent', function (event, data) {
        $scope.objectType = data.objectType;
        $scope.editMode = data.editMode;
    });

    $scope.$watch('searchMode', function (newValue, oldValue) {
        $rootScope.searchMode = newValue;
    });

    $scope.$watch('editMode', function (newValue, oldValue) {
        $rootScope.editMode = newValue;
    });

    $scope.Save = function () {
        var httpRequest = null;
        switch ($scope.objectType) {
            case "AsiguratCasco":
            case "AsiguratRca":
                httpRequest = $http.post('/Asigurati/Edit', { asigurat: $scope.model });
                break;
            case "AutoCasco":
            case "AutoRca":
                httpRequest = $http.post('/Auto/Edit', { auto: $scope.model });
                break;
            case "SocietateCasco":
            case "SocietateRca":
                httpRequest = $http.post('/SocietatiAsigurare/Edit', { societate: $scope.model });
                break;
            case "Intervenient":
                httpRequest = $http.post('/Intervenienti/Edit', { intervenient: $scope.model });
                break;
            case "TipProces":
                httpRequest = $http.post('/TipuriProcese/Edit', { TipProces: $scope.model });
                break;
            case "Instanta":
                httpRequest = $http.post('/Instante/Edit', { Instanta: $scope.model });
                break;
            case "Complet":
                httpRequest = $http.post('/Complete/Edit', { Complet: $scope.model });
                break;
            case "Reclamant":
            case "Parat":
            case "Tert":
                httpRequest = $http.post('/Parti/Edit', { Parte: $scope.model });
                break;
        }
        EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
        
        httpRequest.then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.result = response.data;
                    if ($scope.result.InsertedId != null) {
                        $scope.model.ID = $scope.result.InsertedId;
                    }
                    $rootScope.toogleOperationMessage($scope.result);

                    if ($scope.result.Status) {
                        $scope.$emit('refreshEmitEvent', { objectType: $scope.objectType, object: $scope.model, operation: $scope.result.InsertedId != null ? "insert" : "update" });
                    }
                    else {

                    }
                } else {

                }
                //spinner.stop();
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
                //spinner.stop();
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
            });
        $('#popover' + $scope.objectType).popover('hide');
    };

    $scope.Cancel = function () {
        //alert('Cancel');
        $('#popover' + $scope.objectType).popover('hide');
    };
});