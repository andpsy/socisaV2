'use strict';
/*
function toggleDivs(activeDiv) {
    document.getElementById('detaliiDocument').style.display = activeDiv == "detaliiDocument" ? (document.getElementById('detaliiDocument').style.display == 'block' ? 'none' : 'block') : 'none'; 
    document.getElementById('incarcareFisiere').style.display = activeDiv == "incarcareFisiere" ? (document.getElementById('incarcareFisiere').style.display == 'block' ? 'none' : 'block') : 'none';
}
function toggleAllThumbs(e) {
    $('.checkOverImage').prop('checked', e.checked);
}
*/
var inDocTypeSelectionMode = false;
var curSelectedDocs = [];

$(document).on('keydown', function (e) {
    if (e.keyCode === 27 && inDocTypeSelectionMode) {
        //$scope.inDocTypeSelectionMode = false;
        inDocTypeSelectionMode = false;
        $("#local-modal-background").hide();
        $("#listaTipuriDocumente").removeClass('activeSelectionDiv');
        for (var i = 0; i < curSelectedDocs.length; i++) {
            var dId = "#thumbImg_" + curSelectedDocs[i].ID;
            $(dId).parent().removeClass("selectedDocForTypeChange");
        }
        curSelectedDocs = [];
    }
});

app.controller('DocumenteScanateController',
    function ($scope, $http, $filter, $rootScope, $window, $q, Upload, ngDialog, PromiseUtils, myService) {
        $scope.lastActiveIdDosar = "";
        $scope.model = {};
        $scope.curDocumentIndex = -1; // -1 daca nu vrem sa afisam direct primul tip de document
        $scope.curDocumentSubIndex = 0;
        $scope.model.TipuriDocumente = [];
        $scope.model.TranslatedTipDocumenteNames = [];
        $scope.model.CurDocumentScanat = {};
        $scope.fileIndex = $scope.filesLength = -1;
        $scope.curThumb = $scope.defaultThumb = "../Content/empty.jpg";
        $scope.toggle_all_docs = false;
        $scope.searchMode = 1;
        $scope.editMode = 0;

        $scope.$watch('searchMode', function (newValue, oldValue) {
            $rootScope.searchMode = newValue;
            console.log('doc. scanate - search: ' + newValue)
        });

        $scope.$watch('editMode', function (newValue, oldValue) {
            $rootScope.editMode = newValue;
            console.log('doc. scanate - edit: ' + newValue)
        });

        $scope.toggleDivs = function (activeDiv, brutForce) {
            console.log('toggleDivs - ' + activeDiv);
            document.getElementById('detaliiDocument').style.display = activeDiv == "detaliiDocument" ? brutForce != null ? brutForce : (document.getElementById(activeDiv).style.display == 'block' ? 'none' : 'block') : 'none';
            document.getElementById('incarcareFisiere').style.display = activeDiv == "incarcareFisiere" ? brutForce != null ? brutForce : (document.getElementById(activeDiv).style.display == 'block' ? 'none' : 'block') : 'none';
        };

        $scope.toggleAllThumbs = function () {
            console.log('toggleAllThumbs - ' + $scope.toggle_all_docs);
            //$('.checkOverImage').prop('checked', $scope.toggle_all_docs);
            for (var i = 0; i < $scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate.length; i++) {
                $scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate[i].VIZA_CASCO = $scope.toggle_all_docs;
                $scope.AvizareDocument($scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate[i]);
            }
        };

        /*
        $scope.$watch('toggle_all_docs', function (newValue, oldValue) {
            if (newValue != oldValue) {
                console.log('watch toggle_all_docs - ' + newValue);
                $scope.toggleAllThumbs();
            }
        });
        */

        $scope.checkAllAvizari = function () {
            var cnt = 0;
            for (var i = 0; i < $scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate.length; i++)
                if ($scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate[i].VIZA_CASCO) cnt++;
            console.log('checkAllAvizari - ' + cnt);
            $scope.toggle_all_docs = (cnt == $scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate.length);
        };

        $scope.changeDocType = function () {
            //$scope.inDocTypeSelectionMode = true;
            inDocTypeSelectionMode = true;
            $("#local-modal-background").show();
            $("#listaTipuriDocumente").addClass('activeSelectionDiv');
            $("#listaTipuriDocumente").css("z-index", 1001);
            $("#thumbScroller").css("z-index", 1001);

            /*
            document.getElementById("listaTipuriDocumente").addEventListener("click", function (event) {
                event.preventDefault();
                alert(event);
                // ... aici schimbam tipul
                $scope.inDocTypeSelectionMode = false;
                $("#local-modal-background").hide();
                $("#listaTipuriDocumente").removeClass('activeSelectionDiv');
                document.getElementById("listaTipuriDocumente").removeEventListener("click", function (event) { });
            });
            */
        };

        $scope.showDocumentByIndex = function (doc_idx) {
            //if ($scope.inDocTypeSelectionMode) {
            if (inDocTypeSelectionMode) {
                // ... aici schimbam tipul
                /*
                $scope.model.CurDocumentScanat.ID_TIP_DOCUMENT = $scope.model.TipuriDocumente[doc_idx].TipDocument.ID;
                $scope.SaveEdit(null); // vedem daca punem in q si facem refresh ...
                */
                var qs = [];
                
                for (var i = 0; i < curSelectedDocs.length; i++) {

                    //stergem documentele din tipul vechi
                    var oldIndex = -1;
                    for (var j = 0; j < $scope.model.TipuriDocumente.length; j++) {
                        if (curSelectedDocs[i].ID_TIP_DOCUMENT == $scope.model.TipuriDocumente[j].TipDocument.ID) {
                            oldIndex = j;
                            break;
                        }
                    }
                    for (var j = 0; j < $scope.model.TipuriDocumente[oldIndex].DocumenteScanate.length; j++) {
                        if (curSelectedDocs[i].ID == $scope.model.TipuriDocumente[oldIndex].DocumenteScanate[j].ID) {
                            $scope.model.TipuriDocumente[oldIndex].DocumenteScanate.splice(j, 1);
                            break;
                        }
                    }
                    //adaugam documentul scanat la noul tip
                    $scope.model.TipuriDocumente[doc_idx].DocumenteScanate.push(curSelectedDocs[i]);


                    curSelectedDocs[i].ID_TIP_DOCUMENT = $scope.model.TipuriDocumente[doc_idx].TipDocument.ID; // new tip document
                    //var x = $scope.SaveEdit(curSelectedDocs[i]);
                    
                    var data = curSelectedDocs[i];
                    var x = $http.post('/DocumenteScanate/UpdateTipDocument', { id: data.ID, id_tip_document: data.ID_TIP_DOCUMENT })
                        .then(function (response) {
                            if (response != 'null' && response != null && response.data != null) {
                                $scope.result = response.data;
                                $rootScope.toogleOperationMessage($scope.result);
                            }
                            //spinner.stop();
                            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
                        }, function (response) {
                            //spinner.stop();
                            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
                            alert('Erroare: ' + response.status + ' - ' + response.data);
                        });
                    
                    qs.push(x);
                }

                $q.all(qs).then(function (response) {
                    $scope.model.CurDocumentScanat = {};
                    $scope.curThumb = null;
                    //$("#curThumbId").attr('src', '');

                    //$scope.inDocTypeSelectionMode = false;
                    inDocTypeSelectionMode = false;
                    curSelectedDocs = [];
                    $("#local-modal-background").hide();
                    $("#listaTipuriDocumente").removeClass('activeSelectionDiv');
                    //$scope.ShowDocuments($rootScope.ID_DOSAR);

                });
            }
            else {
                $scope.curDocumentIndex = doc_idx;
                try {
                    if ($scope.model.TipuriDocumente[doc_idx].DocumenteScanate.length <= 0)
                        $scope.curDocumentSubIndex = -1;
                    else //if ($scope.curDocumentSubIndex > $scope.model.TipuriDocumente[doc_idx].DocumenteScanate.length)
                        $scope.curDocumentSubIndex = 0;

                    var doc = $scope.model.TipuriDocumente[doc_idx].DocumenteScanate[$scope.curDocumentSubIndex];
                    angular.copy(doc, $scope.model.CurDocumentScanat);
                    if ($scope.model.TipuriDocumente[doc_idx].DocumenteScanate.length > 0) {
                        $scope.curThumb = $scope.getThumbnailFile($scope.model.CurDocumentScanat.CALE_FISIER, $scope.model.CurDocumentScanat.EXTENSIE_FISIER);
                        $scope.toggleDivs('incarcareFisiere', 'none');
                        $scope.checkAllAvizari();
                    }
                    else {
                        if ($rootScope.ExternalUser.Value != true) {
                            $scope.curThumb = $scope.defaultThumb;
                            $scope.toggleDivs('incarcareFisiere', 'block');
                        }
                    }

                    if ($scope.model.CurDocumentScanat == null || $scope.model.CurDocumentScanat.ID == null) {
                        $scope.model.CurDocumentScanat = {};
                        $scope.model.CurDocumentScanat.FILE_CONTENT = null;
                        $scope.model.CurDocumentScanat.MEDIUM_ICON = null;
                        $scope.model.CurDocumentScanat.ID_TIP_DOCUMENT = $scope.model.TipuriDocumente[doc_idx].TipDocument.ID;
                        $scope.model.CurDocumentScanat.ID_DOSAR = $rootScope.ID_DOSAR;
                        $scope.curThumb = $scope.defaultThumb;
                    }
                } catch (e) {
                    $scope.model.CurDocumentScanat = {};
                    $scope.model.CurDocumentScanat.FILE_CONTENT = null;
                    $scope.model.CurDocumentScanat.MEDIUM_ICON = null;
                    $scope.model.CurDocumentScanat.ID_TIP_DOCUMENT = $scope.model.TipuriDocumente[doc_idx].TipDocument.ID;
                    $scope.model.CurDocumentScanat.ID_DOSAR = $rootScope.ID_DOSAR;
                    $scope.curThumb = $scope.defaultThumb;
                }
            }
        };

        $scope.SetCurDocument = function (doc, doc_idx) {
            //if (!$scope.inDocTypeSelectionMode) {
            if (!inDocTypeSelectionMode) {
                $scope.curDocumentSubIndex = doc_idx;
                angular.copy(doc, $scope.model.CurDocumentScanat);
                //model.CurDocumentScanat = documentScanat;
                $scope.curThumb = $scope.getThumbnailFile($scope.model.CurDocumentScanat.CALE_FISIER, $scope.model.CurDocumentScanat.EXTENSIE_FISIER);
            }
            else {
                var dId = "#thumbImg_" + doc.ID;
                if (curSelectedDocs.indexOf(doc) < 0)  {
                    curSelectedDocs.push(doc);
                    $(dId).parent().addClass("selectedDocForTypeChange");
                } else {
                    curSelectedDocs.splice(curSelectedDocs.indexOf(doc), 1);
                    $(dId).parent().removeClass("selectedDocForTypeChange");
                }
            }
        };

        $scope.areDocumentAvizat = function (id_tip_document) {
            try {
                for (var i = 0; i < $scope.model.TipuriDocumente.length; i++) {
                    if ($scope.model.TipuriDocumente[i].TipDocument.ID == id_tip_document) {
                        //alert($scope.model.TipuriDocumente[i].DocumenteScanate);
                        if ($scope.model.TipuriDocumente[i].DocumenteScanate == null || $scope.model.TipuriDocumente[i].DocumenteScanate.length == 0) {
                            //alert('0');
                            return 0;
                        }
                        for (var j = 0; j < $scope.model.TipuriDocumente[i].DocumenteScanate.length; j++) {
                            if ($scope.model.TipuriDocumente[i].DocumenteScanate[j].VIZA_CASCO) {
                                //alert('2');
                                return 2;
                            }
                        }
                    }
                }
                //alert('1');
                return 1; // 2 = AVIZAT / 1 = are document, dar nu e avizat.
            } catch (e) { alert(e); return 0; }
        };


        $scope.getTipDocumentByDenumire = function (denumireTipDoc) {
            try {
                for (var i = 0; i < $scope.model.TipuriDocumente.length; i++) {
                    var tDoc = $scope.model.TipuriDocumente[i].TipDocument;
                    if ($scope.model.TipuriDocumente[i].TipDocument.DENUMIRE == denumireTipDoc) {
                        return tDoc;
                    }
                }
                return null;
            } catch (e) { return null; }
        };

        $scope.showMandatory = function (tipDoc) {
            try {
                switch (tipDoc.TipDocument.DENUMIRE) {
                    case "CEDAM":
                        var tDoc = $scope.getTipDocumentByDenumire("POLITA VINOVAT");
                        if (tDoc != null) {
                            if ($scope.areDocumentAvizat(tDoc.ID) == 2) {
                                return false;
                            }
                        }
                        break;
                    case "POLITA VINOVAT":
                        var tDoc = $scope.getTipDocumentByDenumire("CEDAM");
                        if (tDoc != null) {
                            if ($scope.areDocumentAvizat(tDoc.ID) == 2) {
                                return false;
                            }
                        }
                        break;
                    case "FACTURA DE REPARATII":
                        var tDoc = $scope.getTipDocumentByDenumire("CALCUL VMD");
                        if (tDoc != null) {
                            if ($scope.areDocumentAvizat(tDoc.ID) == 2) {
                                return false;
                            }
                        }
                        break;
                    case "CALCUL VMD":
                        var tDoc = $scope.getTipDocumentByDenumire("FACTURA DE REPARATII");
                        if (tDoc != null) {
                            if ($scope.areDocumentAvizat(tDoc.ID) == 2) {
                                return false;
                            }
                        }
                        break;

                    case "PROCES VERBAL":
                        var tDoc = $scope.getTipDocumentByDenumire("CONSTATARE AMIABILA");
                        if (tDoc != null) {
                            if ($scope.areDocumentAvizat(tDoc.ID) == 2) {
                                return false;
                            }
                        }
                        break;
                    case "CONSTATARE AMIABILA":
                        var tDoc = $scope.getTipDocumentByDenumire("PROCES VERBAL");
                        if (tDoc != null) {
                            if ($scope.areDocumentAvizat(tDoc.ID) == 2) {
                                return false;
                            }
                        }
                        break;
                }

                return !($scope.areDocumentAvizat(tipDoc.TipDocument.ID) == 2) && tipDoc.TipDocument.MANDATORY;
                return tipDoc.TipDocument.MANDATORY;
            } catch (e) { return false; }
        };

        $scope.countDocs = function (tipDoc) {
            var toReturn = [];
            var avizate = 0; var neavizate = 0;
            try {
                for (var i = 0; i < tipDoc.DocumenteScanate.length; i++) {
                    if (tipDoc.DocumenteScanate[i].VIZA_CASCO)
                        avizate++;
                    else
                        neavizate++;
                }
            } catch (e) { ; }
            toReturn.push(avizate); toReturn.push(neavizate);
            return toReturn;
        };

        //avizare cu bife indirecta
        $scope.AvizareDocumente = function (avizat) {
            //$scope.model.CurDocumentScanat.VIZA_CASCO = avizat;
            //$scope.SaveEdit();
            var tDoc = $scope.model.TipuriDocumente[$scope.curDocumentIndex];
            for (var i = 0; i < tDoc.DocumenteScanate.length; i++) {
                var id = '#chk_' + tDoc.DocumenteScanate[i].ID;
                var chk = $(id).prop('checked');
                if (chk && tDoc.DocumenteScanate[i].VIZA_CASCO != avizat) {
                    tDoc.DocumenteScanate[i].VIZA_CASCO = avizat;
                    //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
                    EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, true, true);

                    var data = tDoc.DocumenteScanate[i];
                    $http.post('/DocumenteScanate/Avizare', data)
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
                                    $scope.model.CurDocumentScanat = {};
                                    $scope.ShowDocuments($rootScope.ID_DOSAR);
                                }
                            }
                            //spinner.stop();
                            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
                        }, function (response) {
                            //spinner.stop();
                            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
                            alert('Erroare: ' + response.status + ' - ' + response.data);
                        });
                }
            }
        };

        //avizare cu bifa direct
        $scope.AvizareDocument = function (document_scanat) {
            console.log('AvizareDocument - ' + document_scanat.VIZA_CASCO);

            //var id = '#chk_' + document_scanat.ID;
            //var chk = $(id).prop('checked');
            //if (chk != document_scanat.VIZA_CASCO) {
            //document_scanat.VIZA_CASCO = chk;
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, true, true);
            $http.post('/DocumenteScanate/Avizare', document_scanat)
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
                        $scope.model.CurDocumentScanat.VIZA_CASCO = document_scanat.VIZA_CASCO;
                        $scope.checkAllAvizari();


                        $http.post('/Dosare/ValidareAvizare', { id: $rootScope.ID_DOSAR })
                            .then(function (response2) {
                                if (response2 != 'null' && response2 != null && response2.data != null) {
                                    console.log('validare avizare - ' + JSON.parse(response2.data.toLowerCase()));
                                    //$rootScope.validForAvizare = JSON.parse(response2.data.toLowerCase());
                                    $rootScope.$emit('updateDosarStatusEmitEvent', JSON.parse(response2.data.toLowerCase()));
                                }
                            }, function (response2) {
                                alert('Erroare: ' + response2.status + ' - ' + response2.data);
                            });

                        /*
                        if ($scope.result.Status) {
                            $scope.model.CurDocumentScanat = {};
                            $scope.ShowDocuments($rootScope.ID_DOSAR);
                        }
                        */
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
                }, function (response) {
                    //spinner.stop();
                    EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
            //}
        };

        $rootScope.$watch('ID_DOSAR', function (newValue, oldValue) {
            if (newValue != null && newValue != undefined && $rootScope.activeTab.Value == 'documente') {
                $scope.lastActiveIdDosar = "";
                $scope.model = {};
                $scope.curDocumentIndex = 0; // -1 daca nu vrem sa afisam direct primul tip de document
                $scope.curDocumentSubIndex = 0;
                $scope.model.TipuriDocumente = [];
                $scope.model.TranslatedTipDocumenteNames = [];
                $scope.model.CurDocumentScanat = {};
                $scope.fileIndex = $scope.filesLength = -1;
                $scope.curThumb = "";

                $scope.model.ID_DOSAR = newValue;
                $scope.ShowDocuments(newValue);
            }
        });

        $rootScope.$watch('activeTab.Value', function (newValue, oldValue) {
            if (newValue == 'documente' && $rootScope.ID_DOSAR != null && $rootScope.ID_DOSAR != undefined && $scope.lastActiveIdDosar != $rootScope.ID_DOSAR) {
                $scope.lastActiveIdDosar = "";
                $scope.model = {};
                $scope.curDocumentIndex = 0; // -1 daca nu vrem sa afisam direct primul tip de document
                $scope.curDocumentSubIndex = 0;
                $scope.model.TipuriDocumente = [];
                $scope.model.TranslatedTipDocumenteNames = [];
                $scope.model.CurDocumentScanat = {};
                $scope.fileIndex = $scope.filesLength = -1;
                $scope.curThumb = "";

                $scope.model.ID_DOSAR = $rootScope.ID_DOSAR;
                $scope.ShowDocuments($rootScope.ID_DOSAR);
                $scope.lastActiveIdDosar = $rootScope.ID_DOSAR;
            }
        });

        $scope.ShowDocuments = function (id_dosar) {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, true, true);

            console.log('showdocuments');
            //myService.getlist('GET', '/DocumenteScanate/Details/' + id_dosar, null)
            $http.get('/DocumenteScanate/Details/' + id_dosar)
                .then(function (response) {
                    if ($scope.fileIndex == $scope.filesLength - 1 || ($scope.fileIndex == -1 && $scope.filesLength == -1)) {
                        if (response != 'null' && response != null && response.data != null) {
                            $scope.model.TipuriDocumente = response.data.TipuriDocumente;
                            $scope.model.TranslatedTipDocumenteNames = response.data.TranslatedTipDocumenteNames;
                        }
                        else {
                            $scope.model.TipuriDocumente = null;
                        }
                        if ($scope.curDocumentIndex > -1) {
                            $scope.showDocumentByIndex($scope.curDocumentIndex);
                        }
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);

                }, function (response) {
                    //spinner.stop();
                    EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);

                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.vizualizareDoc = function () {
            $scope.toggleDivs('null', null);
            $window.open(($rootScope.ExternalUser.Value == true ? "../../" : "../") + "../scans/" + $scope.model.CurDocumentScanat.CALE_FISIER);
        };

        //varianta cu bife multipe
        $scope.deleteDocs = function () {
            var tDoc = $scope.model.TipuriDocumente[$scope.curDocumentIndex];
            for (var i = 0; i < tDoc.DocumenteScanate.length; i++) {
                var id = '#chk_' + tDoc.DocumenteScanate[i].ID;
                var chk = $(id).prop('checked');
                if (chk) {
                    //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
                    EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, true, true);

                    var id = tDoc.DocumenteScanate[i].ID;
                    $http.get('/DocumenteScanate/Delete/' + id)
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
                                    $scope.model.CurDocumentScanat = {};
                                    $scope.ShowDocuments($rootScope.ID_DOSAR);
                                }
                            }
                            //spinner.stop();
                            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);

                        }, function (response) {
                            //spinner.stop();
                            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);

                            alert('Erroare: ' + response.status + ' - ' + response.data);
                        });
                }
            }
            /*
                },
                function (value) {
                    document.getElementById("modal").style.display = "none";
                }
            );
            */
        };

        //varianta fara bife multipe
        $scope.deleteDoc = function () {
            $scope.toggleDivs('null', null);
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, true, true);
            var id = $scope.model.CurDocumentScanat.ID;
            $http.get('/DocumenteScanate/Delete/' + id)
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
                            $scope.$emit('refreshCounterEmitEvent', { object: 'documente', value: -1 });
                            $scope.model.CurDocumentScanat = {};
                            $scope.curThumb = $scope.defaultThumb;
                            $scope.ShowDocuments($rootScope.ID_DOSAR);
                        }
                    }
                    //spinner.stop();
                    EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
                }, function (response) {
                    //spinner.stop();
                    EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };

        $scope.EnterDeleteDocMode = function (msg) {
            $rootScope.confirmMessage = msg;
            ngDialog.openConfirm({
                template: 'confirmationDialogId',
                className: 'ngdialog-theme-default'
            }).then(
                function (value) {
                    $scope.deleteDoc();
                },
                function (reason) {

                });
        };

    $scope.SaveEdit = function (doc) {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, true, true);
        var data = (doc == null ? $scope.model.CurDocumentScanat : doc);
        return $http.post('/DocumenteScanate/Edit', data)
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
                    /*
                    if (doc == null) {
                        if ($scope.result.Status) {
                            $scope.model.CurDocumentScanat = {};
                            $scope.ShowDocuments($rootScope.ID_DOSAR);
                        }
                    }
                    */
                    /* -- mutat in showDocumentByIndex --
                    //if ($scope.inDocTypeSelectionMode) {
                    if (inDocTypeSelectionMode) {
                        $scope.model.CurDocumentScanat = {};
                        $scope.ShowDocuments($rootScope.ID_DOSAR);

                        //$scope.inDocTypeSelectionMode = false;
                        inDocTypeSelectionMode = false;
                        $("#local-modal-background").hide();
                        $("#listaTipuriDocumente").removeClass('activeSelectionDiv');
                    }
                    */
                    /*
                    if ($scope.result.Status && $scope.result.InsertedId != null) {
                        $scope.$emit('refreshCounterEmitEvent', { object: 'documente', value: 1 });
                    }
                    */
                }
                //spinner.stop();
                EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                //spinner.stop();
                EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
                alert('Erroare: ' + response.status + ' - ' + response.data);
            });
    };

    $scope.Refresh = function () {
        $scope.model.CurDocumentScanat = {};
        $scope.ShowDocuments($rootScope.ID_DOSAR);
        console.log('refresh');
    };

    $scope.SaveAndRefresh = function (doc) {
        $scope.SaveEdit(doc);
        $scope.Refresh();
    };

    // upload on file select or drop
    /*
    $scope.upload = function (file) {
        if (file == null || !Upload.isFile(file)) return;
        spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        $scope.model.CurDocumentScanat = {};
        $scope.model.CurDocumentScanat.ID = null;
        $scope.model.CurDocumentScanat.FILE_CONTENT = null;
        $scope.model.CurDocumentScanat.MEDIUM_ICON = null;
        $scope.model.CurDocumentScanat.ID_TIP_DOCUMENT = $scope.model.TipuriDocumente[$scope.curDocumentIndex].TipDocument.ID;
        $scope.model.CurDocumentScanat.ID_DOSAR = $rootScope.ID_DOSAR;
        Upload.upload({
            url: '/DocumenteScanate/PostFile',
            data: { file: file, id_tip_document: $scope.model.TipuriDocumente[$scope.curDocumentIndex].TipDocument.ID, id_dosar: $rootScope.ID_DOSAR }
        }).then(function (resp) {
            var j = JSON.parse(resp.data);
            $scope.model.CurDocumentScanat.DENUMIRE_FISIER = j.DENUMIRE_FISIER;
            $scope.model.CurDocumentScanat.EXTENSIE_FISIER = j.EXTENSIE_FISIER;
            $scope.model.CurDocumentScanat.CALE_FISIER = j.CALE_FISIER;
            $scope.model.CurDocumentScanat.DATA_INCARCARE = j.DATA_INCARCARE;
            $scope.model.CurDocumentScanat.DIMENSIUNE_FISIER = j.DIMENSIUNE_FISIER;
            spinner.stop();
            $scope.SaveEdit(null);
        }, function (resp) {
            alert(resp.status + ' - ' + resp.data);
            console.log('Error status: ' + resp.status);
            spinner.stop();
        }, function (evt) {
            var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            console.log('progress: ' + progressPercentage + '% ' + evt.config.data.file.name);
        });
    };
    */

    // for multiple files:
    $scope.uploadFiles = function (files) {
        if (files && files.length) {
            //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, true, true);
            $scope.filesLength = files.length;
            var qs = [];
            for (var i = 0; i < files.length; i++) {
                if (files[i] == null || !Upload.isFile(files[i])) break;
                $scope.fileIndex = i;
                //$scope.upload(files[i]); // old version
                ////Upload.upload({..., data: {file: files[i]}, ...})...;
                var x = Upload.upload({
                    url: '/DocumenteScanate/PostFile',
                    data: { file: files[i], id_tip_document: $scope.model.TipuriDocumente[$scope.curDocumentIndex].TipDocument.ID, id_dosar: $rootScope.ID_DOSAR }
                });
                x.then(function (resp) {
                    $scope.$emit('refreshCounterEmitEvent', { object: 'documente', value: 1 });

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
                $scope.Refresh();
                //spinner.stop();
                EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                //alert('q err');
                var message = 'Status: ' + resp.status + '<br />' + response.data;
                var result = { ShowMessage: true, Status: false, Message: message, Result: null, InsertedId: null, Error: null };
                $rootScope.toogleOperationMessage(result);
                //spinner.stop();
                EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
            });
        }
    };

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

    $scope.regenerateFileFromDb = function () {
        //spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, true, true);
        $http.post('/DocumenteScanate/RegenerareFisierDinDb', { id: $scope.model.CurDocumentScanat.ID} )
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.result = response.data;
                    $rootScope.toogleOperationMessage($scope.result);
                    var thumbImgId = "#thumbImg_" + $scope.model.CurDocumentScanat.ID;
                    
                    for (var i = 0; i < $scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate.length; i++) {
                        if ($scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate[i].ID == $scope.model.CurDocumentScanat.ID) {
                            var tmp = $scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate[i].CALE_FISIER
                            $scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate[i].CALE_FISIER = null; // ca sa faca refresh la thumbnail
                            $scope.model.TipuriDocumente[$scope.curDocumentIndex].DocumenteScanate[i].CALE_FISIER = tmp;
                            break;
                        }
                    }
                    $scope.curThumb = null;
                    $scope.curThumb = $scope.getThumbnailFile($scope.model.CurDocumentScanat.CALE_FISIER, $scope.model.CurDocumentScanat.EXTENSIE_FISIER);
                    //$(thumbImgId).attr("src", path);
                    //$(thumbImgId).attr("src", $scope.getThumbnailFile($scope.model.CurDocumentScanat.CALE_FISIER, $scope.model.CurDocumentScanat.EXTENSIE_FISIER));
                    angular.element(document.querySelector(thumbImgId)).attr('src', $scope.curThumb);
                    angular.element(document.querySelector("#curThumbId")).attr('src', $scope.curThumb);
                }
                //spinner.stop();
                EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
            }, function (response) {
                //spinner.stop();
                EnableDisableInputs('#DocumenteMain', spinner, ACTIVE_DIV_ID, false, true);
                alert('Erroare: ' + response.status + ' - ' + response.data);
            });
    };

    $scope.GetTranslatedValue = function (key) {
        for (var i = 0; i < $scope.model.TranslatedTipDocumenteNames.length; i++) {
            if ($scope.model.TranslatedTipDocumenteNames[i][0] == key.replace(/ /g, '_')) {
                //console.log($scope.model.TranslatedTipDocumenteNames[i][0] + ' - ' + $scope.model.TranslatedTipDocumenteNames[i][1]);
                return $scope.model.TranslatedTipDocumenteNames[i][1];
                break;
            }
        }        
    };
});