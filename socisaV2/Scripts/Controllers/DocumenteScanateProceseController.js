'use strict';
app.controller('DocumenteScanateProceseController',
    function ($scope, $http, $filter, $rootScope, $window, Upload, ngDialog) {
        $scope.model = {};
        $scope.model.CurDocumentScanatProces = {};
        $scope.model.Documente = [];
        $scope.model.TipDocumenteScanateProcese = [];
        $scope.editMode = 0;
        $scope.searchMode = 1;
        $scope.curIndex = -1;

        $scope.$watch('searchMode', function (newValue, oldValue) {
            $rootScope.searchMode = newValue;
            console.log('d.s.p. - search: ' + newValue)
        });

        $scope.$watch('editMode', function (newValue, oldValue) {
            $rootScope.editMode = newValue;
            console.log('d.s.p. - edit: ' + newValue)
        });

        $scope.getThumbnailFile = function (file_name, ext) {
            var supported_extensions = ".jpg,.jpeg,.png,.bmp,.pdf";
            var thumb = "";
            if (file_name == null || file_name == "" || ext == null || supported_extensions.indexOf(ext.toLowerCase()) == -1) {
                thumb = ($rootScope.ExternalUser.Value == true ? "../../" : "../") + "content/images/UnsupportedType_Custom.jpg";
            } else {
                thumb = ($rootScope.ExternalUser.Value == true ? "../../" : "../") + "scans/" + file_name.substring(0, file_name.indexOf(ext)) + "_Custom.jpg";
            }
            return thumb;
        };

        $scope.EnterDocumwntScanatProcesDeleteMode = function (item, msg) {
            $scope.editMode = 3;
            angular.copy(item, $scope.model.CurDocumentScanatProces);
            $rootScope.confirmMessage = msg;
            ngDialog.openConfirm({
                template: 'confirmationDialogId',
                className: 'ngdialog-theme-default'
            }).then(
                function (value) {
                    $scope.DeleteDocumentScanatProces();
                },
                function (reason) {
                    $scope.editMode = 0;
                });
        };

        $scope.DeleteDocumentScanatProces = function () {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            $http.post('/DocumenteScanateProcese/Delete', { id: $scope.model.CurDocumentScanatProces.DocumentScanatProces.ID })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        $scope.result = response.data;
                        $rootScope.toogleOperationMessage($scope.result);
                        if ($scope.result.Status) {
                            var index = -1;
                            for (var i = 0; i < $scope.model.Documente.length; i++) {
                                if ($scope.model.Documente[i].DocumentScanatProces.ID == $scope.model.CurDocumentScanatProces.DocumentScanatProces.ID) {
                                    index = i;
                                    break;
                                }
                            }
                            $scope.model.Documente.splice(index, 1);
                        }
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                    $scope.editMode = 0;
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                    $scope.editMode = 0;
                });
        };

        $scope.vizualizareDoc = function (item) {
            $window.open(($rootScope.ExternalUser.Value == true ? "../../" : "../") + "../scans/" + item.DocumentScanatProces.CALE_FISIER);
        };
});