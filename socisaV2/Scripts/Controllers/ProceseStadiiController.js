'use strict';
app.controller('ProceseStadiiController',
    function ($scope, $http, $filter, $rootScope, $window, Upload, myService, ngDialog) {
        $scope.model = {};
        $scope.model.ID_DOSAR = null;
        $scope.model.ID_PROCES = null;
        $scope.model.CurProcesStadiu = {};
        $scope.model.ProceseStadii = [];
        $scope.model.Stadii = [];
        $scope.model.DocumenteScanateProces = [];
        //$scope.model.Sentinte = [];
        $scope.newItem = {};
        $scope.editMode = 0;
        $scope.searchMode = 1;
        $scope.curIndex = -1;
        $scope.CurStadiuIsSentinta = false;
        $scope.CurStadiuIconPath = "";


        $rootScope.$watch('ID_DOSAR', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $rootScope.activeTab.Value == 'stadii') {
                $scope.model = {};
                $scope.model.CurProcesStadiu = null;
                $scope.model.ProceseStadii = [];
                $scope.model.Stadii = [];
                $scope.model.DocumenteScanateProces = [];
                $scope.model.ID_DOSAR = newValue;
                $scope.model.ID_PROCES = null;
                $scope.ShowStadii(newValue, 'dosar');
            }
        });

        $rootScope.$watch('activeTab.Value', function (newValue, oldValue) {
            if (newValue == 'stadii' && $rootScope.ID_DOSAR != null && $rootScope.ID_DOSAR != undefined && $scope.lastActiveIdDosar != $rootScope.ID_DOSAR) {
                $scope.model = {};
                $scope.model.CurProcesStadiu = null;
                $scope.model.ProceseStadii = [];
                $scope.model.Stadii = [];
                $scope.model.DocumenteScanateProces = [];
                $scope.model.ID_DOSAR = $rootScope.ID_DOSAR;
                $scope.ShowStadii($rootScope.ID_DOSAR, 'dosar');
            }
        });

        $scope.$watch('searchMode', function (newValue, oldValue) {
            $rootScope.searchMode = newValue;
            console.log('p.s. - search: ' + newValue)
        });

        $scope.$watch('editMode', function (newValue, oldValue) {
            $rootScope.editMode = newValue;
            console.log('p.s. - edit: ' + newValue)
        });

        $scope.ShowStadii = function (_id, _tip) {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, true, true);
            myService.getlist('GET', '/ProceseStadii/Details/' + _id + '/' + _tip, null)
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        $scope.model = JSON.parse(response.data);
                        $scope.model.CurProcesStadiu = {};
                    }
                    else {
                        $scope.model.ProceseStadii = [];
                        $scope.model.CurProcesStadiu = {};
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);

                }, function (response) {
                    //spinner.stop();
                    EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);

                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };


        $scope.EditMode = function (procesStadiu, index) {
            angular.copy(procesStadiu, $scope.model.CurProcesStadiu);
            $scope.curIndex = index;
            $scope.editMode = 1;
            $scope.$parent.editModeStadii = 1;
        };

        $scope.AddMode = function () {
            $scope.curIndex = -1;
            $scope.CurStadiuIsSentinta = false;
            $scope.CurStadiuIconPath = "";
            $scope.model.CurProcesStadiu = {};
            $scope.model.CurProcesStadiu.ProcesStadiu = {};
            $scope.model.CurProcesStadiu.Stadiu = {};
            $scope.model.CurProcesStadiu.Sentinta = {};
            $scope.model.CurProcesStadiu.ProcesStadiu.ID_PROCES = $scope.model.ID_PROCES;
            $scope.model.CurProcesStadiu.ProcesStadiu.ID_DOSAR = $rootScope.ID_DOSAR;
            $scope.editMode = 2;
            $scope.$parent.editModeStadii = 2;
        };

        $scope.$on('procesSelected', function (event, data) {
            $scope.model.ID_PROCES = data;
        });

        $scope.getStadiuById = function (id) {
            for (var i = 0; i < $scope.model.Stadii.length; i++) {
                if ($scope.model.Stadii[i].ID == id) {
                    return $scope.model.Stadii[i];
                }
            }
        };

        $scope.$watch('model.CurProcesStadiu.ProcesStadiu.ID_STADIU', function (newValue, oldValue) {
            if (newValue != oldValue) {
                for (var i = 0; i < $scope.model.Stadii.length; i++) {
                    if (newValue == $scope.model.Stadii[i].ID) {
                        angular.copy($scope.model.Stadii[i], $scope.model.CurProcesStadiu.Stadiu);
                        if ($scope.model.Stadii[i].STADIU_CU_SENTINTA) {
                            if ($scope.model.CurProcesStadiu.Sentinta != null) {
                                $scope.model.CurProcesStadiu.ProcesStadiu.ID_SENTINTA = $scope.model.CurProcesStadiu.Sentinta.ID;
                            }
                        }
                        else {
                            $scope.model.CurProcesStadiu.ProcesStadiu.ID_SENTINTA = null;
                        }
                        $scope.CurStadiuIsSentinta = $scope.model.Stadii[i].STADIU_CU_SENTINTA;
                        break;
                    }
                }
            }
        });

        $scope.CustomOrdering = function (item) {
            try {
                var dateITems = item.ProcesStadiu.DATA.split('.');
                var date = new Date(dateITems[2], dateITems[1], dateITems[0], 0, 0, 0, 0)
                return date;
            } catch (e) { return null; }
        };

        $scope.Save = function () {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            //$http.post('/ProceseStadii/Edit', { ProcesStadiu : $scope.model.CurProcesStadiu.ProcesStadiu })
            $http.post('/ProceseStadii/Edit', { ProcesStadiuExtended: $scope.model.CurProcesStadiu })
                .then(function (response) {
                    var cps = JSON.parse(response.data.Message);
                    angular.copy(cps, $scope.model.CurProcesStadiu);
                    if (response.data.InsertedId != null) {
                        //$scope.model.CurProcesStadiu.ProcesStadiu.ID = response.data.InsertedId;
                        //$scope.model.CurProcesStadiu.Stadiu = $scope.getStadiuById($scope.model.CurProcesStadiu.ProcesStadiu.ID_STADIU);
                        var tmpPS = angular.copy($scope.model.CurProcesStadiu);
                        ////$scope.model.ProceseStadii.push(tmpPS);
                        $scope.model.ProceseStadii.splice(0, 0, tmpPS);
                    }
                    else {
                        for (var i = 0; i < $scope.model.ProceseStadii.length; i++) {
                            if ($scope.model.CurProcesStadiu.ProcesStadiu.ID == $scope.model.ProceseStadii[i].ProcesStadiu.ID) {
                                $scope.model.CurProcesStadiu.Stadiu = $scope.getStadiuById($scope.model.CurProcesStadiu.ProcesStadiu.ID_STADIU);
                                var tmpPS = angular.copy($scope.model.CurProcesStadiu);
                                angular.copy(tmpPS, $scope.model.ProceseStadii[i]);
                                break;
                            }
                        }
                    }
                    var maxStadiu = angular.copy($scope.model.ProceseStadii[0].ProcesStadiu);
                    for (var i = 0; i < $scope.model.ProceseStadii.length; i++) {
                        var tmpDt1 = maxStadiu.DATA.split('.');
                        var tmpDt2 = $scope.model.ProceseStadii[i].ProcesStadiu.DATA.split('.');
                        var data1 = new Date(tmpDt1[2], tmpDt1[1], tmpDt1[0], 0, 0, 0, 0);
                        var data2 = new Date(tmpDt2[2], tmpDt2[1], tmpDt2[0], 0, 0, 0, 0);
                        if (data1 < data2) {
                            maxStadiu = angular.copy($scope.model.ProceseStadii[i].ProcesStadiu);
                        }
                    }
                    $scope.$emit('procesStatusChangedEmitEvent', maxStadiu);
                    $scope.model.CurProcesStadiu = {};
                    $scope.model.CurProcesStadiu.ProcesStadiu = {};
                    $scope.editMode = 0;
                    $scope.$parent.editModeStadii = 0;
                    $rootScope.toogleOperationMessage(response.data);
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                }, function (response) {
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.Cancel = function () {
            $scope.model.CurProcesStadiu = {};
            $scope.model.CurProcesStadiu.ProcesStadiu = {};
            $scope.model.CurProcesStadiu.Stadiu = {};
            $scope.model.CurProcesStadiu.Sentinta = {};
            $scope.editMode = 0;
            $scope.$parent.editModeStadii = 0;
        };

        $scope.DeleteSentinta = function () {
            $scope.model.CurProcesStadiu.ProcesStadiu.ID_SENTINTA = null;
            $scope.model.CurProcesStadiu.Sentinta = {};
        };

        $scope.EnterStadiuProcesDeleteMode = function (item, msg) {
            $scope.editMode = 3;
            angular.copy(item, $scope.model.CurProcesStadiu);
            $rootScope.confirmMessage = msg;
            ngDialog.openConfirm({
                template: 'confirmationDialogId',
                className: 'ngdialog-theme-default'
            }).then(
                function (value) {
                    $scope.DeleteProcesStadiuProces();
                },
                function (reason) {
                    $scope.editMode = 0;
                });
        };

        $scope.DeleteProcesStadiuProces = function () {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            $http.post('/ProceseStadii/Delete', { id: $scope.model.CurProcesStadiu.ProcesStadiu.ID })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        $scope.result = response.data;
                        $rootScope.toogleOperationMessage($scope.result);
                        if ($scope.result.Status) {
                            var index = -1;
                            var maxStadiu = angular.copy( $scope.model.ProceseStadii[0].ProcesStadiu);
                            for (var i = 0; i < $scope.model.ProceseStadii.length; i++) {
                                var tmpDt1 = maxStadiu.DATA.split('.');
                                var tmpDt2 = $scope.model.ProceseStadii[i].ProcesStadiu.DATA.split('.');
                                var data1 = new Date(tmpDt1[2], tmpDt1[1], tmpDt1[0], 0, 0, 0, 0);
                                var data2 = new Date(tmpDt2[2], tmpDt2[1], tmpDt2[0], 0, 0, 0, 0);
                                if (data1 < data2) {
                                    maxStadiu = angular.copy($scope.model.ProceseStadii[i].ProcesStadiu);
                                }

                                if ($scope.model.ProceseStadii[i].ProcesStadiu.ID == $scope.model.CurProcesStadiu.ProcesStadiu.ID) {
                                    index = i;
                                    //break;
                                }
                            }
                            $scope.model.ProceseStadii.splice(index, 1);
                            $scope.$emit('procesStatusChangedEmitEvent', maxStadiu);

                            //$scope.$parent.ShowDocumente(null);
                        }
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                });
            $scope.editMode = 0;
        };


        /*
        $scope.OpenSentinteDialog = function () {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            $.ajax({
                async: true,
                type: 'GET',
                url: '/Sentinte/Index',
                dataType: 'html'
            }).done(function (data) {
                //alert(data);
                //var htmlContent = $compile(data)($scope);

                //spinner.stop();
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);

                ngDialog.openConfirm({
                    template: data,
                    plain: true,
                    className: 'ngdialog-theme-default custom-width',
                    controller: 'SentinteController',
                    width: 800,
                    scope: $scope
                }).then(
                    function (value) {
                        alert('succes');
                    },
                    function (reason) {
                        //alert(reason);
                    });
            }).fail(function (jqXHR, textStatus) {
                alert(textStatus);
                //spinner.stop();
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
            });
        };
        */
    });