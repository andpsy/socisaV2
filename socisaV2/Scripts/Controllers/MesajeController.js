﻿'use strict';

app.controller('MesajeController',
function ($scope, $http, $filter, $rootScope, $compile, $interval, myService) {
    $scope.lastActiveIdDosar = "";
    $scope.model = {};
    $scope.model.MesajJson = {};
    $scope.model.MesajJson.Sender = {};
    $scope.model.MesajJson.Mesaj = null;
    $scope.model.MesajJson.DataCitire = null;
    $scope.model.MesajJson.Receivers = [];
    $scope.model.InvolvedParties = [];
    $scope.model.MesajeJson = [];
    $scope.model.TipuriMesaj = [];
    $scope.result = {};
    $scope.involvedParty = "";
    $scope.tipMesaj = "";
    $scope.html2 = "";
    $scope.inbox = "Inbox";
    $scope.newMessages = "";
    $scope.editMode = 0;
    $scope.searchMode = 1;
    $scope.propertyName = 'Mesaj.DATA';
    $scope.reverse = true;
    $scope.queryMesaje = '1';
    $scope.queryTextMesaje = {};
    $scope.queryTextMesaje.$ = null;

    $scope.lastRefresh = new Date();
    $scope.$watch('searchMode', function (newValue, oldValue) {
        $rootScope.searchMode = newValue;
        console.log('mesaje - search: ' + newValue)
    });

    $scope.$watch('editMode', function (newValue, oldValue) {
        $rootScope.editMode = newValue;
        console.log('mesaje - edit: ' + newValue)
    });

    $interval(function () {
        if ($rootScope.ID_DOSAR == undefined) $rootScope.ID_DOSAR = null;
        console.log("iterval");
        if ($rootScope.ID_DOSAR != null) {
            if ($rootScope.activeTab.Value === 'mesaje')
                $scope.GetNewMessages($rootScope.ID_DOSAR);
        } else {
            $scope.GetNewMessages(null);
        }
    }, MESSAGES_REFRESH_RATE);
    

    /* -- nu putem schimba dosarul din tabul cu mesaje --
    $rootScope.$watch('ID_DOSAR', function (newValue, oldValue) {
        if (newValue != null && newValue != undefined && $rootScope.activeTab.Value == 'mesaje') {
            $scope.GetMessages(newValue);
            $scope.model.MesajJson.Mesaj.ID_DOSAR = newValue;
        }
    });
    */

    $rootScope.$watch('activeTab.Value', function (newValue, oldValue) {
        if (newValue != oldValue) {
            if (newValue == 'mesaje' && $rootScope.ID_DOSAR != null && $rootScope.ID_DOSAR != undefined && $scope.lastActiveIdDosar != $rootScope.ID_DOSAR) {
                console.log("activeTab - " + newValue + ' - ' + oldValue + ' || ' + $scope.lastActiveIdDosar + ' - ' + $rootScope.ID_DOSAR);
                $scope.GetMessages($rootScope.ID_DOSAR);
                $scope.lastActiveIdDosar = $rootScope.ID_DOSAR;
            }
        }
    });

    $scope.$watch('model.MesajJson.Mesaj.ID_TIP_MESAJ', function (newValue, oldValue) {
        try {
            document.getElementById("select_TipuriMesaj").value = newValue;
        } catch (e) { ; }
    });

    $scope.$watch('tipMesaj', function (newValue, oldValue) {
        try {
            $scope.model.MesajJson.Mesaj.ID_TIP_MESAJ = newValue;
        } catch (e) { ; }
    });

    $scope.applyFilter = function (element) {
        var idSoc = $('#idSoc').val();
        switch ($scope.queryMesaje) {
            case '1':
                return true;
                break;
            case '2': // mesaje Casco
                return element.Dosar.ID_SOCIETATE_CASCO == idSoc;
                break;
            case '3': // mesaje RCA
                return element.Dosar.ID_SOCIETATE_RCA == idSoc;
                break;
        }
    };

    $scope.filterByColumns = function (item) {
        if ($scope.queryTextMesaje.$ == null || $scope.queryTextMesaje.$ == "") return true;

        var toReturn1 = false;

        if ($scope.queryTextMesaje.$ != null && $scope.queryTextMesaje.$ != "") {
            for (var key_1 in item) { // sub objects (Dosar, AsiguratCasco, AutoCasco etc...)
                var subItem = item[key_1];
                for (var key_2 in subItem) {
                    try {
                        var str = subItem[key_2];
                        if (key_2.toLowerCase().indexOf("data") > -1) {
                            str = $filter('date')(str, $rootScope.DATE_FORMAT);
                        }
                        if (str.toString().toLowerCase().indexOf($scope.queryTextMesaje.$.toLowerCase()) > -1) {
                            //return true;
                            toReturn1 = true;
                            break;
                        }
                    } catch (e) {; }
                }
                if (toReturn1) break;
            }
        }
        else {
            toReturn1 = true;
        }
        return toReturn1;
    };

    $scope.AddReceiver = function () {
        var este = false;
        angular.forEach($scope.model.MesajJson.Receivers, function (value, key) {
            if (value.ID == $scope.involvedParty) {
                este = true;
                return;
            }
        });
        if (este) return;

        angular.forEach($scope.model.InvolvedParties, function (value, key) {
            if (value.ID == $scope.involvedParty) {
                $scope.model.MesajJson.Receivers.push(value);
            }
        });

        var select = document.getElementById("select_involvedParties");
        $scope.html2 = "";
        $scope.GenerateReceivers();
    };

    $scope.RemoveReceiver = function (ID) {
        var idx = -1;
        var i = 0;
        for (i = 0; i < $scope.model.MesajJson.Receivers.length; i++) {
            if ($scope.model.MesajJson.Receivers[i].ID == ID) {
                idx = i;
                break;
            }
        }
        $scope.model.MesajJson.Receivers.splice(idx, 1);
        var rec = document.getElementById("receiver_" + ID);
        rec.parentNode.removeChild(rec);
    };

    $scope.GetNewMessages = function (id_dosar) {
        //if (id_dosar == null) return;
        spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        //var j = {'id_dosar': id_dosar, 'last_refresh': $scope.lastRefresh};
        var j = { 'id_dosar': id_dosar, 'last_refresh': $filter('date')($scope.lastRefresh, $rootScope.DATE_TIME_FORMAT) };
        myService.getlist('POST', '/Mesaje/GetNewMessages', { j: JSON.stringify(j) })
          .then(function (response) {
              if (response.data == null || !response.data.Status || response.data.Result <= 0) {
                  $scope.newMessages = "";
              }
              else {
                  $scope.newMessages =  "(" + response.data.Result + " mesaje noi!)";
              }
              $scope.lastRefresh = new Date();
              spinner.stop();
          }, function (response) {
              spinner.stop();
              alert('Erroare: ' + response.status + ' - ' + response.data);
          });
    };

    $scope.GetSentMessages = function (id_dosar) {
        $scope.inbox = "Sent";
        spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        $scope.CancelMessage();
        myService.getlist('GET', '/Mesaje/GetSentMessages/' + id_dosar, null)
          .then(function (response) {
              if (response != 'null' && response != null && response.data != null) {
                  //$scope.html = response.data;
                  $scope.model = response.data;
              }
              else {
                  //$scope.html = "";
                  $scope.model = {};
              }
              spinner.stop();
          }, function (response) {
              spinner.stop();
              alert('Erroare: ' + response.status + ' - ' + response.data);
          });
    };

    $scope.GetMessages = function (id_dosar) {
        $scope.newMessages = "";
        $scope.inbox = "Inbox";
        spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        //$scope.CancelMessage();
        myService.getlist('GET', '/Mesaje/GetMessages/' + id_dosar, null)
          .then(function (response) {
              if (response != 'null' && response != null && response.data != null)
              {
                  //$scope.html = response.data;
                  $scope.model = response.data;
              }
              else {
                  //$scope.html = "";
                  $scope.model = {};
              }
              spinner.stop();
          }, function (response) {
              spinner.stop();
              alert('Erroare: ' + response.status + ' - ' + response.data);
          });
    };

    $scope.SelectMessage = function (mesaj) {
        $scope.editMode = 1;
        /*
        $scope.model.MesajJson = {};
        angular.copy(mesaj, $scope.model.MesajJson);
        $scope.tipMesaj = mesaj.Mesaj.ID_TIP_MESAJ;
        */
        //$scope.model.MesajJson = mesaj;
        angular.copy(mesaj, $scope.model.MesajJson);
        //$scope.tipMesaj = mesaj.Mesaj.ID_TIP_MESAJ;
        $scope.getInvolvedParties(mesaj.Mesaj.ID_DOSAR);
        $scope.GenerateReceivers();

        if ($scope.model.MesajJson.DataCitire == null) {
            spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            $scope.model.MesajJson.DataCitire = $filter('date')(new Date(), $rootScope.DATE_TIME_FORMAT);
            var data = $scope.model.MesajJson;
            $http.post('/Mesaje/SetDataCitire', data)
                .then(function (response) {
                    if (response != 'null' && response != null && response.data != null) {
                        //$scope.showMessage = true;
                        $scope.result = response.data;
                        if ($scope.result.Status) {
                            mesaj.DataCitire = $scope.model.MesajJson.DataCitire;
                        }
                    }
                    spinner.stop();
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                    spinner.stop();
                });
        }
    };

    $scope.GenerateReceivers = function () {
        $scope.html2 = "";
        angular.forEach($scope.model.MesajJson.Receivers, function (value, key) {
            $scope.html2 += ('<a style="margin:5px;" id="receiver_' + value.ID + '" href="#" ng-click="RemoveReceiver(' + value.ID + ')">' + value.NUME_COMPLET + ' (' + value.EMAIL + ')' + '&nbsp;<span class="badge">x</span></a>');
        });
    };

    $scope.SendMessage = function () {
        spinner.spin(document.getElementById(ACTIVE_DIV_ID));
        var data = $scope.model.MesajJson;
        $http.post('/Mesaje/Send', data)
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    $scope.showMessage = true;
                    $scope.result = response.data;
                    
                    $(".alert").delay(MESSAGE_DELAY).fadeOut(MESSAGE_FADE_OUT);
                    if ($scope.result.Status) {
                        /*
                        if ($scope.result.InsertedId != null) {
                            $scope.model.MesajJson.Mesaj.ID = $scope.result.InsertedId;
                            $scope.model.MesajeJson.push($scope.model.MesajJson);
                        }
                        */
                        $scope.editMode = 0;
                        $scope.GetMessages($rootScope.ID_DOSAR);
                    }
                }
                spinner.stop();
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
                spinner.stop();
            });
    };

    $scope.NewMessage = function () {
        var tmpIdDosar = $scope.model.MesajJson.Mesaj.ID_DOSAR;
        $scope.editMode = 2;
        $scope.model.MesajJson.Mesaj = {};
        $scope.model.MesajJson.Mesaj.ID_DOSAR = $rootScope.ID_DOSAR != null ? $rootScope.ID_DOSAR : tmpIdDosar;
        $scope.model.MesajJson.Mesaj.ID_TIP_MESAJ = $scope.getIdTipMesajByDenumire("OBIECTIUNI");
        $scope.model.MesajJson.Receivers = [];
        $scope.AddAllReceivers();
        //$scope.html2 = "";
    };

    $scope.AddAllReceivers = function () {
        for (var i = 0; i < $scope.model.InvolvedParties.length; i++) {
            //de omis userul curent
            $scope.model.MesajJson.Receivers.push($scope.model.InvolvedParties[i]);
        }
    };

    $scope.sortBy = function (propertyName) {
        $scope.reverse = ($scope.propertyName === propertyName) ? !$scope.reverse : false;
        $scope.propertyName = propertyName;
    };

    $scope.getDetaliiDosar = function (mesaj) {
        var toReturn = "Mergi la dosar... \n";
        toReturn += (mesaj.Dosar.NR_DOSAR_CASCO + "\n");
        return toReturn;
    };

    $scope.CancelMessage = function () {
        $scope.editMode = 0;
        $scope.model.MesajJson.Mesaj = {};
        $scope.model.MesajJson.Receivers = [];
        //$scope.html2 = "";
    };
    /*
    $scope.Reply = function () {
        $scope.editMode = 2;
        $scope.tempMesaj = angular.copy($scope.model.MesajJson);
        $scope.model.MesajJson.Mesaj = {};
        $scope.model.MesajJson.Mesaj.SUBIECT = "Re: " + $scope.tempMesaj.Mesaj.SUBIECT;
        $scope.model.MesajJson.Mesaj.BODY = $scope.tempMesaj.Mesaj.BODY;
        $scope.model.MesajJson.Receivers = [];
        $scope.model.MesajJson.Mesaj.REPLY_TO = $scope.tempMesaj.Mesaj.ID;
        $scope.model.MesajJson.Mesaj.ID_TIP_MESAJ = $scope.tempMesaj.Mesaj.ID_TIP_MESAJ;
        $scope.model.MesajJson.Mesaj.ID_DOSAR = $scope.tempMesaj.Mesaj.ID_DOSAR;
        for (var i = 0; i < $scope.model.InvolvedParties.length; i++) {
            //alert($scope.model.InvolvedParties[i].ID + ' - ' + $scope.tempMesaj.Mesaj.ID_SENDER);
            if ($scope.model.InvolvedParties[i].ID == $scope.tempMesaj.Mesaj.ID_SENDER) {
                $scope.model.MesajJson.Receivers.push($scope.model.InvolvedParties[i])
                break;
            }
        }
        $scope.GenerateReceivers();
    };
    */
    $scope.Reply = function () {
        $scope.editMode = 2;
        $scope.tempMesaj = angular.copy($scope.model.MesajJson);
        $scope.model.MesajJson.Mesaj = {};
        $scope.model.MesajJson.Mesaj.SUBIECT = "Re: " + $scope.tempMesaj.Mesaj.SUBIECT;
        $scope.model.MesajJson.Mesaj.BODY = $scope.tempMesaj.Mesaj.BODY;
        $scope.model.MesajJson.Receivers = [];
        $scope.AddAllReceivers();

        $scope.model.MesajJson.Mesaj.REPLY_TO = $scope.tempMesaj.Mesaj.ID;
        //$scope.model.MesajJson.Mesaj.ID_TIP_MESAJ = $scope.tempMesaj.Mesaj.ID_TIP_MESAJ;
        $scope.model.MesajJson.Mesaj.ID_TIP_MESAJ = $scope.getIdTipMesajByDenumire("RASPUNS OBIECTIUNI");
        $scope.model.MesajJson.Mesaj.ID_DOSAR = $scope.tempMesaj.Mesaj.ID_DOSAR;
    };

    $scope.getInvolvedParties = function (id_dosar) {
        $http.get('/Mesaje/GetInvolvedParties/' + id_dosar)
            .then(function (response) {
                if (response != 'null' && response != null && response.data != null) {
                    if (response.data.Status) {
                        $scope.model.InvolvedParties = response.data.Result;
                    }
                }
                spinner.stop();
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
                spinner.stop();
            });
    };

    $scope.getIdTipMesajByDenumire = function (denumire) {
        for (var i = 0; i < $scope.model.TipuriMesaj.length; i++) {
            if ($scope.model.TipuriMesaj[i].DENUMIRE == denumire) {
                return $scope.model.TipuriMesaj[i].ID;
            }
        }
        return null;
    };
});