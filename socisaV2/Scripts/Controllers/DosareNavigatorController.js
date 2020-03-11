'use strict';
'use strict';
var lastkeytime = new Date();
var lastruntime = new Date();
var waiting_interval = 1000; // miliseconds
var lastfiltervalue = "";

//var spinner = new Spinner(opts);
//var spinnerSmall = new Spinner(optsSmall);

function showDosareSideNav(on_off) {
    var dosareSideNav = document.getElementById("dosareSideNav");
    if (on_off) {
        dosareSideNav.style.width = '250px';
    }
    else {
        dosareSideNav.style.width = '0px';
    }
}

$(document).on('click', function (e) {
    var dosareSideNav = document.getElementById("dosareSideNav");
    if (dosareSideNav != null && dosareSideNav != undefined && dosareSideNav.style.width == '250px' && e.target.id.indexOf("ShowListaDosare") == -1) {
        showDosareSideNav(false);
    }
});

$(document).on('keydown', function (e) {
    var dosareSideNav = document.getElementById("dosareSideNav");
    if (e.keyCode === 27 && dosareSideNav != null && dosareSideNav != undefined && dosareSideNav.style.width == '250px') {
        showDosareSideNav(false);
    }
});

app.controller('DosareNavigatorController',
    function ($scope, $http, $filter, $rootScope, $window, $timeout, $compile, ngDialog) {
        $scope.searchMode = 1;
        $scope.TempDosarFilter = {};
        $scope.TempDosarFilter.Dosar = {};
        $scope.TempDosarFilter.dosarJson = {};
        $scope.editMode = 0;

        /*
        $scope.DosarFiltru = {};
        $scope.DosarFiltru.dosarJson = {};
        $scope.DosarFiltru.Dosar = {};
        */

        //$scope.DosarFiltru.DosareResult = [];
        $scope.curDosarIndex = -1;
        $scope.TempDosarEdit = {};
        //$scope.TempDosarFilter.DosareResult = [];
        $scope.result = {};
        $scope.IDSocietateRep = 0;
        $scope.Interactive = false;
        $rootScope.TipDosar = '';

        $scope.DefaultRowsBlockSize = $scope.RowsBlockSize = 50;
        $scope.RowsBlockIndex = 0;
        $scope.RowsCount = 0;
        $scope.idx = 0;
        $scope.mytimeout = null;

        $scope.CountedOperations = [];
        $scope._LABEL_TIPARIRE_CERERE_COMPLETA = { Name: "Tiparire cerere completa", Title: "Tiparire cerere de despagubire completa, inclusiv documente asociate", Value: 0 }; $scope.CountedOperations.push($scope._LABEL_TIPARIRE_CERERE_COMPLETA);
        $scope._LABEL_TIPARIRE_CERERE_FARA_DOCUMENTE = { Name: "Tiparire cerere fara documente", Title: "Tiparire cerere de despagubire simpla, fara documente asociate", Value: 0 }; $scope.CountedOperations.push($scope._LABEL_TIPARIRE_CERERE_FARA_DOCUMENTE);
        $scope._LABEL_TIPARIRE_DOCUMENTE_CERERE = { Name: "Tiparire documente cerere", Title: "Tiparire doar documente asociate cererii de despagubire", Value: 0 }; $scope.CountedOperations.push($scope._LABEL_TIPARIRE_DOCUMENTE_CERERE);
        $scope._LABEL_DESCARCARE_DOCUMENTE_CERERE_GRUPATE = { Name: "Descarcare documente cerere grupate", Title: "Descarca documentele asociate cererii de despagubire, grupate pe tip document", Value: 0 }; $scope.CountedOperations.push($scope._LABEL_DESCARCARE_DOCUMENTE_CERERE_GRUPATE);
        $scope._LABEL_DESCARCARE_DOCUMENTE_CERERE_NEGRUPATE = { Name: "Descarcare documente cerere negrupate", Title: "Descarca documentele asociate cererii de despagubire, negrupate", Value: 0 }; $scope.CountedOperations.push($scope._LABEL_DESCARCARE_DOCUMENTE_CERERE_NEGRUPATE);
        $scope._LABEL_EXPORT_DOSARE_IN_EXCEL = { Name: "Export dosare in Excel", Title: "Export dosare in Excel", Value: 0 }; $scope.CountedOperations.push($scope._LABEL_EXPORT_DOSARE_IN_EXCEL);
        $scope._LABEL_EMAIL_CERERE = { Name: "Email cerere", Title: "Trimitere email cu cererea de despagubire simpla", Value: 0 }; $scope.CountedOperations.push($scope._LABEL_EMAIL_CERERE);

        $scope.$on('refreshEmitEvent', function (event, data) {
            console.log('on: ' + data.objectType + ' - ' + data.object.DENUMIRE);
            switch (data.objectType) {
                case "AsiguratCasco":
                    $scope.DosarFiltru.dosarJson.NumeAsiguratCasco = $scope.TempDosarEdit.dosarJson.NumeAsiguratCasco = data.object.DENUMIRE;
                    break;
                case "AsiguratRca":
                    $scope.DosarFiltru.dosarJson.NumeAsiguratRca = $scope.TempDosarEdit.dosarJson.NumeAsiguratRca = data.object.DENUMIRE;
                    break;
                case "AutoCasco":
                    $scope.DosarFiltru.dosarJson.NumarAutoCasco = $scope.TempDosarEdit.dosarJson.NumarAutoCasco = data.object.NR_AUTO;
                    break;
                case "AutoRca":
                    $scope.DosarFiltru.dosarJson.NumarAutoRca = $scope.TempDosarEdit.dosarJson.NumarAutoRca = data.object.NR_AUTO;
                    break;
                case "SocietateCasco":
                    /* -- daca vrem sa actualizam denumirea din combo
                    for (var i = 0; i < $scope.DosarFiltru.SocietatiCASCO.length; i++) {
                        if (data.object.ID == $scope.DosarFiltru.SocietatiCASCO[i].ID) {
                            $scope.DosarFiltru.SocietatiCASCO[i].DENUMIRE = data.object.DENUMIRE;
                            $scope.DosarFiltru.SocietatiCASCO[i].DENUMIRE_SCURTA = data.object.DENUMIRE_SCURTA;
                            break;
                        }
                    }
                    */
                    break;
                case "SocietateRca":
                    /* -- daca vrem sa actualizam denumirea din combo
                    for (var i = 0; i < $scope.DosarFiltru.SocietatiRCA.length; i++) {
                        if (data.object.ID == $scope.DosarFiltru.SocietatiRCA[i].ID) {
                            $scope.DosarFiltru.SocietatiRCA[i].DENUMIRE = data.object.DENUMIRE;
                            $scope.DosarFiltru.SocietatiRCA[i].DENUMIRE_SCURTA = data.object.DENUMIRE_SCURTA;
                            break;
                        }
                    }
                    */
                    break;
                case "Intervenient":
                    $scope.DosarFiltru.dosarJson.NumeIntervenient = $scope.TempDosarEdit.dosarJson.NumeIntervenient = data.object.DENUMIRE;
                    break;
            }
        });
        /*
        $scope.$on('NewFilterRequestBroadcastEvent', function (event, data) {
            if (data.filter) {
                $scope.DosarFiltru.Dosar.ID = data.newIdDosar;
                $scope.Afisare2(null);
            }
            else {
                $rootScope.ID_DOSAR = null;
                $rootScope.STATUS_DOSAR = null;
                $rootScope.setActiveTab($rootScope.activeTab.Value);
            }
        });
        */

        $scope.$on('NewFilterRequestBroadcastEvent', function (event, data) {
            $scope.DosarFiltru.DosareResult = [];
            $scope.DosarFiltru.Dosar = {};
            $scope.DosarFiltru.dosarJson = {};
            if (data.filter) {
                $scope.idx = $scope.curDosarIndex = 0;
                $scope.DosarFiltru.Dosar.ID = data.newIdDosar;
                $scope.Afisare2(null);
            } else {
                $scope.idx = $scope.curDosarIndex = 0;
                $rootScope.ID_DOSAR = null;
                $rootScope.STATUS_DOSAR = null;
                $rootScope.NR_DOSAR_CASCO = null;
                $rootScope.NR_SCA = null;
                $rootScope.DATA_SCA = null;
                $scope.DosarFiltru.Dosar.COUNT_PROCESE = 0;
                $scope.DosarFiltru.Dosar.COUNT_DOCUMENTE = 0;
                $scope.DosarFiltru.Dosar.COUNT_PLATI = 0;
                $scope.DosarFiltru.Dosar.COUNT_STADII = 0;

                $rootScope.setActiveTab($rootScope.activeTab.Value);
            }
        });

        $scope.$on('refreshCounterBroadcastEvent', function (event, data) {
            switch (data.object) {
                case "documente":
                    if ($scope.DosarFiltru.Dosar.COUNT_DOCUMENTE == null || $scope.DosarFiltru.Dosar.COUNT_DOCUMENTE == undefined)
                        $scope.DosarFiltru.Dosar.COUNT_DOCUMENTE = 0;
                    $scope.DosarFiltru.Dosar.COUNT_DOCUMENTE += data.value;
                    break;
                case "procese":
                    if ($scope.DosarFiltru.Dosar.COUNT_PROCESE == null || $scope.DosarFiltru.Dosar.COUNT_PROCESE == undefined)
                        $scope.DosarFiltru.Dosar.COUNT_PROCESE = 0;
                    $scope.DosarFiltru.Dosar.COUNT_PROCESE += data.value;
                    if (data.value > 0) // insert proces, deci automat este cu/de instanta
                    {
                        $scope.DosarFiltru.Dosar.INSTANTA = "true";
                    }
                    break;
                case "plati":
                    if ($scope.DosarFiltru.Dosar.COUNT_PLATI == null || $scope.DosarFiltru.Dosar.COUNT_PLATI == undefined)
                        $scope.DosarFiltru.Dosar.COUNT_PLATI = 0;
                    $scope.DosarFiltru.Dosar.COUNT_PLATI += data.value;
                    break;
                case "stadii":
                    if ($scope.DosarFiltru.Dosar.COUNT_STADII == null || $scope.DosarFiltru.Dosar.COUNT_STADII == undefined)
                        $scope.DosarFiltru.Dosar.COUNT_STADII = 0;
                    $scope.DosarFiltru.Dosar.COUNT_STADII += data.value;
                    break;
            }
        });

        $scope.onSendStatusChange = function (value) {
            console.log(value);
            for (var i = 0; i < $rootScope.SEND_STATUS.length; i++) {
                if ($rootScope.SEND_STATUS[i].notification == value) {
                    if (!($scope.searchMode == 2 || ($scope.searchMode == 1 && ($scope.curDosarIndex == -1 || $scope.DosarFiltru.Dosar.ID == null)))) {
                        $("#sendStatusDiv").css("background-color", $rootScope.SEND_STATUS[i].back_color);
                        $("#sendStatusDiv").css("color", $rootScope.SEND_STATUS[i].fore_color);
                        console.log($rootScope.SEND_STATUS[i].back_color);
                    }
                    break;
                }
            }
        };

        $scope.$watch('DosarFiltru.Dosar.COUNT_DOCUMENTE', function (newValue, oldValue) {
            $("#nrDocumenteDosar").text($scope.DosarFiltru.Dosar.COUNT_DOCUMENTE);
        });
        $scope.$watch('DosarFiltru.Dosar.COUNT_PROCESE', function (newValue, oldValue) {
            $("#nrProceseDosar").text($scope.DosarFiltru.Dosar.COUNT_PROCESE);
        });
        $scope.$watch('DosarFiltru.Dosar.COUNT_PLATI', function (newValue, oldValue) {
            $("#nrPlatiDosar").text($scope.DosarFiltru.Dosar.COUNT_PLATI);
        });
        $scope.$watch('DosarFiltru.Dosar.COUNT_STADII', function (newValue, oldValue) {
            $("#nrStadiiDosar").text($scope.DosarFiltru.Dosar.COUNT_STADII);
        });

        $scope.$on('paymentUpdateBroadcastEvent', function (event, data) {
            console.log('on: ' + data.updateType + ' - ' + (data.oldPlata == null ? '' : data.oldPlata.SUMA) + ' - ' + (data.newPlata == null ? '' : data.newPlata.SUMA));
            /*
            switch (data.updateType) {
                case "insert":
                    $scope.DosarFiltru.Dosar.REZERVA_DAUNA = parseFloat($scope.DosarFiltru.Dosar.REZERVA_DAUNA) - parseFloat(data.newPlata.SUMA);
                    break;
                case "update":
                    $scope.DosarFiltru.Dosar.REZERVA_DAUNA = parseFloat($scope.DosarFiltru.Dosar.REZERVA_DAUNA) - parseFloat(parseFloat(data.newPlata.SUMA) - parseFloat(data.oldPlata.SUMA));
                    break;
                case "delete":
                    $scope.DosarFiltru.Dosar.REZERVA_DAUNA = parseFloat($scope.DosarFiltru.Dosar.REZERVA_DAUNA) + parseFloat(data.oldPlata.SUMA);
                    break;
            }
            */
            $scope.ShowDosar($scope.curDosarIndex);
        });

        $scope.SetId = function (id) {
            console.log('Set id: ' + id);
            $rootScope.ID_DOSAR = id;
            //$scope.DosarFiltru.Dosar.ID = $rootScope.ID_DOSAR = id;
            //angular.copy($scope.DosarFiltru, $scope.TempDosarFilter);
            //$scope.DosarFiltru.DosareResult = [];
            //$scope.DosarFiltru.DosareResult.push($scope.DosarFiltru.Dosar);
            $scope.ShowDosar(0);
        };

        $scope.$watch('searchMode', function (newValue, oldValue) {
            $rootScope.searchMode = newValue;

            if (newValue == 2) {
                $("#sendStatusDiv").css("background-color", "white");
                $("#sendStatusDiv").css("color", "black");
            }
        });

        $scope.$watch('editMode', function (newValue, oldValue) {
            $rootScope.editMode = newValue;
        });

        $rootScope.$watch('EMPTY_ID_DOSAR', function (newValue, oldValue) {
            if (newValue == 1) {
                $rootScope.NR_DOSAR_CASCO = null;
                $rootScope.NR_SCA = null;
                $rootScope.DATA_SCA = null;
            }
        });

        $rootScope.$watch('ID_DOSAR', function (newValue, oldValue) {
            if (newValue == null || newValue == 'undefined' || newValue == '') {
                $rootScope.NR_DOSAR_CASCO = null;
                $rootScope.NR_SCA = null;
                $rootScope.DATA_SCA = null;
            }

            if (newValue != oldValue && newValue != null && $rootScope.activeTab.Value == "detalii") {
                $scope.GetCounters();

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

        $rootScope.$watch('activeTab.Value', function (newValue, oldValue) {
            if (newValue == 'detalii' && $rootScope.ID_DOSAR != null && $rootScope.ID_DOSAR != undefined && $scope.lastActiveIdDosar != $rootScope.ID_DOSAR) {

            }
        });

        $scope.$watch('DosarFiltru.Dosar.ID', function (newValue, oldValue) {
            if ($rootScope.activeTab.Value != 'procese') {
                if (newValue == null) {
                    $rootScope.switchTabsClass("#lnkDosareDetalii");
                }
                if (newValue != null && newValue != oldValue) {
                    $rootScope.AVIZAT = $scope.DosarFiltru.dosarJson.IsAvizat;
                }
                /*
                if (newValue != undefined && newValue != "" && newValue != null && newValue == oldValue) {
                    $rootScope.AVIZAT = $scope.DosarFiltru.dosarJson.IsAvizat;
                    $scope.DosarFiltru.DosareResult = [];
                    $scope.DosarFiltru.DosareResult.push($scope.DosarFiltru.Dosar);
                    $scope.TempDosarFilter.DosareResult = [];
                    $scope.TempDosarFilter.DosareResult.push($scope.DosarFiltru.Dosar);
                    $scope.curDosarIndex = 0;
                    $scope.ShowDosar($scope.curDosarIndex);
                }
                */
            }
        });

        $rootScope.$watch('calitateSocietateCurenta.Value', function (newValue, oldValue) {
            if (newValue != oldValue) {
                $scope.ClearFilters();
            }
        });

        $scope.$watch('editMode', function (newValue, oldValue) {
            document.getElementById('Dosar_DATA_EVENIMENT').disabled = !(newValue == 1);
            document.getElementById('Dosar_DATA_SCA').disabled = !(newValue == 1);
            document.getElementById('Dosar_DATA_AVIZARE').disabled = !(newValue == 1);
            document.getElementById('Dosar_DATA_NOTIFICARE').disabled = !(newValue == 1);
            document.getElementById('Dosar_DATA_CREARE').disabled = !(newValue == 1);
            document.getElementById('Dosar_DATA_ULTIMEI_MODIFICARI').disabled = !(newValue == 1);
            document.getElementById('Dosar_DATA_IESIRE_CASCO').disabled = !(newValue == 1);
            document.getElementById('Dosar_DATA_INTRARE_RCA').disabled = !(newValue == 1);
            document.getElementById('societateRcaSelect').disabled = !(newValue == 1);
            document.getElementById('tipCazSelect').disabled = !(newValue == 1);
            document.getElementById('tipDosarSelect').disabled = !(newValue == 1);
            document.getElementById('statusDosarSelect').disabled = !(newValue == 1);
            document.getElementById('sendStatusSelect').disabled = !(newValue == 1);
        });
        $scope.$watch('searchMode', function (newValue, oldValue) {
            document.getElementById('societateCascoSelect').disabled = !(newValue == 2 && $rootScope.calitateSocietateCurenta.Value == 'RCA');
            document.getElementById('societateRcaSelect').disabled = !((newValue == 2 || $scope.editMode == 1) && $rootScope.calitateSocietateCurenta.Value == 'CASCO');
            document.getElementById('tipCazSelect').disabled = newValue != 2 && $scope.editMode != 1;
            document.getElementById('tipDosarSelect').disabled = newValue != 2 && $scope.editMode != 1;
            document.getElementById('statusDosarSelect').disabled = newValue != 2 && $scope.editMode != 1;
            document.getElementById('sendStatusSelect').disabled = newValue != 2 && $scope.editMode != 1;
        });

        $scope.$watch('DosarFiltru.Dosar.STATUS', function (newValue, oldValue) {
            console.log('afisare - ' + newValue + ' - ' + $scope.Interactive);
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('DosarFiltru.Dosar.SEND_STATUS', function (newValue, oldValue) {
            console.log('afisare - ' + newValue + ' - ' + $scope.Interactive);

            //$scope.onSendStatusChange(newValue);

            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('DosarFiltru.Dosar.ID_SOCIETATE_RCA', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('DosarFiltru.Dosar.ID_SOCIETATE_CASCO', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('DosarFiltru.Dosar.CAZ', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('DosarFiltru.Dosar.ID_TIP_DOSAR', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });

        $scope.$watch('DosarFiltru.dosarJson.DataEvenimentEnd', function (newValue, oldValue) {
            if (newValue != oldValue && $scope.searchMode == 2) {
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('DosarFiltru.dosarJson.DataScaEnd', function (newValue, oldValue) {
            if (newValue != oldValue && $scope.searchMode == 2) {
                //console.log('afisare - DataEvenimentEnd');
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('DosarFiltru.dosarJson.DataAvizareEnd', function (newValue, oldValue) {
            if (newValue != oldValue && $scope.searchMode == 2) {
                //console.log('afisare - DataAvizareEnd');
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('DosarFiltru.dosarJson.DataNotificareEnd', function (newValue, oldValue) {
            if (newValue != oldValue && $scope.searchMode == 2) {
                //console.log('afisare - DataNotificareEnd');
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('DosarFiltru.dosarJson.DataCreareEnd', function (newValue, oldValue) {
            if (newValue != oldValue && $scope.searchMode == 2) {
                //console.log('afisare - DataCreareEnd');
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('DosarFiltru.dosarJson.DataUltimeiModificariEnd', function (newValue, oldValue) {
            if (newValue != oldValue && $scope.searchMode == 2) {
                //console.log('afisare - DataUltimeiModificariEnd');
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('DosarFiltru.dosarJson.DataIesireCascoEnd', function (newValue, oldValue) {
            if (newValue != oldValue && $scope.searchMode == 2) {
                //console.log('afisare - DataIesireCascoEnd');
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('DosarFiltru.dosarJson.DataIntrareRcaEnd', function (newValue, oldValue) {
            if (newValue != oldValue && $scope.searchMode == 2) {
                //console.log('afisare - DataIntrareRcaEnd');
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('DosarFiltru.dosarJson.DosarFaraDocumente', function (newValue, oldValue) {
            if (newValue != oldValue && $scope.searchMode == 2) {
                //console.log('afisare - DataEvenimentEnd');
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('DosarFiltru.dosarJson.DosarFaraProces', function (newValue, oldValue) {
            if (newValue != oldValue && $scope.searchMode == 2) {
                //console.log('afisare - DataEvenimentEnd');
                $scope.Afisare(newValue, null);
            }
        });
        $scope.$watch('DosarFiltru.Dosar.INSTANTA', function (newValue, oldValue) {
            if (newValue != oldValue && newValue != null && newValue != undefined && $scope.Interactive) {
                if ($scope.searchMode == 2) {
                    $scope.Afisare(newValue, null);
                }
            }
        });
        $scope.$watch('DosarFiltru.Dosar.DATA_EVENIMENT', function (newDate, oldDate) {
            //alert(newDate+' - '+oldDate);
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.DosarFiltru.Dosar.DATA_EVENIMENT = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });
        $scope.$watch('DosarFiltru.Dosar.DATA_SCA', function (newDate) {
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.DosarFiltru.Dosar.DATA_SCA = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });
        $scope.$watch('DosarFiltru.Dosar.DATA_AVIZARE', function (newDate) {
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.DosarFiltru.Dosar.DATA_AVIZARE = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });
        $scope.$watch('DosarFiltru.Dosar.DATA_NOTIFICARE', function (newDate) {
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.DosarFiltru.Dosar.DATA_NOTIFICARE = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });
        $scope.$watch('DosarFiltru.Dosar.DATA_CREARE', function (newDate) {
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.DosarFiltru.Dosar.DATA_CREARE = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });
        $scope.$watch('DosarFiltru.Dosar.DATA_ULTIMEI_MODIFICARI', function (newDate) {
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.DosarFiltru.Dosar.DATA_ULTIMEI_MODIFICARI = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });
        $scope.$watch('DosarFiltru.Dosar.DATA_IESIRE_CASCO', function (newDate) {
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.DosarFiltru.Dosar.DATA_IESIRE_CASCO = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });
        $scope.$watch('DosarFiltru.Dosar.DATA_INTRARE_RCA', function (newDate) {
            if (newDate == null || newDate == undefined || newDate.length <= 10 || angular.isDate(newDate)) { return; }
            $scope.DosarFiltru.Dosar.DATA_INTRARE_RCA = $filter('date')(new Date(parseInt(newDate.substr(6))), $rootScope.DATE_FORMAT);
        });

        $scope.formatDate = function (dateValue) {
            return $filter('date')(new Date(parseInt(dateValue.substr(6))), $rootScope.DATE_FORMAT);
        }

        $scope.compareObjects = function (o1, o2) {
            return angular.equals(o1, o2);
        }

        $scope.ClearFilters = function () {
            console.log("ClearFilters - " + $rootScope.ID_DOSAR);

            $scope.searchMode = 1;
            $rootScope.ID_DOSAR = null;
            $scope.Interactive = false;
            //$scope.TempDosarFilter = {};
            $scope.TempDosarFilter.Dosar = {};
            $scope.TempDosarFilter.dosarJson = {};
            //$scope.DosarFiltru = {};
            $scope.DosarFiltru.dosarJson = {};
            $scope.DosarFiltru.Dosar = {};

            $scope.DosarFiltru.DosareResult = undefined;
            document.getElementById('societateCascoSelect').disabled = !($scope.searchMode == 2 && $rootScope.calitateSocietateCurenta.Value == 'RCA');
            document.getElementById('societateRcaSelect').disabled = !(($scope.searchMode == 2 || $scope.editMode == 1) && $rootScope.calitateSocietateCurenta.Value == 'CASCO');

            if ($rootScope.calitateSocietateCurenta.Value == "CASCO") {
                $scope.DosarFiltru.Dosar.ID_SOCIETATE_CASCO = $scope.TempDosarFilter.Dosar.ID_SOCIETATE_CASCO = $scope.IDSocietateRep;
                $scope.DosarFiltru.Dosar.ID_SOCIETATE_RCA = $scope.TempDosarFilter.Dosar.ID_SOCIETATE_RCA = null;
                $scope.DosarFiltru.dosarJson.CalitateSocietate = $scope.TempDosarFilter.dosarJson.CalitateSocietate = null;
            }
            if ($rootScope.calitateSocietateCurenta.Value == "RCA") {
                $scope.DosarFiltru.Dosar.ID_SOCIETATE_RCA = $scope.TempDosarFilter.Dosar.ID_SOCIETATE_RCA = $scope.IDSocietateRep;
                $scope.DosarFiltru.Dosar.ID_SOCIETATE_CASCO = $scope.TempDosarFilter.Dosar.ID_SOCIETATE_CASCO = null;
                //$scope.DosarFiltru.Dosar.STATUS = $scope.TempDosarFilter.Dosar.STATUS = 'AVIZAT';
                //document.getElementById("Dosar_AVIZAT").disabled = true;
                $scope.DosarFiltru.dosarJson.CalitateSocietate = $scope.TempDosarFilter.dosarJson.CalitateSocietate = "RCA";
                document.getElementById("statusDosarSelect").disabled = true;
                document.getElementById("sendStatusSelect").disabled = true;
            }

            $scope.RowsBlockIndex = 0;
            $scope.DosarFiltru.dosarJson.LimitStart = $scope.RowsBlockIndex * $scope.RowsBlockSize;
            $scope.DosarFiltru.dosarJson.LimitEnd = $scope.RowsBlockSize;
            $scope.idx = $scope.curDosarIndex = 0;
            $scope.Afisare2(null);
        };

        $scope.Afisare = function (e, sender) {
            if ($scope.editMode == 1 || $rootScope.ExternalUser.Value == true) return;
            var direct = sender == null;
            /*
            if ($scope.searchMode == 2)
                angular.copy($scope.DosarFiltru, $scope.TempDosarFilter);
            */

            if ($scope.searchMode == 2) {
                angular.copy($scope.DosarFiltru.Dosar, $scope.TempDosarFilter.Dosar);
                angular.copy($scope.DosarFiltru.dosarJson, $scope.TempDosarFilter.dosarJson);
            }

            var now = new Date();
            var filter_value = e;
            console.log("afisare: " + (now - lastkeytime) + ' - ' + waiting_interval + ' - ' + e + ' - ' + direct + ' - ' + lastfiltervalue + ' - ' + filter_value + ' - ' + $scope.Interactive);
            //if ((now - lastkeytime <= waiting_interval && lastfiltervalue != filter_value) || (filter_value.length < 3 && !direct)) {
            if (!direct && now - lastkeytime <= waiting_interval && $scope.Interactive) {
                //setTimeout(Afisare, now - lastkeytime);
                $timeout.cancel($scope.mytimeout);
                $scope.mytimeout = $timeout(function () { $scope.Afisare(e, sender); }, waiting_interval);
                lastkeytime = now;
                return;
            }
            else {
                if ((direct || lastfiltervalue != filter_value) && $scope.Interactive) {
                    console.log("afisare2: " + direct + ' - ' + lastfiltervalue + ' - ' + filter_value + ' - ' + $scope.Interactive);
                    //if (filter_value !== "") {
                    $scope.RowsBlockIndex = 0;
                    $scope.curDosarIndex = $scope.idx = 0;
                    $scope.Afisare2(e);
                    lastkeytime = now;
                    lastfiltervalue = filter_value;
                    //return;
                    //}
                }
            }
            $scope.Interactive = false;
        };

        $scope.Afisare2 = function (input_value) {
            //spinner = new Spinner(opts).spin(document.getElementById(ACTIVE_DIV_ID));
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);

            $scope.DosarFiltru.dosarJson.LimitStart = $scope.RowsBlockIndex * $scope.RowsBlockSize;
            $scope.DosarFiltru.dosarJson.LimitEnd = $scope.RowsBlockSize;

            //var data = $scope.DosarFiltru;
            //$http.post('/Dosare/Search', $scope.DosarFiltru, { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } })
            $http.post('/Dosare/Search', { Dosar: $scope.DosarFiltru.Dosar, dosarJson: $scope.DosarFiltru.dosarJson }, { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } })
                .then(function (response) {
                    $scope.Interactive = false;
                    if (response != 'null' && response != null && response.data != null && response.data.Result != null && response.data.Result != "") {
                        //$scope.result = response.data;
                        $scope.DosarFiltru.DosareResult = response.data.Result;
                        $scope.TempDosarFilter.DosareResult = response.data.Result;
                        $scope.RowsCount = response.data.InsertedId; // artificiu pt. aducerea nr.-ului total de inregistrari filtrate
                        /*
                        $scope.curDosarIndex = 0;
                        $scope.ShowDosar($scope.curDosarIndex);
                        */

                        // daca vrem sa activam navigarea doar din buton, comentam urmatoarele 2 linii
                        $scope.curDosarIndex = $scope.idx;
                        $scope.ShowDosar($scope.curDosarIndex);
                    }
                    else {
                        //$scope.searchMode = 2;
                        //$scope.TempDosarFilter.DosareResult = undefined;
                        $scope.RowsCount = 0;
                        $scope.curDosarIndex = $scope.idx = -1;

                        //angular.copy($scope.TempDosarFilter, $scope.DosarFiltru);
                        //angular.copy($scope.TempDosarFilter.Dosar, $scope.DosarFiltru.Dosar);
                        //angular.copy($scope.TempDosarFilter.dosarJson, $scope.DosarFiltru.dosarJson);
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                    lastruntime = new Date();
                    lastfiltervalue = input_value;
                }, function (response) {
                    $scope.Interactive = false;
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                });
        };

        $scope.SwitchBackToSearchMode = function () {
            if ($scope.editMode == 1 || $rootScope.ExternalUser.Value == true) return;
            $scope.searchMode = 2;
            $rootScope.ID_DOSAR = null;
            console.log("SwitchBackToSearchMode - " + $rootScope.ID_DOSAR);
            ////angular.copy($scope.TempDosarFilter, $scope.DosarFiltru);
            //angular.copy($scope.TempDosarFilter.Dosar, $scope.DosarFiltru.Dosar);
            //angular.copy($scope.TempDosarFilter.dosarJson, $scope.DosarFiltru.dosarJson);
            $scope.switchTempToDosarObjects();
            $rootScope.switchTabsClass("#lnkDosareDetalii");
        };

        $scope.switchTempToDosarObjects = function () {
            angular.copy($scope.TempDosarFilter.Dosar, $scope.DosarFiltru.Dosar);
            angular.copy($scope.TempDosarFilter.dosarJson, $scope.DosarFiltru.dosarJson);
        };

        $scope.firstDosar = function () {
            if ($scope.DosarFiltru.DosareResult != undefined) {
                if ($scope.RowsBlockIndex <= 0 && $scope.curDosarIndex <= 0) return;

                if ($scope.RowsBlockIndex > 0) {
                    $scope.switchTempToDosarObjects();
                    $scope.RowsBlockSize = $scope.DefaultRowsBlockSize; // reinitializam RowsBlockSize pt. situatia in care au fost stergeri
                    $scope.RowsBlockIndex = 0;
                    $scope.idx = 0;
                    $scope.Afisare2(null);
                }
                else {
                    $scope.idx = 0;
                    $scope.ShowDosar($scope.idx);
                }
            }
        };

        $scope.prevDosar = function () {
            if ($scope.DosarFiltru.DosareResult != undefined) {
                if ($scope.RowsBlockIndex <= 0 && $scope.curDosarIndex <= 0) return;

                //if (Math.floor(($scope.curDosarIndex - 1) / $scope.RowsBlockSize) < Math.floor($scope.curDosarIndex / $scope.RowsBlockSize)) {
                if ($scope.curDosarIndex == 0) {
                    $scope.switchTempToDosarObjects();
                    $scope.RowsBlockSize = $scope.DefaultRowsBlockSize; // reinitializam RowsBlockSize pt. situatia in care au fost stergeri
                    $scope.RowsBlockIndex = $scope.RowsBlockIndex - 1;
                    $scope.idx = $scope.RowsBlockSize - 1;
                    $scope.Afisare2(null);
                }
                else {
                    $scope.idx = $scope.curDosarIndex - 1;
                    $scope.ShowDosar($scope.idx);
                }
            }
        };

        $scope.nextDosar = function () {
            if ($scope.DosarFiltru.DosareResult != undefined) {
                if ($scope.RowsCount <= $scope.RowsBlockIndex * $scope.RowsBlockSize + $scope.curDosarIndex + 1 || $scope.RowsCount <= $scope.curDosarIndex + 1) return;

                if ($scope.curDosarIndex == $scope.RowsBlockSize - 1) {
                    $scope.switchTempToDosarObjects();
                    $scope.RowsBlockSize = $scope.DefaultRowsBlockSize; // reinitializam RowsBlockSize pt. situatia in care au fost stergeri
                    $scope.RowsBlockIndex = $scope.RowsBlockIndex + 1;
                    $scope.idx = 0;
                    $scope.Afisare2(null);
                }
                else {
                    $scope.idx = $scope.curDosarIndex + 1;
                    $scope.ShowDosar($scope.idx);
                }
            }
        };

        $scope.lastDosar = function () {
            if ($scope.DosarFiltru.DosareResult != undefined) {
                if ($scope.RowsCount <= $scope.RowsBlockIndex * $scope.RowsBlockSize + $scope.curDosarIndex + 1 || $scope.RowsCount <= $scope.curDosarIndex + 1) return;

                if ($scope.RowsBlockIndex < Math.floor($scope.RowsCount / $scope.RowsBlockSize)) {
                    $scope.switchTempToDosarObjects();
                    $scope.RowsBlockSize = $scope.DefaultRowsBlockSize; // reinitializam RowsBlockSize pt. situatia in care au fost stergeri
                    $scope.RowsBlockIndex = Math.floor($scope.RowsCount / $scope.RowsBlockSize);
                    $scope.idx = $scope.RowsCount % $scope.RowsBlockSize - 1;
                    $scope.Afisare2(null);
                }
                else {
                    $scope.idx = $scope.RowsCount % $scope.RowsBlockSize - 1;
                    $scope.ShowDosar($scope.idx);
                }
            }
        };

        $scope.ShowDosar = function (index) {
            if (index < 0 || $scope.DosarFiltru.DosareResult == null || $scope.DosarFiltru.DosareResult.length < 1 || $scope.searchMode == 2) return; // searchMode == 2 e pt. afisare doar din buton
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            //$rootScope.validForAvizare = null;
            $rootScope.validForTiparire = false;
            console.log('ShowDosar ID_DOSAR = ' + $rootScope.ID_DOSAR);
            $scope.searchMode = 1;
            $scope.curDosarIndex = index;

            if ($scope.DosarFiltru.Dosar == null || $scope.DosarFiltru.Dosar == undefined) {
                $scope.DosarFiltru.Dosar = {};
                $scope.DosarFiltru.Dosar.ID_SOCIETATE_CASCO = $scope.TempDosarEdit.Dosar.ID_SOCIETATE_CASCO;
            }

            if (!angular.equals($scope.DosarFiltru.DosareResult[index], $scope.DosarFiltru.Dosar)) {
                //alert('aci');
                angular.copy($scope.DosarFiltru.DosareResult[index], $scope.DosarFiltru.Dosar); // !!!!!!!
                //$scope.DosarFiltru.Dosar = angular.copy($scope.DosarFiltru.DosareResult[index]); // !!!!!!!
            }
            $rootScope.ID_DOSAR = $scope.DosarFiltru.Dosar.ID;
            $rootScope.NR_DOSAR_CASCO = $scope.DosarFiltru.Dosar.NR_DOSAR_CASCO;
            $rootScope.NR_SCA = $scope.DosarFiltru.Dosar.NR_SCA;
            $rootScope.DATA_SCA = $scope.DosarFiltru.Dosar.DATA_SCA;

            //spinner = new Spinner(opts).spin(document.getElementById(ACTIVE_DIV_ID));
            //$scope.DosarFiltru.Dosar.DATA_EVENIMENT = $scope.formatDate($scope.DosarFiltru.Dosar.DATA_EVENIMENT);
            var data = $scope.DosarFiltru.Dosar.ID;
            $http.get('/Dosare/Details/' + data, {
                headers:
                    { 'Content-Type': 'application/x-www-form-urlencoded' }
            }).then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    var j = JSON.parse(response.data);
                    try {
                        if ($scope.DosarFiltru.dosarJson == null || $scope.DosarFiltru.dosarJson == undefined || $scope.DosarFiltru.dosarJson == "undefined")
                            $scope.DosarFiltru.dosarJson = {};
                        $rootScope.TipDosar = $scope.GetTipDosar();
                        $scope.DosarFiltru.dosarJson.NumeAsiguratCasco = j.aCasco.DENUMIRE;
                        $scope.DosarFiltru.dosarJson.NumeAsiguratRca = j.aRca.DENUMIRE;
                        $scope.DosarFiltru.dosarJson.NumarAutoCasco = j.autoCasco.NR_AUTO;
                        $scope.DosarFiltru.dosarJson.NumarAutoRca = j.autoRca.NR_AUTO;
                        $scope.DosarFiltru.dosarJson.NumeIntervenient = j.intervenient.DENUMIRE;
                        //$scope.DosarFiltru.dosarJson.TipDosar = j.tipDosar.DENUMIRE;
                        //$rootScope.validForAvizare = j.validForAvizare;
                        $rootScope.AVIZAT = j.IsAvizat;
                        $rootScope.STATUS_DOSAR = $scope.DosarFiltru.Dosar.STATUS = j.NewStatus;
                        //$scope.switchTabsClass("#lnkDosareDetalii");
                        $rootScope.setActiveTab($rootScope.activeTab.Value);
                        $rootScope.VALOARE_REGRES = $scope.DosarFiltru.Dosar.VALOARE_REGRES; // pentru afisare info suplimentar in DocumenteScanate 
                        $scope.DosarFiltru.dosarJson.DosarFaraDocumente = j.dosarFaraDocumente;
                        $scope.DosarFiltru.dosarJson.DosarFaraProces = j.dosarFaraProces;
                        $scope.DosarFiltru.Dosar.INSTANTA = $scope.DosarFiltru.Dosar.INSTANTA == true || $scope.DosarFiltru.Dosar.INSTANTA == false ? $scope.DosarFiltru.Dosar.INSTANTA + "" : "";
                        /*
                        $("#nrDocumenteDosar").text(j.nrDocumente);
                        $("#nrProceseDosar").text(j.nrProcese);
                        $("#nrPlatiDosar").text(j.nrPlati);
                        */
                        $scope.onSendStatusChange($scope.DosarFiltru.Dosar.SEND_STATUS);
                    } catch (e) { }
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                }
                //spinner.stop();
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                //spinner.stop();
            });
        };

        $rootScope.$on('ShowDosarBroadcastEvent', function (event, data) {
            if (data) {
                $scope.ShowDosar($scope.curDosarIndex);
            }
        });

        $rootScope.$on('updateDosarStatusEmitEvent', function (event, data) {
            $scope.ChangeStatusDosar(data ? 'NEAVIZAT' : 'INCOMPLET');
        });

        $scope.ChangeStatusDosar = function (_status) {
            $http.post('/Dosare/ChangeStatus', { id: $rootScope.ID_DOSAR, status: _status })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        var d = new Date();
                        var ds = (((d.getDate() < 10 ? "0" : "") + d.getDate()) + "." + ((d.getMonth() + 1 < 10 ? "0" : "") + (d.getMonth() + 1)) + "." + d.getFullYear());
                        $scope.DosarFiltru.Dosar.STATUS = _status;
                        $scope.DosarFiltru.Dosar.DATA_ULTIMEI_MODIFICARI = ds;
                        $scope.DosarFiltru.DosareResult[$scope.curDosarIndex].STATUS = _status;
                        $scope.DosarFiltru.DosareResult[$scope.curDosarIndex].DATA_ULTIMEI_MODIFICARI = ds;
                        $rootScope.switchTabsClass($rootScope.activeTab.Value);
                    }
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.CheckChanged = function (e) {
            if ($scope.searchMode == 2) {
                $scope.Afisare2(e.target.checked);
            }
        };

        $scope.GetTipDosar = function () {
            for (var i = 0; i < $scope.DosarFiltru.TipuriDosar.length; i++) {
                if ($scope.DosarFiltru.TipuriDosar[i].ID == $scope.DosarFiltru.Dosar.ID_TIP_DOSAR) {
                    return $scope.DosarFiltru.TipuriDosar[i].DENUMIRE;
                }
            }
        };

        $scope.EnterEditMode = function () {
            $scope.searchMode = 0;
            $scope.editMode = 1;
            angular.copy($scope.DosarFiltru, $scope.TempDosarEdit);
        };

        $scope.EnterAddMode = function () {
            $scope.searchMode = 0;
            $scope.editMode = 1;
            angular.copy($scope.DosarFiltru, $scope.TempDosarEdit);
            $scope.DosarFiltru.Dosar = {};
            $scope.DosarFiltru.dosarJson = {};
            $scope.DosarFiltru.Dosar.ID_SOCIETATE_CASCO = $scope.TempDosarEdit.Dosar.ID_SOCIETATE_CASCO;
            $scope.DosarFiltru.Dosar.STATUS = 'INCOMPLET';
            $scope.DosarFiltru.Dosar.SEND_STATUS = null;
        };

        $scope.SaveEdit = function () {
            $scope.editMode = 2;
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);

            //var data = $scope.DosarFiltru;
            /*
            try {
                data.Dosar.DATA_EVENIMENT = new Date(parseInt(data.Dosar.DATA_EVENIMENT.substr(6)));
            } catch (e) { data.Dosar.DATA_EVENIMENT = null; }
            try {
                data.Dosar.DATA_SCA = new Date(parseInt(data.Dosar.DATA_SCA.substr(6)));
            } catch (e) { data.Dosar.DATA_SCA = null; }
            try {
                data.Dosar.DATA_AVIZARE = new Date(parseInt(data.Dosar.DATA_AVIZARE.substr(6)));
            } catch (e) { data.Dosar.DATA_AVIZARE = null; }
            try {
                data.Dosar.DATA_NOTIFICARE = new Date(parseInt(data.Dosar.DATA_NOTIFICARE.substr(6)));
            } catch (e) { data.Dosar.DATA_NOTIFICARE = null; }
            try {
                data.Dosar.DATA_ULTIMEI_MODIFICARI = new Date(parseInt(data.Dosar.DATA_ULTIMEI_MODIFICARI.substr(6)));
            } catch (e) { data.Dosar.DATA_ULTIMEI_MODIFICARI = null; }
            try {
                data.Dosar.DATA_IESIRE_CASCO = new Date(parseInt(data.Dosar.DATA_IESIRE_CASCO.substr(6)));
            } catch (e) { data.Dosar.DATA_IESIRE_CASCO = null; }
            try {
                data.Dosar.DATA_INTRARE_RCA = new Date(parseInt(data.Dosar.DATA_INTRARE_RCA.substr(6)));
            } catch (e) { data.Dosar.DATA_INTRARE_RCA = null; }
            */
            //$http.post('/Dosare/Edit', data)
            $http.post('/Dosare/Edit', { Dosar: $scope.DosarFiltru.Dosar, dosarJson: $scope.DosarFiltru.dosarJson })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        $scope.result = response.data;
                        $rootScope.toogleOperationMessage($scope.result);
                        /*
                        $rootScope.operationResult.ShowMessage = true;
                        $rootScope.operationResult.Status = $scope.result.Status;
                        $rootScope.operationResult.Message = $scope.result.Message;
                        $('#operationResult').show();
                        $("#operationResult").delay(MESSAGE_DELAY).fadeOut(MESSAGE_FADE_OUT);
                        */
                        if ($scope.result.Status) {

                            $scope.DosarFiltru.Dosar = JSON.parse(response.data.Message); //!!!

                            $scope.editMode = 0;
                            $scope.searchMode = 1;
                            $rootScope.validForTiparire = false;
                            if ($scope.result.InsertedId != null) {
                                $scope.DosarFiltru.Dosar.ID = $scope.result.InsertedId;
                                if ($scope.DosarFiltru.DosareResult == undefined || $scope.DosarFiltru.DosareResult == null) {
                                    $scope.DosarFiltru.DosareResult = [{}];
                                    $scope.curDosarIndex = 0;
                                    //angular.copy($scope.DosarFiltru.Dosar, $scope.DosarFiltru.DosareResult[$scope.curDosarIndex]);
                                }
                                else {
                                    /*
                                    //$scope.DosarFiltru.DosareResult.push($scope.DosarFiltru.Dosar);
                                    //$scope.curDosarIndex = $scope.DosarFiltru.DosareResult.length - 1;
                                    */
                                    $scope.DosarFiltru.DosareResult.push({});
                                    $scope.curDosarIndex = $scope.DosarFiltru.DosareResult.length - 1;
                                    //angular.copy($scope.DosarFiltru.Dosar, $scope.DosarFiltru.DosareResult[$scope.curDosarIndex]);
                                }
                                $scope.$emit('refreshDashboardEmitEvent', { object: 'dosare', value: 1 });
                            }
                            else {
                                //angular.copy($scope.DosarFiltru.Dosar, $scope.DosarFiltru.DosareResult[$scope.curDosarIndex]);
                            }
                            angular.copy($scope.DosarFiltru.Dosar, $scope.DosarFiltru.DosareResult[$scope.curDosarIndex]);
                            $scope.ShowDosar($scope.curDosarIndex);
                        }
                        else {
                            $scope.searchMode = 0;
                            $scope.editMode = 1;
                        }
                    } else {
                        $scope.searchMode = 0;
                        $scope.editMode = 1;
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                });
        };

        $scope.CancelEdit = function () {
            $scope.editMode = 0;
            $scope.searchMode = 1;
            angular.copy($scope.TempDosarEdit, $scope.DosarFiltru);
            if ($rootScope.calitateSocietateCurenta.Value == "CASCO")
                $scope.DosarFiltru.Dosar.ID_SOCIETATE_CASCO = $scope.IDSocietateRep;
            else
                $scope.DosarFiltru.Dosar.ID_SOCIETATE_RCA = $scope.IDSocietateRep;
            console.log("CancelEdit - " + $scope.TempDosarEdit.Dosar.ID_SOCIETATE_CASCO);
        };

        $scope.EnterSendMode = function (msg) {
            if ($scope._LABEL_EMAIL_CERERE.Value > 1) {
                $rootScope.confirmMessage = msg;
                ngDialog.openConfirm({
                    template: 'confirmationDialogId',
                    className: 'ngdialog-theme-default'
                }).then(
                    function (value) {
                        $scope.TrimitereEmail();
                    },
                    function (reason) {

                    });
            } else {
                $scope.TrimitereEmail();
            }
        };

        $scope.TrimitereEmail = function () {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, true, false);
            $http.post('/Dosare/Email', { id: $scope.DosarFiltru.Dosar.ID })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        try {
                            var d = new Date();
                            var ds = (((d.getDate() < 10 ? "0" : "") + d.getDate()) + "." + ((d.getMonth() + 1 < 10 ? "0" : "") + (d.getMonth() + 1)) + "." + d.getFullYear());
                            $scope.DosarFiltru.Dosar.DATA_INTRARE_RCA = $scope.DosarFiltru.Dosar.DATA_IESIRE_CASCO = $scope.DosarFiltru.Dosar.DATA_ULTIMEI_MODIFICARI = ds;
                            angular.copy($scope.DosarFiltru.Dosar, $scope.DosarFiltru.DosareResult[$scope.curDosarIndex]);

                            $scope.result = response.data;
                            $rootScope.toogleOperationMessage($scope.result);
                            /*
                            $rootScope.operationResult.ShowMessage = true;
                            $rootScope.operationResult.Status = $scope.result.Status;
                            $rootScope.operationResult.Message = $scope.result.Message;
                            $('#operationResult').show();
                            $("#operationResult").delay(MESSAGE_DELAY).fadeOut(MESSAGE_FADE_OUT);
                            */
                            $scope.SetCounter($scope._LABEL_EMAIL_CERERE);
                        } catch (e) { ; }
                    }
                    //spinner.stop();
                    EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false);
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //spinner.stop();
                    EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false);
                });
        };

        $scope.AvizareDosar = function () {
            var _avizat = $scope.DosarFiltru.Dosar.STATUS == 'AVIZAT' ? 'NEAVIZAT' : 'AVIZAT';
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);

            $http.post('/Dosare/Avizare', { id: $scope.DosarFiltru.Dosar.ID, avizat: _avizat })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        $scope.result = response.data;
                        $rootScope.toogleOperationMessage($scope.result);
                        /*
                        $rootScope.operationResult.ShowMessage = true;
                        $rootScope.operationResult.Status = $scope.result.Status;
                        $rootScope.operationResult.Message = $scope.result.Message;
                        $('#operationResult').show();
                        $("#operationResult").delay(MESSAGE_DELAY).fadeOut(MESSAGE_FADE_OUT);
                        */
                        if ($scope.result.Status) {
                            $scope.DosarFiltru.Dosar.STATUS = _avizat;
                            var d = new Date();
                            var ds = (((d.getDate() < 10 ? "0" : "") + d.getDate()) + "." + ((d.getMonth() + 1 < 10 ? "0" : "") + (d.getMonth() + 1)) + "." + d.getFullYear());
                            $scope.DosarFiltru.Dosar.DATA_AVIZARE = $scope.DosarFiltru.Dosar.DATA_ULTIMEI_MODIFICARI = ds;
                            angular.copy($scope.DosarFiltru.Dosar, $scope.DosarFiltru.DosareResult[$scope.curDosarIndex]);

                            //$rootScope.AVIZAT = $scope.DosarFiltru.dosarJson.IsAvizat;
                            $rootScope.AVIZAT = (($scope.DosarFiltru.Dosar.STATUS == 'INCOMPLET' || $scope.DosarFiltru.Dosar.STATUS == 'NEAVIZAT') ? false : true);
                            $rootScope.switchTabsClass("#lnkDosareDetalii");
                        }
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                });
        };

        $scope.Delete = function () {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            $http.post('/Dosare/Delete', { id: $scope.DosarFiltru.Dosar.ID })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        $scope.result = response.data;
                        $rootScope.toogleOperationMessage($scope.result);
                        /*
                        $rootScope.operationResult.ShowMessage = true;
                        $rootScope.operationResult.Status = $scope.result.Status;
                        $rootScope.operationResult.Message = $scope.result.Message;
                        $('#operationResult').show();
                        $("#operationResult").delay(MESSAGE_DELAY).fadeOut(MESSAGE_FADE_OUT);
                        */
                        if ($scope.result.Status) {
                            $scope.DosarFiltru.DosareResult.splice($scope.curDosarIndex, 1);
                            $scope.RowsCount -= 1;
                            if ($scope.curDosarIndex != 0) {
                                $scope.RowsBlockSize -= 1; // scadem nr. de inregistrari din bloc (default = 50) pt. navigare
                                $scope.curDosarIndex -= 1;
                                $scope.ShowDosar($scope.curDosarIndex);
                            }
                            else {
                                if ($scope.RowsBlockIndex == 0) {
                                    $scope.RowsBlockSize -= 1;
                                    $scope.curDosarIndex = 0;
                                    $scope.ShowDosar($scope.curDosarIndex);
                                }
                                else {
                                    $scope.RowsBlockIndex -= 1;
                                    $scope.RowsBlockSize = $scope.DefaultRowsBlockSize;
                                    $scope.curDosarIndex = $scope.RowsBlockSize - 1;
                                    $scope.Afisare2(null);
                                }
                            }
                        }
                        $scope.$emit('refreshDashboardEmitEvent', { object: 'dosare', value: -1 });
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //spinner.stop();
                    EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
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

        $scope.ValidareTiparire = function () {
            if ($rootScope.validForTiparire) return;
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            spinnerSmall.spin(document.getElementById("divIdOptiuni"));
            $http.post('/Dosare/ValidareTiparire', { id: $rootScope.ID_DOSAR })
                .then(function (response2) {
                    if (response2 != 'null' && response2 != null && response2.data != null) {
                        console.log('validare tiparire - ' + JSON.parse(response2.data.toLowerCase()));
                        $rootScope.validForTiparire = JSON.parse(response2.data.toLowerCase());
                        //spinner.stop();
                        spinnerSmall.stop();
                    }
                }, function (response2) {
                    spinnerSmall.stop();
                    alert('Erroare: ' + response2.status + ' - ' + response2.data);
                });
        };

        $scope.TiparireDosar = function (_tip) {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, true, false);
            $http.post('/Dosare/Print', { id: $scope.DosarFiltru.Dosar.ID, tip: _tip }, { responseType: 'arraybuffer' })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        try {
                            //if (response.data.Status) {
                            //$window.open("../pdfs/" + response.data.Message);
                            var blob = new Blob([response.data], { type: "application/pdf" });
                            var objectUrl = URL.createObjectURL(blob);
                            window.open(objectUrl);
                            //spinner.stop();
                            switch (_tip) {
                                case 0:
                                    $scope.SetCounter($scope._LABEL_TIPARIRE_CERERE_COMPLETA);
                                    break;
                                case 1:
                                    $scope.SetCounter($scope._LABEL_TIPARIRE_CERERE_FARA_DOCUMENTE);
                                    break;
                                case 2:
                                    $scope.SetCounter($scope._LABEL_TIPARIRE_DOCUMENTE_CERERE);
                                    break;
                            }
                            EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false)
                            /*}
                            else {
                                $('.alert').show();
                                $scope.showMessage = true;
                                $scope.result = response.data;
                                $(".alert").delay(MESSAGE_DELAY).fadeOut(MESSAGE_FADE_OUT);
                            }*/
                        } catch (e) { ; }
                    }
                    //spinner.stop();
                    EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false);
                }, function (response) {
                    //spinner.stop();
                    EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false);
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.DownloadDocs = function (_bulk) {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, true, false)

            $http.post('/Dosare/DownloadDocs', { id: $scope.DosarFiltru.Dosar.ID, bulk: _bulk }, { responseType: 'arraybuffer' })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        try {
                            //if (response.data.Status) {
                            //$window.open("../pdfs/" + response.data.Message);
                            var blob = new Blob([response.data], { type: "application/zip" });
                            var objectUrl = URL.createObjectURL(blob);
                            window.open(objectUrl);
                            //spinner.stop();
                            $scope.SetCounter(_bulk ? $scope._LABEL_DESCARCARE_DOCUMENTE_CERERE_GRUPATE : $scope._LABEL_DESCARCARE_DOCUMENTE_CERERE_NEGRUPATE);
                            EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false)
                            /*}
                            else {
                                $('.alert').show();
                                $scope.showMessage = true;
                                $scope.result = response.data;
                                $(".alert").delay(MESSAGE_DELAY).fadeOut(MESSAGE_FADE_OUT);
                            }*/
                        } catch (e) { ; }
                    }
                    //spinner.stop();
                }, function (response) {
                    //spinner.stop();
                    EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false)
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.ExportBorderouToExcel = function () {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, true, false)

            $http.post('/Dosare/ExportBorderouToExcel', $scope.DosarFiltru, {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                responseType: 'arraybuffer'
            }).then(function (response2) {
                if (response2 != 'null' && response2 != null && response2.data != null) {
                    var blob = new Blob([response2.data], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                    var objectUrl = URL.createObjectURL(blob);
                    window.open(objectUrl);
                    //spinner.stop();
                    $scope.SetCounter($scope._LABEL_EXPORT_DOSARE_IN_EXCEL);
                    EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false)
                }
            }, function (response2) {
                //spinner.stop();
                EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, false, false)
                alert('Erroare: ' + response2.status + ' - ' + response2.data);
            });
        };

        $scope.ExportDosareToExcel = function () {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID))
            EnableDisableInputs('#divIdOptiuni', spinner, ACTIVE_DIV_ID, true, false)

            $http.post('/Dosare/ExportDosareToExcel', $scope.TempDosarFilter, {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
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

        $scope.ToggleSearchMode = function () {
            if ($scope.editMode == 1 || $rootScope.ExternalUser.Value == true) return;
            if ($scope.searchMode != 2) {
                $scope.SwitchBackToSearchMode();
            } else {
                //$scope.curDosarIndex = $scope.idx;
                $scope.searchMode = 1;
                $scope.ShowDosar($scope.curDosarIndex);
            }
        };

        $scope.GetCounter = function (_operation) {
            if ($rootScope.ID_DOSAR == null) {
                _operation.Value = 0; return;
            }
            $http.post('/Dosare/GetCounter', { operation: _operation.Name, id_dosar: $rootScope.ID_DOSAR })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        console.log(response.data);
                        //return response.data;
                        _operation.Value = response.data;
                    }
                    //spinner.stop();
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //return 0;
                    _operation.Value = 0;
                    //spinner.stop();
                });
            //return 0;
        };

        $scope.GetCounters = function () {
            for (var i = 0; i < $scope.CountedOperations.length; i++) {
                $scope.GetCounter($scope.CountedOperations[i]);
            }
        };

        $scope.SetCounter = function (_operation) {
            if ($rootScope.ID_DOSAR == null) {
                return;
            }
            $http.post('/Dosare/SetCounter', { operation: _operation.Name, id_dosar: $rootScope.ID_DOSAR })
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        console.log(response.data);
                        //return response.data;
                        _operation.Value = response.data;
                    }
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    //return 0;
                    _operation.Value = 0;
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
                        case "SocietateRca":
                            url += $scope.DosarFiltru.Dosar.ID_SOCIETATE_RCA;
                            break;
                        case "SocietateCasco":
                            url += $scope.DosarFiltru.Dosar.ID_SOCIETATE_CASCO;
                            break;
                        case "AsiguratCasco":
                            url += $scope.DosarFiltru.Dosar.ID_ASIGURAT_CASCO;
                            break;
                        case "AsiguratRca":
                            url += $scope.DosarFiltru.Dosar.ID_ASIGURAT_RCA;
                            break;
                        case "AutoCasco":
                            url += $scope.DosarFiltru.Dosar.ID_AUTO_CASCO;
                            break;
                        case "AutoRca":
                            url += $scope.DosarFiltru.Dosar.ID_AUTO_RCA;
                            break;
                        case "Intervenient":
                            url += $scope.DosarFiltru.Dosar.ID_INTERVENIENT;
                            break;
                    }

                    $.get(url, function (d) {
                        var ele = $('#' + content_id);
                        var htmlContent = $compile(d)($scope);
                        ele.html(htmlContent);
                        $scope.$broadcast('refreshBroadcastEvent', { objectType: objectType, editMode: $scope.editMode });
                    });

                    return '<div class="small" style="width:300px;" id="' + content_id + '">Loading...</div>';
                }
            });
        };

        $scope.showSendStatus = function () {
            //alert("dosar");
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            var _url = '/NotificariEmail/Index/' + $scope.DosarFiltru.Dosar.ID;
            $.ajax({
                async: true,
                type: 'GET',
                url: _url,
                //processData: false,
                dataType: 'html'
            }).done(function (data) {
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);

                ngDialog.openConfirm({
                    template: data,
                    controller: 'NotificariEmailController',
                    plain: true,
                    className: 'ngdialog-theme-default custom-width',
                    width: 800,
                    scope: $scope
                }).then(
                    function (value) {
                        //alert('succes');
                    },
                    function (reason) {
                        //alert(reason);
                    });
            }).fail(function (jqXHR, textStatus) {
                alert(textStatus);
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
            });
        };
    });