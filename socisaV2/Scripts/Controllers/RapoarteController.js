app.controller('RapoarteController', function ($scope, $http, $filter, $rootScope, $window, $timeout, $compile, ngDialog) {
    $scope.model = {};
    $scope.model.Actions = [];
    $scope.FilterObject = {};

    $scope.ShowRaportSelector = function (action) {
        EnableDisableInputs('#rapoarteMainContent', spinner, ACTIVE_DIV_ID, true, true);
            $.ajax({
                async: false,
                type: 'GET',
                url: '/Rapoarte/SelectorLoader/' + action.NAME,
                dataType: 'html'
            }).done(function (data) {
                var htmlContent = $compile(data)($scope);
                $('#raportSelectionContent').html(htmlContent);
                EnableDisableInputs('#rapoarteMainContent', spinner, ACTIVE_DIV_ID, false, true);
            }).fail(function (jqXHR, textStatus) {
                EnableDisableInputs('#rapoarteMainContent', spinner, ACTIVE_DIV_ID, false, true);
                alert(textStatus);
            });
    };

    $scope.RaportExcel = function (tipRaport) {
        $scope.FilterObject.TipRaport = tipRaport;
        EnableDisableInputs('#rapoarteMainContent', spinner, ACTIVE_DIV_ID, true, true);
        switch (tipRaport) {
            case "Raport termene":
                if ($scope.model.SocietatiAsigurare != null && $scope.model.SocietatiAsigurare != undefined && $scope.model.SocietatiAsigurare.length > 0) {
                    $scope.FilterObject._SOCIETATI = "";
                    for (var i = 0; i < $scope.model.SocietatiAsigurare.length; i++) {
                        var chk_id = "#checkboxSocietate_" + $scope.model.SocietatiAsigurare[i].ID;
                        var chk = $(chk_id).prop('checked');
                        if (chk) {
                            $scope.FilterObject._SOCIETATI += ($scope.model.SocietatiAsigurare[i].ID + (i == $scope.model.SocietatiAsigurare.length - 1 ? "" : ","));
                        }
                    }                    
                }
                break;
        }

        $http.post('/Rapoarte/RaportExcel', { FilterObject: JSON.stringify($scope.FilterObject) }, {
            //headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            responseType: 'arraybuffer'
        }).then(function (response) {
            if (response != 'null' && response != null && response.data != null) {
                var blob = new Blob([response.data], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                var objectUrl = URL.createObjectURL(blob);
                window.open(objectUrl);
                try {
                    ngDialog.close(ngDialog.latestID, 1);
                } catch (e) { ; };
            }
            //spinner.stop();
            EnableDisableInputs('#rapoarteMainContent', spinner, ACTIVE_DIV_ID, false, true);
        }, function (response) {
            alert('Erroare: ' + response.status + ' - ' + response.data);
            //spinner.stop();
            EnableDisableInputs('#rapoarteMainContent', spinner, ACTIVE_DIV_ID, false, true);
        });
    };

    $scope.toggleAllSocietati = function () {
        for (var i = 0; i < $scope.model.SocietatiAsigurare.length; i++) {
            var chk_id = "#checkboxSocietate_" + $scope.model.SocietatiAsigurare[i].ID;
            $(chk_id).prop('checked', $scope.checkAllSocietati);
        }
    };
});