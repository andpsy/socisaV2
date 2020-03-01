'use strict';

app.controller('DosareIndexController',
    function ($scope, $http, $filter, $rootScope, $window, $timeout, $compile, ngDialog) {
        $rootScope.activeTab.Value = "detalii";
        $rootScope.AVIZAT = false; // variabila generala pt. statusul dosarului (vizibila intre controllere)
        //$rootScope.validForAvizare = null; // variabila generala pt. validitatea dosarului de a fi avizat (vizibil intre controllere)
        $rootScope.validForTiparire = null; // variabila generala pt. validitatea dosarului de a fi tiparit (vizibil intre controllere)
        $rootScope.editMode = 0;
        $rootScope.searchMode = 1;

        $scope.$on('paymentUpdateEmitEvent', function (event, data) {
            $scope.$broadcast('paymentUpdateBroadcastEvent', true);
        });

        $scope.$on('NewFilterRequestEmitEvent', function (event, data) {
            $scope.$broadcast('NewFilterRequestBroadcastEvent', data);
        });

        $scope.$on('refreshCounterEmitEvent', function (event, data) {
            $scope.$broadcast('refreshCounterBroadcastEvent', data);
        });

        $scope.$on('refreshDashboardEmitEvent', function (event, data) {
            $scope.$emit('refreshRootScopeDashboardEmitEvent', data);
        });


        $rootScope.setActiveTab = function (atab) {
            $rootScope.activeTab.Value = atab;

            var lnkId = "#lnkDosareDetalii";
            switch ($rootScope.activeTab.Value) {
                case "detalii":
                    lnkId = "#lnkDosareDetalii";
                    break;
                case "documente":
                    lnkId = "#lnkDocumenteScanateDetalii";
                    break;
                case "stadii":
                    lnkId = "#lnkStadiiDetalii";
                    break;
                case "plati":
                    lnkId = "#lnkPlatiDetalii";
                    break;
                case "procese":
                    lnkId = "#lnkProceseDetalii";
                    break;
                case "mesaje":
                    lnkId = "#lnkMesajeDetalii";
                    break;
                case "utilizatori":
                    lnkId = "#lnkUtilizatoriDetalii";
                    break;
            }
            $rootScope.switchTabsClass(lnkId);
        };

        $rootScope.switchTabsClass = function (lnkId) {
            var div_id = $rootScope.ExternalUser.Value == true ? "#mainDashboard" : "#mainDosareDashboard";
            $(div_id).removeClass("div_default").removeClass("div_avizat").removeClass("div_neavizat").removeClass("div_incomplet").removeClass("div_neachitat").removeClass("div_achitat_partial").removeClass("div_achitat").removeClass("div_compensat").removeClass("div_partial_compensat").removeClass("div_necompensat");
            $("#lnkDosareDetalii").removeClass("grad_tab").removeClass("grad_tab_avizat").removeClass("grad_tab_neavizat").removeClass("grad_tab_incomplet").removeClass("grad_tab_neachitat").removeClass("grad_tab_achitat_partial").removeClass("grad_tab_achitat").removeClass("grad_tab_compensat").removeClass("grad_tab_partial_compensat").removeClass("grad_tab_necompensat");
            $("#lnkDocumenteScanateDetalii").removeClass("grad_tab").removeClass("grad_tab_avizat").removeClass("grad_tab_neavizat").removeClass("grad_tab_incomplet").removeClass("grad_tab_neachitat").removeClass("grad_tab_achitat_partial").removeClass("grad_tab_achitat").removeClass("grad_tab_compensat").removeClass("grad_tab_partial_compensat").removeClass("grad_tab_necompensat");
            $("#lnkMesajeDetalii").removeClass("grad_tab").removeClass("grad_tab_avizat").removeClass("grad_tab_neavizat").removeClass("grad_tab_incomplet").removeClass("grad_tab_neachitat").removeClass("grad_tab_achitat_partial").removeClass("grad_tab_achitat").removeClass("grad_tab_compensat").removeClass("grad_tab_partial_compensat").removeClass("grad_tab_necompensat");
            $("#lnkUtilizatoriDetalii").removeClass("grad_tab").removeClass("grad_tab_avizat").removeClass("grad_tab_neavizat").removeClass("grad_tab_incomplet").removeClass("grad_tab_neachitat").removeClass("grad_tab_achitat_partial").removeClass("grad_tab_achitat").removeClass("grad_tab_compensat").removeClass("grad_tab_partial_compensat").removeClass("grad_tab_necompensat");
            $("#lnkStadiiDetalii").removeClass("grad_tab").removeClass("grad_tab_avizat").removeClass("grad_tab_neavizat").removeClass("grad_tab_incomplet").removeClass("grad_tab_neachitat").removeClass("grad_tab_achitat_partial").removeClass("grad_tab_achitat").removeClass("grad_tab_compensat").removeClass("grad_tab_partial_compensat").removeClass("grad_tab_necompensat");
            $("#lnkPlatiDetalii").removeClass("grad_tab").removeClass("grad_tab_avizat").removeClass("grad_tab_neavizat").removeClass("grad_tab_incomplet").removeClass("grad_tab_neachitat").removeClass("grad_tab_achitat_partial").removeClass("grad_tab_achitat").removeClass("grad_tab_compensat").removeClass("grad_tab_partial_compensat").removeClass("grad_tab_necompensat");
            $("#lnkProceseDetalii").removeClass("grad_tab").removeClass("grad_tab_avizat").removeClass("grad_tab_neavizat").removeClass("grad_tab_incomplet").removeClass("grad_tab_neachitat").removeClass("grad_tab_achitat_partial").removeClass("grad_tab_achitat").removeClass("grad_tab_compensat").removeClass("grad_tab_partial_compensat").removeClass("grad_tab_necompensat");

            var classToAdd = "";
            var classToAddDiv = "";
            if ($rootScope.ID_DOSAR == null) {
                classToAdd = "grad_tab";
                classToAddDiv = "div_default";
            }
            else {
                switch ($rootScope.STATUS_DOSAR) {
                    case 'INCOMPLET':
                        classToAdd = "grad_tab_incomplet";
                        classToAddDiv = "div_incomplet";
                        break;
                    case 'NEAVIZAT':
                        classToAdd = "grad_tab_neavizat";
                        classToAddDiv = "div_neavizat";
                        break;
                    case 'AVIZAT':
                        classToAdd = "grad_tab_avizat";
                        classToAddDiv = "div_avizat";
                        break;
                    case 'NEACHITAT':
                        classToAdd = "grad_tab_neachitat";
                        classToAddDiv = "div_neachitat";
                        break;
                    case 'ACHITAT_PARTIAL':
                        classToAdd = "grad_tab_achitat_partial";
                        classToAddDiv = "div_achitat_partial";
                        break;
                    case 'ACHITAT':
                        classToAdd = "grad_tab_achitat";
                        classToAddDiv = "div_achitat";
                        break;
                    case 'COMPENSAT':
                        classToAdd = "grad_tab_compensat";
                        classToAddDiv = "div_compensat";
                        break;
                    case 'PARTIAL_COMPENSAT':
                        classToAdd = "grad_tab_partial_compensat";
                        classToAddDiv = "div_partial_compensat";
                        break;
                    case 'NECOMPENSAT':
                        classToAdd = "grad_tab_necompensat";
                        classToAddDiv = "div_necompensat";
                        break;
                }
            }
            $(lnkId).addClass(classToAdd);
            $(div_id).addClass(classToAddDiv);
        };
        /*
        $scope.LoadTabContent = function (divContentId, methodUrl, methodType, params) {
            var divId = '#' + divContentId;
            var curHtml = $(divId).html();
            if (curHtml == null || curHtml == undefined || curHtml == '') return;
    
            EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, true, true);
            $.ajax({
                async: false,
                type: methodType,
                url: methodUrl + (params == null ? '' : '/' + params),
                dataType: 'html'
            }).done(function (data) {
                var htmlContent = $compile(data)($scope);
                $(divId).html(htmlContent);
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
            }).fail(function (jqXHR, textStatus) {
                EnableDisableInputs('#DosareSearch', spinner, ACTIVE_DIV_ID, false, true);
                alert(textStatus);
            });
        };
        */
    });