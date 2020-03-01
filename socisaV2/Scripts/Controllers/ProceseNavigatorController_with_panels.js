'use strict';
var lastkeytime = new Date();
var lastruntime = new Date();
var waiting_interval = 1000; // miliseconds
var lastfiltervalue = "";

var spinner = new Spinner(opts);
var spinnerSmall = new Spinner(optsSmall);

function showProceseSideNav(on_off) {
    var proceseSideNav = document.getElementById("proceseSideNav");
    if (on_off) {
        proceseSideNav.style.width = '250px';
    }
    else {
        proceseSideNav.style.width = '0px';
    }
}
$(document).on('click', function (e) {
    var proceseSideNav = document.getElementById("proceseSideNav");
    if (proceseSideNav != null && proceseSideNav != undefined && proceseSideNav.style.width == '250px' && e.target.id.indexOf("ShowListaProcese") == -1) {
        showProceseSideNav(false);
    }
});

$(document).on('keydown', function (e) {
    var proceseSideNav = document.getElementById("proceseSideNav");
    if (e.keyCode === 27 && proceseSideNav != null && proceseSideNav != undefined && proceseSideNav.style.width == '250px') {
        showProceseSideNav(false);
    }
});

app.controller('ProceseNavigatorController',
    function ($scope, $http, $filter, $rootScope, $window, $timeout, $compile, $q, Upload, ngDialog) {
        //$rootScope.activeTab.Value = "procese";
        $scope.model = {};
        $scope.model.Procese = [];
        $scope.model.TipuriProcese = [];
        $scope.model.Instante = [];
        $scope.model.Complete = [];
        //$scope.model.Contracte = [];
        $scope.model.Calitati = [];
        //$scope.model.Parti = [];
        $scope.model.Societate = {};
        $scope.model.TipDocumenteScanateProcese = [];
        $scope.lastActiveIdDosar = "";
        $scope.init = null;

        $scope.model.CurProces = {};
        $scope.model.CurProces.Proces = {};
        $scope.model.CurProces.Proces.MONITORIZARE = null;
        $scope.model.procesJson = {};
        //$scope.model.procesJson.Calitate = 'RECLAMANT';
        //$scope.model.procesJson.Reclamant = $scope.model.Societate.DENUMIRE;

        //$scope.model.ID_DOSAR = null;
        $scope.editMode = 0;
        $scope.curProcesIndex = {};
        $scope.curProcesIndex.Value = null;
        //$scope.lastProcesId = -1;
        $scope.lastProcesIdDocumente = -1;
        $scope.lastProcesIdStadii = -1;

        $scope.curTipDocumentScanatProces = null;
        $scope.curStadiuProces = {};
        $scope.docSaved = null;
        $scope.editModeStadii = 0;
        $scope.searchMode = 1;

        $scope.TempProcesFilter = {};
        $scope.TempProcesFilter.CurProces = {};
        $scope.TempProcesFilter.CurProces.Proces = {};
        $scope.TempProcesFilter.CurProces.Proces.MONITORIZARE = null;
        $scope.TempProcesFilter.procesJson = {};
        //$scope.TempProcesFilter.procesJson.Calitate = 'RECLAMANT';
        //$scope.TempProcesFilter.procesJson.Reclamant = $scope.model.Societate.DENUMIRE;

        $scope.TempProcesEdit = {};

        $scope.result = {};
        $scope.IDSocietateRep = 0;
        $scope.Interactive = false;

        $scope.DefaultRowsBlockSize = $scope.RowsBlockSize = 50;
        $scope.RowsBlockIndex = 0;
        $scope.RowsCount = 0;
        $scope.idx = 0;
        $scope.mytimeout = null;
        

        $rootScope.$watch('ID_DOSAR', function (newValue, oldValue) {
            if (newValue != oldValue && newValue != null && $rootScope.activeTab.Value == "procese") {

                try {
                    var popovers = $('*[id^=popover]');
                    if (popovers) {
                        popovers.each(function (i, el) {
                            try {
                                if ($('#' + el.id).hasContent()) {
                                    $('#' + el.id).popover('hide');
                                }
                            } catch (e1) { ; }
                        });
                    }
                } catch (e) { ; }
            }
        });

        $scope.$watch('searchMode', function (newValue, oldValue) {
            $rootScope.searchMode = newValue;
            console.log('procese - search: ' + newValue)
        });

        $scope.$watch('editMode', function (newValue, oldValue) {
            $rootScope.editMode = newValue;
            console.log('procese - edit: ' + newValue)
        });
        
        $scope.$watch('model.procesJson.Calitate', function (newValue, oldValue) {
            if (newValue != oldValue && ($scope.searchMode == 2 || ($scope.editMode > 0 && $rootScope.ID_DOSAR == null))) {
                if (newValue == null) {
                    $scope.model.procesJson.Reclamant = $scope.model.procesJson.Parat = $scope.model.procesJson.Tert = null;
                    $scope.model.CurProces.Proces.ID_RECLAMANT = $scope.model.CurProces.Proces.ID_PARAT = $scope.model.CurProces.Proces.ID_TERT = null;
                }
                else {
                    for (var i = 0; i < $scope.model.Calitati.length; i++) {
                        if ($scope.model.Calitati[i].DENUMIRE == newValue) {
                            switch ($scope.model.Calitati[i].DENUMIRE) {
                                case 'RECLAMANT':
                                    $scope.model.procesJson.Reclamant = $scope.model.Societate.DENUMIRE;
                                    $scope.model.procesJson.Parat = null;
                                    $scope.model.procesJson.Tert = null;
                                    if ($scope.editMode > 0) {
                                        $scope.model.CurProces.Proces.ID_RECLAMANT = $scope.model.Societate.ID;
                                        $scope.model.CurProces.Proces.ID_PARAT = $scope.model.CurProces.Proces.ID_TERT = null;
                                    }
                                    break;
                                case 'PARAT':
                                    $scope.model.procesJson.Parat = $scope.model.Societate.DENUMIRE;
                                    $scope.model.procesJson.Reclamant = null;
                                    $scope.model.procesJson.Tert = null;
                                    if ($scope.editMode > 0) {
                                        $scope.model.CurProces.Proces.ID_PARAT = $scope.model.Societate.ID;
                                        $scope.model.CurProces.Proces.ID_RECLAMANT = $scope.model.CurProces.Proces.ID_TERT = null;
                                    }
                                    break;
                                case 'TERT':
                                    $scope.model.procesJson.Tert = $scope.model.Societate.DENUMIRE;
                                    $scope.model.procesJson.Reclamant = null;
                                    $scope.model.procesJson.Parat = null;
                                    if ($scope.editMode > 0) {
                                        $scope.model.CurProces.Proces.ID_TERT = $scope.model.Societate.ID;
                                        $scope.model.CurProces.Proces.ID_RECLAMANT = $scope.model.CurProces.Proces.ID_PARAT = null;
                                    }
                                    break;
                                default:
                                    $scope.model.procesJson.Reclamant = $scope.model.procesJson.Parat = null;
                                    if ($scope.editMode > 0) {
                                        $scope.model.CurProces.Proces.ID_RECLAMANT = $scope.model.CurProces.Proces.ID_PARAT = null;
                                    }
                                    break;
                            }
                            break;
                        }
                    }
                }
            }

            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                    return;
                }
            }
        });
        
        $scope.$watch('curProcesIndex', function (newValue, oldValue) {
            if (newValue.Value != null && newValue.Value > -1) {
                var rowId = "#proces_" + newValue.Value;
                $(rowId).addClass("activeProces");

                if (newValue.Value != oldValue.Value || $scope.init == null)
                {
                    if (oldValue.Value != null && oldValue.Value > -1) {
                        var oldRowId = "#proces_" + oldValue.Value;
                        $(oldRowId).removeClass("activeProces");
                    }
                    /*
                    var newIdDosar = $scope.model.Procese[newValue.Value].Proces.ID_DOSAR;
                    var oldIdDosar = $scope.model.Procese[oldValue.Value].Proces.ID_DOSAR;
                    */
                    var newIdDosar = $scope.model.Procese[newValue.Value].ID_DOSAR;
                    var oldIdDosar = $scope.model.Procese[oldValue.Value].ID_DOSAR;

                    if ($rootScope.activeTab.Value == 'procese') {
                        $scope.init = newValue.Value;
                        //var filter = (newIdDosar != null && newIdDosar != undefined && (newIdDosar != oldIdDosar || $scope.init == null));
                        var filter = (newIdDosar != null && newIdDosar != undefined);
                        $scope.$emit('NewFilterRequestEmitEvent', { newIdDosar: newIdDosar, filter: filter });
                    }
                }
            }
        }, true);

        $rootScope.$watch('activeTab.Value', function (newValue, oldValue) {
            if (newValue == 'procese' && $rootScope.ID_DOSAR != null && $rootScope.ID_DOSAR != undefined && $scope.lastActiveIdDosar != $rootScope.ID_DOSAR) {
                $scope.editMode = 0;
                $scope.searchMode = 1;
                //$scope.model = {};
                $scope.model.CurProces = {};
                $scope.model.CurProces.Proces = {};
                $scope.model.procesJson = {};
                $scope.model.Procese = [];
                $scope.TempProcesFilter = {};
                $scope.TempProcesFilter.CurProces = {};
                $scope.TempProcesFilter.CurProces.Proces = {};
                $scope.TempProcesFilter.procesJson = {};
                $scope.TempProcesEdit = {};
                //$scope.model.TipuriProcese = [];
                //$scope.model.Instante = [];
                //$scope.model.Complete = [];
                //$scope.model.Contracte = [];
                //$scope.model.TipDocumenteScanateProcese = [];
                //$scope.model.Parti = [];
                //$scope.model.Calitati = [];
                //$scope.model.ID_DOSAR = $rootScope.ID_DOSAR;
                $scope.ShowProcese($rootScope.ID_DOSAR);
                //$scope.lastActiveIdDosar = $rootScope.ID_DOSAR;
            }
            /*
            if (newValue == 'procese' && ($rootScope.ID_DOSAR == null || $rootScope.ID_DOSAR == undefined)) {
                $rootScope.setActiveTab($rootScope.activeTab.Value);
            }
            */
        });

        $scope.$watch('docSaved', function (newValue, oldValue) {
            if (newValue != null) {
                ngDialog.close(ngDialog.latestID, 1);
                $scope.ShowDocumente(false);
                $scope.docSaved = null;
            }
        });
        
        $scope.$watch('editMode', function (newValue, oldValue) {
            //document.getElementById('Dosar_DATA_EVENIMENT').disabled = !(newValue == 1);
            document.getElementById("calitateSelect").options[0].disabled = (newValue > 0);
        });
        $scope.$watch('searchMode', function (newValue, oldValue) {
            //document.getElementById('societateCascoSelect').disabled = !(newValue == 2 && $rootScope.calitateSocietateCurenta.Value == 'RCA');
        });
        
        $scope.$watch('model.CurProces.Proces.MONITORIZARE', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && newValue != oldValue) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        
        $scope.$watch('model.CurProces.Proces.ID_COMPLET', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('model.CurProces.Proces.ID_INSTANTA', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('model.CurProces.Proces.ID_TIP_PROCES', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('model.CurProces.Proces.ID_CONTRACT', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('model.CurProces.Contract.NR_CONTRACT', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.model.procesJson.Contract = newValue;
                    $scope.Afisare(newValue, null);
                }
            }
        });
        
        $scope.$watch('model.CurProces.Proces.MONITARIZARE', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('model.CurProces.StadiuCurent.ProcesStadiu.ID_STADIU', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.model.procesJson.Stadiu = newValue;
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('model.procesJson.DataDepunereEnd', function (newValue, oldValue) {
            if (newValue != oldValue) {
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('model.procesJson.DataExecutareEnd', function (newValue, oldValue) {
            if (newValue != oldValue) {
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('model.procesJson.DataStadiuEnd', function (newValue, oldValue) {
            if (newValue != oldValue) {
                $scope.Afisare(newValue, null);
            }
        });

        $scope.$watch('model.CurProces.Proces.DATA_DEPUNERE', function (newDate, oldDate) {
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.model.CurProces.Proces.DATA_DEPUNERE = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });
        $scope.$watch('model.CurProces.Proces.DATA_EXECUTARE', function (newDate, oldDate) {
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.model.CurProces.Proces.DATA_EXECUTARE = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });
        $scope.$watch('model.procesJson.DataStadiu', function (newDate, oldDate) {
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.model.procesJson.DataStadiu = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });

        $scope.$on('procesStatusChangedEmitEvent', function (event, data) {
            angular.copy(data, $scope.model.CurProces.StadiuCurent);
        });

        $scope.$on('refreshEmitEvent', function (event, data) {
            console.log('on: ' + data.objectType + ' - ' + data.object.DENUMIRE);
            switch (data.objectType) {
                case "TipProces":
                    if (data.operation == "insert") {
                        $scope.model.TipuriProcese.push(data.object);
                    }
                    else {
                        for (var i = 0; i < $scope.model.TipuriProcese.length; i++) {
                            if ($scope.model.TipuriProcese[i].ID == data.object.ID) {
                                angular.copy(data.object, $scope.model.TipuriProcese[i]);
                                break;
                            }
                        }
                    }
                    angular.copy(data.object, $scope.model.CurProces.TipProces);
                    $scope.model.CurProces.Proces.ID_TIP_PROCES = data.object.ID;
                    break;
                case "Instanta":
                    if (data.operation == "insert") {
                        $scope.model.Instante.push(data.object);
                    }
                    else {
                        for (var i = 0; i < $scope.model.Instante.length; i++) {
                            if ($scope.model.Instante[i].ID == data.object.ID) {
                                angular.copy(data.object, $scope.model.Instante[i]);
                                break;
                            }
                        }
                    }
                    angular.copy(data.object, $scope.model.CurProces.Instanta);
                    $scope.model.CurProces.Proces.ID_INSTANTA = data.object.ID;
                    break;
                case "Complet":
                    if (data.operation == "insert") {
                        $scope.model.Complete.push(data.object);
                    }
                    else {
                        for (var i = 0; i < $scope.model.Complete.length; i++) {
                            if ($scope.model.Complete[i].ID == data.object.ID) {
                                angular.copy(data.object, $scope.model.Complete[i]);
                                break;
                            }
                        }
                    }
                    angular.copy(data.object, $scope.model.CurProces.Complet);
                    $scope.model.CurProces.Proces.ID_COMPLET = data.object.ID;
                    break;
                case "Reclamant":
                    if (data.operation == "insert") {
                        $scope.model.CurProces.Proces.ID_RECLAMANT = data.object.ID;
                    }
                    $scope.model.CurProces.procesJson.Reclamant = data.object.DENUMIRE;
                    break;
                case "Parat":
                    if (data.operation == "insert") {
                        $scope.model.CurProces.Proces.ID_PARAT = data.object.ID;
                    }
                    $scope.model.CurProces.procesJson.Parat = data.object.DENUMIRE;
                    break;
                case "Tert":
                    if (data.operation == "insert") {
                        $scope.model.CurProces.Proces.ID_TERT = data.object.ID;
                    }
                    $scope.model.CurProces.procesJson.Tert = data.object.DENUMIRE;
                    break;
            }
            /*
            for (var i = 0; i < $scope.model.Procese.length; i++) {
                if ($scope.model.Procese[i].Proces.ID == $scope.model.CurProces.Proces.ID) {
                    angular.copy($scope.model.CurProces, $scope.model.Procese[i]);
                    break;
                }
            }
            */
            for (var i = 0; i < $scope.model.Procese.length; i++) {
                if ($scope.model.Procese[i].ID == $scope.model.CurProces.Proces.ID) {
                    angular.copy($scope.model.CurProces.Proces, $scope.model.Procese[i]);
                    break;
                }
            }
        });

        $scope.ShowProcese = function (id_dosar) {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, true);
            $http.get('/Procese/Details/' + id_dosar)
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        $scope.model = JSON.parse(response.data);
                        $scope.model.CurProces = {};
                        $scope.model.CurProces.Proces = {};
                        //$scope.model.procesJson = {};
                        if ($scope.model.Procese.length > 0) {
                            $scope.RowsCount = $scope.model.Procese.length;
                            //$scope.curProcesIndex.Value = 0;
                            //$scope.ShowProces($scope.curProcesIndex.Value);
                            $scope.ShowProces(0);
                        }
                    }
                    else {
                        $scope.model.Procese = [];
                        $scope.model.CurProces = {};
                        $scope.model.CurProces.Proces = {};
                        $scope.model.procesJson = {};
                        $scope.RowsCount = 0;
                        $scope.curProcesIndex.Value = null;
                    }
                    //spinner.stop();
                    EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);

                }, function (response) {
                    //spinner.stop();
                    EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);

                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.getTipProces = function (id_tip_proces) {
            var toReturn = "";
            for (var i = 0; i < $scope.model.TipuriProcese.length; i++) {
                if (id_tip_proces == $scope.model.TipuriProcese[i].ID) {
                    toReturn = $scope.model.TipuriProcese[i].DENUMIRE;
                    break;
                }
            }
            return toReturn;
        }

        $scope.ShowHideList = function (interactive) {
            if (interactive) {
                document.getElementById('ProceseListDiv').style.display = document.getElementById('ProceseListDiv').style.display == 'none' ? 'block' : 'none';
            }
        };

        $scope.ShowInfoPortal = function (interactive) {
            if (interactive) {
                document.getElementById('infoPortal').style.display = document.getElementById('infoPortal').style.display == 'block' ? 'none' : 'block';
            }

            if (document.getElementById('infoPortal').style.display == 'block' && ($scope.model.CurProces.Proces.ID != $scope.lastProcesIdStadii)) {
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, true);
                $.ajax({
                    async: false,
                    type: 'GET',
                    url: '/PortalWS/Index/' + $scope.model.CurProces.Proces.ID,
                    dataType: 'html'
                }).done(function (data) {
                    var htmlContent = $compile(data)($scope);

                    $("#infoPortalDetails").html(htmlContent);
                    /*
                    ngDialog.open({
                        template: htmlContent,
                        plain: true
                        //className: 'ngdialog-theme-default',
                        //controller: 'PortalWSController'
                    });
                    */
                    EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
                }).fail(function (jqXHR, textStatus) {
                    EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
                    alert(textStatus);
                });
            }
        };


        $scope.ShowStadii = function (interactive) {
            if (interactive) {
                document.getElementById('infoStadiiDosar').style.display = document.getElementById('infoStadiiDosar').style.display == 'block' ? 'none' : 'block';
            }

            if (document.getElementById('infoStadiiDosar').style.display == 'block' && ($scope.model.CurProces.Proces.ID != $scope.lastProcesIdStadii)) {
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, true);
                $.ajax({
                    async: false,
                    type: 'GET',
                    url: '/ProceseStadii/Details/' + $scope.model.CurProces.Proces.ID,
                    dataType: 'html'
                }).done(function (data) {
                    var htmlContent = $compile(data)($scope);
                    $scope.lastProcesIdStadii = $scope.model.CurProces.Proces.ID;
                    $('#infoStadiiDosarDetails').html(htmlContent);
                    EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
                }).fail(function (jqXHR, textStatus) {
                    EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
                    alert(textStatus);
                });
            }
        };

        $scope.ShowDocumente = function (interactive) {
            if (interactive) {
                document.getElementById('infoDocumenteProces').style.display = document.getElementById('infoDocumenteProces').style.display == 'block' ? 'none' : 'block';
            }

            if (document.getElementById('infoDocumenteProces').style.display == 'block' && ($scope.model.CurProces.Proces.ID != $scope.lastProcesIdDocumente || $scope.docSaved != null)) {
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, true);
                $.ajax({
                    async: false,
                    type: 'GET',
                    url: '/DocumenteScanateProcese/Details/' + $scope.model.CurProces.Proces.ID,
                    dataType: 'html'
                }).done(function (data) {
                    var htmlContent = $compile(data)($scope);
                    $scope.lastProcesIdDocumente = $scope.model.CurProces.Proces.ID;
                    $('#infoDocumenteProcesDetails').html(htmlContent);
                    EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
                }).fail(function (jqXHR, textStatus) {
                    EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
                    alert(textStatus);
                });
            }
        };

        $scope.ShowProcesDetails = function (id) {
            $.ajax({
                async: false,
                type: 'GET',
                url: '/ProceseStadii/Details/' + id,
                dataType: 'html'
            }).done(function (data) {
                //alert(data);
                var htmlContent = $compile(data)($scope);
                $('#DivStadii').html(htmlContent);
                $scope.$broadcast('procesSelected', id);
            }).fail(function (jqXHR, textStatus) {
                alert(textStatus);
            });
        };

        $scope.ShowHideMain = function () {
            document.getElementById('infoGeneraleDosar').style.display = document.getElementById('infoGeneraleDosar').style.display == 'block' ? 'none' : 'block';
            document.getElementById('footerGeneraleDosar').style.display = document.getElementById('footerGeneraleDosar').style.display == 'block' ? 'none' : 'block';
        };

        $scope.Afisare = function (e, sender) {
            if ($scope.editMode > 0 || $rootScope.ExternalUser.Value == true) return;
            var direct = sender == null;

            if ($scope.searchMode == 2) {
                angular.copy($scope.model.CurProces, $scope.TempProcesFilter.CurProces);
                angular.copy($scope.model.procesJson, $scope.TempProcesFilter.procesJson);
            }

            var now = new Date();
            var filter_value = e;
            if (!direct && now - lastkeytime <= waiting_interval && $scope.Interactive) {
                $timeout.cancel($scope.mytimeout);
                $scope.mytimeout = $timeout(function () { $scope.Afisare(e, sender); }, waiting_interval);
                lastkeytime = now;
                return;
            }
            else {
                if ((direct || lastfiltervalue != filter_value) && $scope.Interactive) {
                    $scope.RowsBlockIndex = 0;
                    //$scope.curProcesIndex.Value = $scope.idx = 0;
                    $scope.idx = 0;
                    $scope.Afisare2(e);
                    lastkeytime = now;
                    lastfiltervalue = filter_value;
                }
            }
            $scope.Interactive = false;
        };

        $scope.Afisare2 = function (input_value) {
            EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, true);


            $scope.model.procesJson.LimitStart = $scope.RowsBlockIndex * $scope.RowsBlockSize;
            $scope.model.procesJson.LimitEnd = $scope.RowsBlockSize;
            /*
            $http.post('/Procese/Search', $scope.model, {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            })
            */
            $http.post('/Procese/Search', { Proces: $scope.model.CurProces.Proces, procesJson: $scope.model.procesJson })
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    var tmp = JSON.parse(response.data);
                    $scope.model.Procese = tmp.Result;
                    $scope.RowsCount = tmp.InsertedId; // artificiu pt. aducerea nr.-ului total de inregistrari filtrate
                    // daca vrem sa activam navigarea doar din buton, comentam urmatoarele 2 linii
                    //$scope.curProcesIndex.Value = $scope.idx;
                    //$scope.ShowProces($scope.curProcesIndex.Value);
                    $scope.ShowProces($scope.idx);
                }
                else {
                    $scope.model.Procese = [];
                    $scope.model.CurProces = {};
                    $scope.model.CurProces.Proces = {};
                    $scope.model.CurProces.Proces.MONITORIZARE = null;
                    $scope.model.procesJson = {};
                    $scope.RowsCount = 0;
                    $scope.curProcesIndex.Value = $scope.idx = -1;
                }
                //spinner.stop();
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
                lastruntime = new Date();
                lastfiltervalue = input_value;
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
                //spinner.stop();
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
            });
        };

        $scope.formatDate = function (dateValue) {
            return $filter('date')(new Date(parseInt(dateValue.substr(6))), $rootScope.DATE_FORMAT);
        }

        $scope.compareObjects = function (o1, o2) {
            return angular.equals(o1, o2);
        }

        $scope.ClearFilters = function () {
            $scope.searchMode = 1;
            $rootScope.ID_DOSAR = null;
            $scope.Interactive = false;

            $scope.TempProcesFilter.CurProces = {};
            $scope.TempProcesFilter.CurProces.Proces = {};
            $scope.TempProcesFilter.procesJson = {};
            $scope.model.procesJson = {};
            $scope.model.CurProces.Proces = {};
            $scope.model.CurProces.Proces.MONITORIZARE = null;
            //$scope.model.procesJson.Calitate = 'RECLAMANT';
            //$scope.model.procesJson.Reclamant = $scope.model.Societate.DENUMIRE;
            document.getElementById("calitateSelect").options[0].selected = true;


            $scope.model.Procese = undefined;

            $scope.RowsBlockIndex = 0;
            $scope.model.procesJson.LimitStart = $scope.RowsBlockIndex * $scope.RowsBlockSize;
            $scope.model.procesJson.LimitEnd = $scope.RowsBlockSize;
            //$scope.idx = $scope.curProcesIndex.Value = 0;
            $scope.idx = 0;
            $scope.Afisare2(null);
        };

        $scope.SwitchBackToSearchMode = function () {
            if ($scope.editMode == 1 || $rootScope.ExternalUser.Value == true) return;
            $scope.searchMode = 2;
            $scope.curProcesIndex.Value = 0;
            $scope.switchTempToProcesObjects();
            /*
            if ($scope.model.procesJson.Calitate == null || $scope.model.procesJson.Calitate == undefined || $scope.model.procesJson.Calitate == '' ||
                $scope.model.procesJson.Reclamant == null || $scope.model.procesJson.Reclamant == undefined || $scope.model.procesJson.Reclamant == '') {
                $scope.model.procesJson.Calitate = 'RECLAMANT';
                $scope.model.procesJson.Reclamant = $scope.model.Societate.DENUMIRE;
            }
            */
        };

        $scope.switchTempToProcesObjects = function () {
            angular.copy($scope.TempProcesFilter.CurProces, $scope.model.CurProces);
            angular.copy($scope.TempProcesFilter.procesJson, $scope.model.procesJson);
        };

        $scope.GetCalitate = function (id_calitate) {
            for (var i = 0; i < $scope.model.Calitati.length; i++) {
                if ($scope.model.Calitati[i].ID == id_calitate) {
                    return $scope.model.Calitati[i].DENUMIRE.toUpperCase();
                }
            }
            return null;
        };

        $scope.firstProces = function () {
            if ($scope.model.Procese != undefined) {
                if ($scope.RowsBlockIndex <= 0 && $scope.curProcesIndex.Value <= 0) return;

                if ($scope.RowsBlockIndex > 0) {
                    $scope.switchTempToProcesObjects();
                    $scope.RowsBlockSize = $scope.DefaultRowsBlockSize; // reinitializam RowsBlockSize pt. situatia in care au fost stergeri
                    $scope.RowsBlockIndex = 0;
                    $scope.idx = 0;
                    $scope.Afisare2(null);
                }
                else {
                    $scope.idx = 0;
                    $scope.ShowProces($scope.idx);
                }
            }
        };

        $scope.prevProces = function () {
            if ($scope.model.Procese != undefined) {
                if ($scope.RowsBlockIndex <= 0 && $scope.curProcesIndex.Value <= 0) return;

                if ($scope.curProcesIndex.Value == 0) {
                    $scope.switchTempToProcesObjects();
                    $scope.RowsBlockSize = $scope.DefaultRowsBlockSize; // reinitializam RowsBlockSize pt. situatia in care au fost stergeri
                    $scope.RowsBlockIndex = $scope.RowsBlockIndex - 1;
                    $scope.idx = $scope.RowsBlockSize - 1;
                    $scope.Afisare2(null);
                }
                else {
                    $scope.idx = $scope.curProcesIndex.Value - 1;
                    $scope.ShowProces($scope.idx);
                }
            }
        };

        $scope.nextProces = function () {
            if ($scope.model.Procese != undefined) {
                if ($scope.RowsCount <= $scope.RowsBlockIndex * $scope.RowsBlockSize + $scope.curProcesIndex.Value + 1 || $scope.RowsCount <= $scope.curProcesIndex.Value + 1) return;

                if ($scope.curProcesIndex.Value == $scope.RowsBlockSize - 1) {
                    $scope.switchTempToProcesObjects();
                    $scope.RowsBlockSize = $scope.DefaultRowsBlockSize; // reinitializam RowsBlockSize pt. situatia in care au fost stergeri
                    $scope.RowsBlockIndex = $scope.RowsBlockIndex + 1;
                    $scope.idx = 0;
                    $scope.Afisare2(null);
                }
                else {
                    $scope.idx = $scope.curProcesIndex.Value + 1;
                    $scope.ShowProces($scope.idx);
                }
            }
        };

        $scope.lastProces = function () {
            if ($scope.model.Procese != undefined) {
                if ($scope.RowsCount <= $scope.RowsBlockIndex * $scope.RowsBlockSize + $scope.curProcesIndex.Value + 1 || $scope.RowsCount <= $scope.curProcesIndex.Value + 1) return;

                if ($scope.RowsBlockIndex < Math.floor($scope.RowsCount / $scope.RowsBlockSize)) {
                    $scope.switchTempToProcesObjects();
                    $scope.RowsBlockSize = $scope.DefaultRowsBlockSize; // reinitializam RowsBlockSize pt. situatia in care au fost stergeri
                    $scope.RowsBlockIndex = Math.floor($scope.RowsCount / $scope.RowsBlockSize);
                    $scope.idx = $scope.RowsCount % $scope.RowsBlockSize - 1;
                    $scope.Afisare2(null);
                }
                else {
                    $scope.idx = $scope.RowsCount % $scope.RowsBlockSize - 1;
                    $scope.ShowProces($scope.idx);
                }
            }
        };
    
    $scope.ShowProces = function (index) {
        if (index < 0 || $scope.model.Procese.length < 1 || index > $scope.model.Procese.length || $scope.searchMode == 2) return; // searchMode == 2 e pt. afisare doar din buton

        $scope.searchMode = 1;
        $scope.curProcesIndex.Value = index;
        //angular.copy($scope.model.Procese[index], $scope.model.CurProces);
        var qs = [];
        var x = $scope.GetDetails($scope.model.Procese[index].ID);
        qs.push(x);
        ////$scope.ShowProcesDetails(proces.Proces.ID); // -- DACA VREM STADIILE DIRECT IN PAGINA DE PROCESE

        $q.all(qs).then(function (response) {
            $scope.lastActiveIdDosar = $scope.model.CurProces.Proces.ID_DOSAR;
            ////$scope.oldProces = angular.copy($scope.model.CurProces);
            if (document.getElementById("infoStadiiDosar").style.display == 'block')
                $scope.ShowStadii(false);
            if (document.getElementById("infoDocumenteProces").style.display == 'block')
                $scope.ShowDocumente(false);
            if (document.getElementById("infoPortal").style.display == 'block')
                $scope.ShowInfoPortal(false);
            ////$scope.lastProcesId = $scope.model.CurProces.Proces.ID;
            ////$rootScope.ID_DOSAR = $scope.model.CurProces.Proces.ID_DOSAR;
            ////$rootScope.setActiveTab($rootScope.activeTab.Value);
            //spinner.stop();
            //EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
        }, function (response) {
            var message = 'Status: ' + response.status + '<br />' + response.data;
            var result = { ShowMessage: true, Status: false, Message: message, Result: null, InsertedId: null, Error: null };
            $rootScope.toogleOperationMessage(result);
            //EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
        });
    };

    $scope.GetDetails = function (id) {
        EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, false)

        return $http.get('/Procese/Detail/' + id)
            .then(function (response2) {
                if (response2 != 'null' && response2 != null && response2.data != null) {
                    $scope.model.CurProces = JSON.parse(response2.data);
                    try {
                        $scope.model.procesJson.Reclamant = $scope.model.CurProces.Reclamant.DENUMIRE;
                    } catch (e) { $scope.model.procesJson.Reclamant = null; }
                    try {
                        $scope.model.procesJson.Parat = $scope.model.CurProces.Parat.DENUMIRE;
                    } catch (e) { $scope.model.procesJson.Parat = null; }
                    try {
                        $scope.model.procesJson.Tert = $scope.model.CurProces.Tert.DENUMIRE;
                    } catch (e) { $scope.model.procesJson.Tert = null; }
                    try {
                        $scope.model.procesJson.Calitate = $scope.model.CurProces.Calitate.DENUMIRE;
                    } catch (e) { $scope.model.procesJson.Calitate = null; }
                    try {
                        $scope.model.procesJson.DataStadiu = $scope.model.CurProces.StadiuCurent.ProcesStadiu.DATA;
                    } catch (e) { $scope.model.procesJson.DataStadiu = null; }

                ////spinner.stop();
                    EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, false)
            }
        }, function (response2) {
            //spinner.stop();
            EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, false)
            alert('Erroare: ' + response2.status + ' - ' + response2.data);
        });
    }

    $scope.EnterEditMode = function () {
        if ($scope.model.CurProces.Proces.ID == null) return;
        $scope.searchMode = 0;
        $scope.editMode = 1;
        angular.copy($scope.model.CurProces, $scope.TempProcesEdit);
    };

    $scope.EnterAddMode = function (msg) {
        if ($rootScope.ID_DOSAR != null) {
            $rootScope.confirmMessage = msg;
            ngDialog.openConfirm({
                template: 'confirmationDialogId',
                className: 'ngdialog-theme-default'
            }).then(
                function (value) {
                    $scope.EnterAddModeAfterConfirm();
                    $scope.model.CurProces.Proces.ID_DOSAR = $rootScope.ID_DOSAR;
                },
                function (reason) {
                    //trebuie sa inactivam filtrul implicit pe dosarul selectat
                    $rootScope.ID_DOSAR = null;
                    //$scope.Afisare2(null);
                    //$scope.model.Procese = [];
                    $scope.EnterAddModeAfterConfirm();
                });
        }
        else {
            $scope.EnterAddModeAfterConfirm();
        }
    };
    $scope.EnterAddModeAfterConfirm = function () {
        $scope.searchMode = 0;
        //$scope.editMode = 1;
        $scope.editMode = 2;
        angular.copy($scope.model.CurProces, $scope.TempProcesEdit);
        $scope.model.CurProces = {};
        $scope.model.CurProces.Proces = {};
        $scope.model.CurProces.Proces.ID_RECLAMANT = null;
        $scope.model.CurProces.Proces.ID_PARAT = null;
        $scope.model.CurProces.Proces.ID_TERT = null;
        $scope.model.CurProces.Proces.ID_TIP_PROCES = null;
        $scope.model.CurProces.Proces.ID_INSTANTA = null;
        $scope.model.CurProces.Proces.ID_COMPLET = null;
        if ($rootScope.ID_DOSAR == null) {
            $scope.model.procesJson = {};
            $scope.model.procesJson.Calitate = null;
        }
        else {

        }
    };

    $scope.SaveEdit = function () {
        //$scope.editMode = 4;
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, true);

        //$http.post('/Procese/Edit', { Proces: $scope.model.CurProces.Proces })
        $http.post('/Procese/Edit', { Proces: $scope.model.CurProces.Proces, procesJson: $scope.model.procesJson })
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.result = response.data;
                    $rootScope.toogleOperationMessage($scope.result);

                    if ($scope.result.Status) {
                        $scope.editMode = 0;
                        $scope.searchMode = 1;
                        $scope.newProces = angular.copy($scope.model.CurProces);

                        if ($scope.result.InsertedId != null) {
                            $scope.updateType = 'insert';
                            $scope.model.CurProces.Proces.ID = $scope.result.InsertedId;

                            if ($scope.model.Procese == undefined || $scope.model.Procese == null) {
                                $scope.model.Procese = [];
                            }
                            //var tmpProces = angular.copy($scope.model.CurProces);
                            var tmpProces = angular.copy($scope.model.CurProces.Proces);
                            $scope.model.Procese.push(tmpProces);
                            $scope.RowsCount = $scope.model.Procese.length;
                            $scope.model.ProceseStadii = [];
                            $scope.model.Documente = [];
                            $scope.$emit('refreshCounterEmitEvent', { object: 'procese', value: 1 });
                        }
                        else {
                            $scope.updateType = 'update';
                            /*
                            for (var i = 0; i < $scope.model.Procese.length; i++) {
                                if ($scope.model.Procese[i].Proces.ID == $scope.model.CurProces.Proces.ID) {
                                    angular.copy($scope.model.CurProces, $scope.model.Procese[i]);
                                    break;
                                }
                            }
                            */
                            for (var i = 0; i < $scope.model.Procese.length; i++) {
                                if ($scope.model.Procese[i].ID == $scope.model.CurProces.Proces.ID) {
                                    angular.copy($scope.model.CurProces.Proces, $scope.model.Procese[i]);
                                    break;
                                }
                            }
                        }
                    }
                    else {
                        //$scope.editMode = 1;
                    }
                } else {
                    //$scope.editMode = 1;
                }
                //spinner.stop();
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
                //spinner.stop();
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
            });
    };

    $scope.CancelEdit = function () {
        $scope.updateType = null;
        //if ($scope.editMode == 1) {
            angular.copy($scope.TempProcesEdit, $scope.model.CurProces);
        //}
        /*
        if ($scope.editMode == 2) {
            //angular.copy($scope.model.Procese[0], $scope.model.CurProces);
            $scope.model.CurProces = {};
            $scope.model.CurProces.Proces = {};
        }
        */
        $scope.editMode = 0;
        $scope.searchMode = 1;
    };

    $scope.Delete = function () {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, true);
        $http.post('/Procese/Delete', { id: $scope.model.CurProces.Proces.ID })
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.result = response.data;
                    $rootScope.toogleOperationMessage($scope.result);
                    if ($scope.result.Status) {
                        $scope.updateType = 'delete';
                        //$scope.oldProces = angular.copy(proces);
                        $scope.searchMode = 1;
                        $scope.editMode = 0;
                        $scope.model.Procese.splice($scope.curProcesIndex.Value, 1);
                        $scope.RowsCount -= 1;
                        if ($scope.curProcesIndex.Value != 0) {
                            $scope.RowsBlockSize -= 1; // scadem nr. de inregistrari din bloc (default = 50) pt. navigare
                            //$scope.curProcesIndex.Value -= 1;
                            //$scope.ShowProces($scope.curProcesIndex.Value);
                            $scope.idx = $scope.curProcesIndex.Value - 1;
                            $scope.ShowProces($scope.idx);
                        }
                        else {
                            if ($scope.RowsBlockIndex == 0) {
                                $scope.RowsBlockSize -= 1;
                                //$scope.curProcesIndex.Value = 0;
                                //$scope.ShowProces($scope.curProcesIndex.Value);
                                $scope.ShowProces(0);
                            }
                            else {
                                $scope.RowsBlockIndex -= 1;
                                $scope.RowsBlockSize = $scope.DefaultRowsBlockSize;
                                //$scope.curProcesIndex.Value = $scope.RowsBlockSize - 1;
                                $scope.idx = $scope.RowsBlockSize - 1;
                                $scope.Afisare2(null);
                            }
                        }
                        $scope.$emit('refreshCounterEmitEvent', { object: 'procese', value: -1 });
                    }
                }
                //spinner.stop();
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
                //spinner.stop();
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
            });
    };

    $scope.EnterDeleteMode = function (msg) {
        $rootScope.confirmMessage = msg;
        ngDialog.openConfirm({
            template: 'confirmationDialogId',
            className: 'ngdialog-theme-default'
        }).then(
            function (value) {
                $scope.Delete();
            },
            function (reason) {
                
            });
    };

    $scope.ToggleSearchMode = function () {
        if ($scope.editMode == 1 || $rootScope.ExternalUser.Value == true) return;
        if ($scope.searchMode != 2) {
            $scope.SwitchBackToSearchMode();
        } else {
            //$scope.curProcesIndex.Value = $scope.idx;
            $scope.searchMode = 1;
            $scope.ShowProces($scope.curProcesIndex.Value);
        }
    };

    $scope.OpenContractsDialog = function () {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, true);
        $.ajax({
            async: true,
            type: 'GET',
            url: '/Contracte/Index',
            dataType: 'html'
        }).done(function (data) {
            //alert(data);
            //var htmlContent = $compile(data)($scope);

            //spinner.stop();
            EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);

            ngDialog.openConfirm({
                template: data,
                plain: true,
                className: 'ngdialog-theme-default custom-width',
                controller: 'ContracteController',
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
            EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
        });
    };

    $scope.OpenStadiiDialog = function () {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, true);
        $.ajax({
            async: true,
            type: 'GET',
            url: '/ProceseStadii/Details/' + $scope.model.CurProces.Proces.ID,
            dataType: 'html'
        }).done(function (data) {
            //alert(data);
            //var htmlContent = $compile(data)($scope);

            //spinner.stop();
            EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);

            ngDialog.openConfirm({
                template: data,
                plain: true,
                className: 'ngdialog-theme-default custom-width',
                //controller: 'ProceseStadiiController',
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
            EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
        });
    };

    $scope.popOver = function (objectType) {
        var popoverId = '#popover' + objectType;
        var base_url = $(popoverId).data('poload');
        $(popoverId).popover({
            html: true,
            placement: 'bottom',
            container: 'body',
            content: function () {
                var content_id = "content_id_" + objectType;
                var url = base_url;
                switch (objectType) {
                    case "Calitate":
                        url += $scope.model.procesJson.Calitate;
                        break;
                    case "Reclamant":
                        url += $scope.model.CurProces.Proces.ID_RECLAMANT;
                        break;
                    case "Parat":
                        url += $scope.model.CurProces.Proces.ID_PARAT;
                        break;
                    case "Tert":
                        url += $scope.model.CurProces.Proces.ID_TERT;
                        break;
                    case "TipProces":
                        url += $scope.model.CurProces.Proces.ID_TIP_PROCES;
                        break;
                    case "Instanta":
                        url += $scope.model.CurProces.Proces.ID_INSTANTA;
                        break;
                    case "Complet":
                        url += $scope.model.CurProces.Proces.ID_COMPLET;
                        break;
                }

                $.get(url, function (d) {
                    var ele = $('#' + content_id);
                    var htmlContent = $compile(d)($scope);
                    ele.html(htmlContent);
                    //$compile(ele.contents())(scope);
                    $scope.$broadcast('refreshBroadcastEvent', { objectType: objectType, editMode: $scope.editMode });
                });

                return '<div class="small" style="width:300px;" id="' + content_id + '">Loading...</div>';
            }
        });
    };


    $scope.SwitchDocsPanel = function (item) {
        angular.copy(item, $scope.curStadiuProces);
        $scope.lastDialog = ngDialog.open({
            template: 'proceseStadiiLoader',
            className: 'ngdialog-theme-default custom-width',
            width: 800,
            scope: $scope,
            name: 'dialogDocumenteScanateProcese'
        }).then(
            function (value) {
                $scope.curTipDocumentScanatProces = null;
                alert('succes');
            },
            function (reason) {
                $scope.curTipDocumentScanatProces = null;
                //alert(reason);
            });
    };

    // for multiple files:
    $scope.uploadFiles = function (files) {
        if (files && files.length) {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, true, true);
            $scope.filesLength = files.length;
            var qs = [];
            for (var i = 0; i < files.length; i++) {
                if (files[i] == null || !Upload.isFile(files[i])) break;
                $scope.fileIndex = i;
                //$scope.upload(files[i]); // old version
                ////Upload.upload({..., data: {file: files[i]}, ...})...;
                var x = Upload.upload({
                    url: '/DocumenteScanateProcese/PostFile',
                    data: { file: files[i], tip_document: $scope.curTipDocumentScanatProces, id_proces_stadiu: $scope.curStadiuProces.ProcesStadiu.ID }
                });
                x.then(function (resp) {
                    var result = { ShowMessage: true, Status: true, Message: resp.config.data.file.name, Result: null, InsertedId: null, Error: null };
                    $rootScope.toogleOperationMessage(result);
                    /*
                    $rootScope.operationResult.ShowMessage = true;
                    $rootScope.operationResult.Status = true;
                    $rootScope.operationResult.Message = "";
                    $('#operationResult').show();
                    $("#operationResult").delay(MESSAGE_DELAY).fadeOut(MESSAGE_FADE_OUT);
                    */
                },
                    function (resp) {
                        var message = resp.config.data.file.name + '<br />Status: ' + resp.status + '<br />' + resp.data;
                        var result = { ShowMessage: true, Status: false, Message: message, Result: null, InsertedId: null, Error: null };
                        $rootScope.toogleOperationMessage(result);
                    },
                    function (evt) {
                        var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
                        console.log('progress: ' + progressPercentage + '% ' + evt.config.data.file.name);
                    });

                x.xhr(function (xhr) {
                    // xhr.upload.addEventListener('abort', function(){console.log('abort complete')}, false);
                });

                qs.push(x);
            }
            // or send them all together for HTML5 browsers:
            //Upload.upload({..., data: {file: files}, ...})...;
            $q.all(qs).then(function (response) {
                //$scope.Refresh();
                //spinner.stop();
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
                $scope.docSaved = true;
            }, function (response) {
                var message = 'Status: ' + response.status + '<br />' + response.data;
                var result = { ShowMessage: true, Status: false, Message: message, Result: null, InsertedId: null, Error: null };
                $rootScope.toogleOperationMessage(result);
                EnableDisableInputs('#mainInfoGeneraleDosar', spinner, ACTIVE_DIV_ID, false, true);
                $scope.docSaved = null;
            });
        }
    };

    $scope.SetCurTipDocumentScanatProces = function (curTipDocumentScanatProces) {
        $scope.curTipDocumentScanatProces = curTipDocumentScanatProces;
    };

    $scope.ExportProceseToExcel = function () {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
        EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, true, false)

        $http.post('/Procese/ExportProceseToExcel', { Proces: $scope.TempProcesFilter.CurProces.Proces, procesJson: $scope.TempProcesFilter.procesJson }, {
            //headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            responseType: 'arraybuffer'
        }).then(function (response2) {
            if (response2 != 'null' && response2 != null && response2.data != null) {
                var blob = new Blob([response2.data], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                var objectUrl = URL.createObjectURL(blob);
                window.open(objectUrl);
                ////spinner.stop();
                //$scope.SetCounter($scope._LABEL_EXPORT_DOSARE_IN_EXCEL);
                EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false)
            }
        }, function (response2) {
            //spinner.stop();
            EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false)
            alert('Erroare: ' + response2.status + ' - ' + response2.data);
        });
    };

    $scope.RaportTermene = function () {
        ngDialog.open({
            template: 'raportTermeneDialog',
            className: 'ngdialog-theme-default',
            controller: 'RapoarteController'
        });
    };
});