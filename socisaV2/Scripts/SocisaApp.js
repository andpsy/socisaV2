var MESSAGE_DELAY = 5000;
var SUCCESS_MESSAGE_DELAY = 5000;
var ERROR_MESSAGE_DELAY = 15000;
var MESSAGE_FADE_OUT = 2000;
var MESSAGES_REFRESH_RATE = 1200000;
var DATE_FORMAT = 'dd.MM.yyyy';
var DATE_TIME_FORMAT = 'dd.MM.yyyy HH:mm:ss';
var ACTIVE_DIV_ID = 'mainDashboard';
var LOGOUT_INTERVAL = 1200000;
var LOGOUT_NO_CONFIRM = 10000;
var CULTURE_INFO = 'ro-RO';

//var SEND_STATUS = ["Send", "Delivery", "Bounce", "Complaint", "Reject", "Open", "Click", "Failure"];

var spinner = new Spinner(opts);
var spinnerSmall = new Spinner(optsSmall);

/*
function ValidateEmail(email) {
    var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    return email.match(mailformat);
}
*/
function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}
function isEmptyJson(obj) {
    for (var prop in obj) {
        if (obj.hasOwnProperty(prop)) {
            return false;
        }
    }
    return JSON.stringify(obj) === JSON.stringify({});
}
function isNullOrEmptyJson(obj) {
    if (obj === null) return true;
    return isEmptyJson(obj);
}

function openNav() {
    document.getElementById("mySidenav").style.width = "200px";
    //document.getElementById("main").style.marginLeft = "250px";
    document.getElementById(ACTIVE_DIV_ID).style.marginLeft = "250px";
}
function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    //document.getElementById("main").style.marginLeft = "50px";
    document.getElementById(ACTIVE_DIV_ID).style.marginLeft = "50px";
}

function format(amount) {
    if (amount.length == 0) {
        return '0,00';
    }
    if (amount.length == 1) {
        return '0,0' + amount;
    }
    if (amount.length == 2) {
        return '0,' + amount;
    }

    var i, j, aux2, ret;
    if (amount.length > 2) {
        aux2 = '';
        for (j = 0, i = amount.length - 3; i >= 0; i--) {
            if (j == 3) {
                aux2 += '.';
                j = 0;
            }
            aux2 += amount.charAt(i);
            j++;
        }
        ret = '';
        len2 = aux2.length;
        for (i = len2 - 1; i >= 0; i--) {
            ret += aux2.charAt(i);
        }
        ret += ',' + amount.substr(amount.length - 2, amount.length);
    }
    return ret;
};

function setRequiredFields() {
    $('*').each(function () {
        var req = $(this).attr('data-val-required');
        if (undefined != req) {
            var label = $('label[for="' + $(this).attr('id') + '"]');
            var text = label.text();
            if (text.length > 0) {
                label.append('<span style="color:red"> *</span>');
            }
        }
    });
};

function EnableDisableInputs(_input, _spinner, _spinner_div_id, _disable, _show_modal) {
    var spinner_div = document.getElementById(_spinner_div_id);
    if (_show_modal) {
        if (_disable) {
            $("#modal-background").show();
        }
        else {
            $("#modal-background").hide();
        }
    }

    /*
    $(_input).prop('disabled', _disable);
    $(_input).children().prop('disabled', _disable);
    var _descendants = _input + ' *';
    $(_descendants).prop('disabled', _disable);
    */
    if (_disable) 
        $(_input).addClass('disabled');
    else
        $(_input).removeClass('disabled');

    if (_spinner != null && _spinner_div_id != null) {
        if (_disable)
            _spinner.spin(spinner_div);
        else
            _spinner.stop();
    }
};

function ToggleDivCss(divId) {
    var did = '#' + divId;
    var top = document.getElementById(ACTIVE_DIV_ID).offsetTop;
    var left = document.getElementById(ACTIVE_DIV_ID).offsetLeft;
    var height = document.getElementById(ACTIVE_DIV_ID).offsetHeight;
    var width = document.getElementById(ACTIVE_DIV_ID).offsetWidth;
    var right = left + width;
    document.getElementById(divId).style.marginLeft = document.getElementById(ACTIVE_DIV_ID).style.marginLeft;
    var tmpAId = '#' + ACTIVE_DIV_ID;
    $(tmpAId).fadeOut(1000, function () {
        $(did).fadeIn(1000);
        /*
        var mDiv = document.getElementById(divId);
        var oDiv = document.getElementById(ACTIVE_DIV_ID);
        var tmpId = mDiv.id;
        mDiv.id = oDiv.id;
        oDiv.id = tmpId;
        */
        ACTIVE_DIV_ID = divId;
    });
};

var app = angular.module('SocisaApp', ['ngFileUpload', 'ngAnimate', 'ngDialog', 'chart.js'], ['$httpProvider', function ($httpProvider) {

    $httpProvider.interceptors.push(['$rootScope', '$q', '$timeout', '$window', function ($rootScope, $q, $timeout, $window) {
        return {
            'responseError': function (response) {
                var status = response.status;
                var data = response.data;
                //var routes = { '401': 'show-login', '500': 'server-error' };
                if (status == 500 && data.indexOf('anti-forgery token') > -1) {
                    //$rootScope.$broadcast("ajaxError", { template: routes[status] });
                    alert('Ati deschis o alta sesiune de lucru intr-o alta fereastra! Veti fi delogat!');
                    $timeout(function () {
                        $window.location.href = '/Utilizatori/Logout';
                    }, MESSAGE_DELAY);                    
                }

                return $q.reject(response);
            }
        };
    }]);
}]);
/*
app.service('refreshService', function () {
    var objectValue = {};

    return {
        get: function () {
            return objectValue;
        },
        set: function (value) {
            objectValue = value;
        }
    }
});
*/
app.run(function ($http) {
    $http.defaults.headers.common['__RequestVerificationToken'] = angular.element('input[name="__RequestVerificationToken"]').attr('value');
    $http.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

    //disable IE ajax request caching
    $http.defaults.headers.common['If-Modified-Since'] = 'Mon, 26 Jul 1997 05:00:00 GMT';
    // extra
    $http.defaults.headers.common['Cache-Control'] = 'no-cache';
    $http.defaults.headers.common['Pragma'] = 'no-cache';
});

app.run(function ($rootScope, $http, $timeout, ngDialog) {
    $rootScope.CULTURE_INFO = CULTURE_INFO;

    $rootScope.DATE_FORMAT = DATE_FORMAT;
    $rootScope.DATE_TIME_FORMAT = DATE_TIME_FORMAT;
    $rootScope.ID_DOSAR = null;

    $rootScope.operationResult = {};
    $rootScope.operationResult.Results = new Array();
    $rootScope.operationResult.ShowMessage = false;
    /*
    $rootScope.operationResult.Status = true;
    $rootScope.operationResult.Message = "";
    */

    $rootScope.divId = ACTIVE_DIV_ID;
    $rootScope.HasHtml = []; // aici stocam id-urile div-urilor generate deja, ca sa nu le incarcam de fiecare data.
    $rootScope.HasHtml.push(ACTIVE_DIV_ID);
    $rootScope.Url = "";
    $rootScope.ExternalUser = {};
    $rootScope.ExternalUser.Value = false;
    $rootScope.calitateSocietateCurenta = {};
    $rootScope.calitateSocietateCurenta.Value = 'CASCO';
    $rootScope.activeTab = {};
    $rootScope.activeTab.Value = "detalii";
    $rootScope.editMode = 0;
    $rootScope.searchMode = 1;

    $rootScope.SEND_STATUS = [
        { "notification": "Send", "back_color": "lightblue", "fore_color": "black" },
        { "notification": "Delivery", "back_color": "lightgreen", "fore_color": "black" },
        { "notification": "Bounce", "back_color": "red", "fore_color": "white" },
        { "notification": "Complaint", "back_color": "red", "fore_color": "white" },
        { "notification": "Reject", "back_color": "red", "fore_color": "white" },
        { "notification": "Failure", "back_color": "red", "fore_color": "white" },
        { "notification": "Open", "back_color": "lightgreen", "fore_color": "black" },
        { "notification": "Click", "back_color": "lightgreen", "fore_color": "black" }];

    $rootScope.getIndex = function (search_array_items, searched_item) {
        try {
            for (var i = 0; i < search_array_items.length; i++) {
                if (searched_item.ID == search_array_items[i].ID) {
                    return i;
                }
            }
            return null;
        } catch (err) {
            return null;
        }
    }

    $rootScope.$watch('ExternalUser.Value', function (newValue, oldValue) {
        //alert(newValue);
    });

    $rootScope.toogleOperationMessage = function (result) {
        $rootScope.operationResult.ShowMessage = true;
        $rootScope.operationResult.Results.push(result);
        //$rootScope.operationResult.Status = result.Status;
        //$rootScope.operationResult.Message = result.Message;
        /*
        $('#operationResult').show();
        //$("#operationResult").delay(MESSAGE_DELAY).fadeOut(MESSAGE_FADE_OUT);
        $timeout(function () {
            $("#operationResult").fadeOut(MESSAGE_FADE_OUT);
            $timeout(function () {
                $rootScope.operationResult.ShowMessage = false;
                $rootScope.operationResult.Results = new Array();
            }, MESSAGE_FADE_OUT);
        }, MESSAGE_DELAY);
        */
        var innerDivId = '#operationResultInnerDiv_' + ($rootScope.operationResult.Results.length - 1);
        //alert(innerDivId);
        $(innerDivId).show();
        //if (result.Status)  // ascundem doar mesajele de succes, pe cele cu erori la pastram
        {
            $timeout(function () {
                $(innerDivId).fadeOut(MESSAGE_FADE_OUT);
                $timeout(function () {
                    $rootScope.operationResult.Results.splice($rootScope.operationResult.Results.length - 1);
                    if ($rootScope.operationResult.Results.length == 0) {
                        $rootScope.operationResult.ShowMessage = false;
                    }
                }, MESSAGE_FADE_OUT);
            }, result.Status ? SUCCESS_MESSAGE_DELAY : ERROR_MESSAGE_DELAY);
        }
    };

    $rootScope.ToggleDiv = function (divId, generateContent, params, method) {
        $rootScope.ToggleDiv(divId, generateContent, params, method, null);
    };

    $rootScope.ToggleDiv = function (divId, generateContent, params, method, method_name) {
        /* -- nu mai e cazul ca folosim GetFiltered si pt. link cu ID --
        if (!isNaN(parseFloat(params)) && isFinite(params))
            $rootScope.ID_DOSAR = params;
        */
        /*
        if (divId != "mainDosareDashboard" && generateContent && $rootScope.ID_DOSAR != null) // pastram id-ul dosarului curent din div-ul de dosare, pentru revenire.
        {
            console.log('1 - ' + $rootScope.ID_DOSAR + ' - ' + $rootScope.TEMP_ID_DOSAR);
            $rootScope.TEMP_ID_DOSAR = $rootScope.ID_DOSAR;
            $rootScope.ID_DOSAR = null;
        }
        if (divId == "mainDosareDashboard" && generateContent && $rootScope.TEMP_ID_DOSAR != null) // pastram id-ul dosarului curent din div-ul de dosare, pentru revenire.
        {
            console.log('2 - ' + $rootScope.ID_DOSAR + ' - ' + $rootScope.TEMP_ID_DOSAR);
            $rootScope.ID_DOSAR = $rootScope.TEMP_ID_DOSAR;
            $rootScope.TEMP_ID_DOSAR = null;
        }
        */
        $rootScope.divId = divId;
        if ((!generateContent && $rootScope.HasHtml.indexOf(divId) > -1)) // && (params == null || params == undefined))  // mai trebuie sa punem conditia pt. id generat deja (link dosare)
        {
            console.log('aici3 - ' + divId);
            ToggleDivCss(divId);
            return;
        }
        else {
            if (method_name != null) {
                $rootScope.Url = method_name;
            }
            else {
                //var url = '';
                switch (divId) {
                    case "mainDashboard":
                        //url = '@Url.Action("Index", "Dosare")';
                        $rootScope.Url = '/Dashboard/IndexMain';
                        break;
                    case "mainDosareDashboard":
                        //url = '@Url.Action("Index", "Dosare")';
                        $rootScope.Url = method == 'post' ? '/Dosare/IndexPost' : '/Dosare/Index';
                        break;
                    case "mainDosareDashboardAdminAndSuper":
                        //url = '@Url.Action("GetDosareDashboardAdminAndSuper", "Dashboard")';
                        $rootScope.Url = '/Dashboard/GetDosareDashboardAdminAndSuper/1';
                        break;
                    case "mainDosareDashboardRegular":
                        //url = '@Html.Raw(Url.Action("GetDosareDashboardRegular", "Dashboard"))';
                        $rootScope.Url = '/Dashboard/GetDosareDashboardRegular';
                        break;
                    case "mainMesajeDashboard":
                        //url = '@Html.Raw(Url.Action("IndexMain", "Mesaje"))';
                        $rootScope.Url = '/Mesaje/IndexMain';
                        break;
                    case "mainUtilizatoriDashboard":
                        //url = '@Html.Raw(Url.Action("Index", "Utilizatori"))';
                        $rootScope.Url = '/Utilizatori/Index';
                        break;
                    case "mainDosareImportDashboard":
                        //url = '@Html.Raw(Url.Action("Import", "Dosare"))';
                        $rootScope.Url = '/Dosare/Import';
                        break;
                    case "mainPlatiImportDashboard":
                        //url = '@Html.Raw(Url.Action("Import", "Plati"))';
                        $rootScope.Url = '/Plati/Import';
                        break;
                    case "mainFileManagerDashboard":
                        //url = '@Html.Raw(Url.Action("Index", "FileManager"))';
                        $rootScope.Url = '/FileManager/Index';
                        break;
                    case "mainSocietatiAsigurareDashboard":
                        //url = '@Html.Raw(Url.Action("Index", "SocietatiAsigurare"))';
                        $rootScope.Url = '/SocietatiAsigurare/Index';
                        break;
                    case "mainStadiiDashboard":
                        //url = '@Html.Raw(Url.Action("Index", "Stadii"))';
                        $rootScope.Url = '/Stadii/Index';
                        break;
                    case "mainContactDashboard":
                        $rootScope.Url = '/Home/Contact';
                        break;
                    case "mainDespreDashboard":
                        $rootScope.Url = '/Home/About';
                        break;
                    case "mainCompensariDashboard":
                        $rootScope.Url = '/Compensari/Index';
                        break;
                    case "mainRapoarteDashboard":
                        $rootScope.Url = '/Rapoarte/Index';
                        break;
                    case "mainSedintePortalDashboard":
                        $rootScope.Url = '/DosarePortal/SedinteIndex';
                        break;
                    case "mainNotificariEmailDashboard":
                        $rootScope.Url = '/NotificariEmail/Index/null';
                        break;
                }
            }
            if (params != null && params != undefined && method == 'get') {
                //if (!isNaN(parseFloat(params)) && isFinite(params)) {
                    $rootScope.Url += "/" + params;
                //}
            }
            var did = '#' + divId;

            spinner.spin(document.getElementById(ACTIVE_DIV_ID));
            var http = null;
            if (method == 'post') {
                http = $http.post($rootScope.Url, { _params: JSON.stringify(params) });;
            }
            else {
                http = $http.get($rootScope.Url);
            }
            http.then(function (response) {
                spinner.stop();
                if (response != 'null' && response != null && response.data != null) {
                    $rootScope.html = response.data;
                    ToggleDivCss(divId);
                }
            }, function (response) {
                alert('Erroare: ' + response.status + ' - ' + response.data);
                spinner.stop();
            });
        }
    };

    $rootScope.$on('refreshRootScopeDashboardEmitEvent', function (event, data) {
        $rootScope.$broadcast('refreshDashboardBroadcastEvent', data);
    });
});

app.directive('dynamic', function ($compile, $rootScope) {
    return {
        restrict: 'A',
        replace: true,
        scope: true,
        link: function (scope, ele, attrs) {
            scope.$watch(attrs.dynamic, function (newValue, oldValue) {
                //console.log(ele.attr('id') + ' - ' + $rootScope.divId + ' - ' + ACTIVE_DIV_ID + ' - ' + $rootScope.HasHtml.indexOf(ele.attr('id')));
                if (ele.attr('id') == $rootScope.divId && ($rootScope.HasHtml.indexOf(ele.attr('id')) == -1 || newValue != oldValue)) {
                    ele.html(newValue);
                    $compile(ele.contents())(scope);
                    $rootScope.HasHtml.push(ele.attr('id'));
                    //console.log('aici2 - ' + ele.attr('id'));
                }
            });
        }
    };
});
/*
app.directive('dynamic2', function ($compile) {
    return {
        restrict: 'A',
        replace: true,
        link: function (scope, ele, attrs) {
            scope.$watch(attrs.dynamic2, function (html) {
                ele.html(html);
                $compile(ele.contents())(scope);
            });
        }
    };
});
*/
app.config(['$compileProvider',
  function($compileProvider) {
      $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|file|ftp|blob):|data:image\//);
  }
]);
/*
app.config(['$httpProvider', function ($httpProvider) {
    $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';
}]);
*/
app.filter("dateFilter", function () {
    return function (item) {
        if (item != null) {
            if (Object.prototype.toString.call(item) === '[object Date]' || jQuery.type(item) === 'date' || (Date.parse(item) !== 'Invalid Date' && !isNaN(Date.parse(item)) && !isNaN(new Date(item).getMonth()) ))
                return item;
            else
                return new Date(parseInt(item.substr(6)));
        }
        return "";
    };
});

app.filter('getById', function () {
    return function (input, id) {
        var i = 0, len = input.length;
        for (; i < len; i++) {
            if (+input[i].ID == +id) {
                return input[i];
            }
        }
        return null;
    }
});

app.filter('bytetobase', function () {
    return function (buffer) {
        var binary = '';
        var bytes = new Uint8Array(buffer);
        var len = bytes.byteLength;
        for (var i = 0; i < len; i++) {
            binary += String.fromCharCode(bytes[i]);
        }
        return window.btoa(binary);
    };
});
/*
//only file definition
app.directive("fileread", [function () {
    return {
        scope: {
            fileread: "="
        },
        link: function (scope, element, attributes) {
            element.bind("change", function (changeEvent) {
                scope.$apply(function () {
                    scope.fileread = changeEvent.target.files[0];
                    // or all selected files:
                    // scope.fileread = changeEvent.target.files;
                });
            });
        }
    }
}]);
*/
//full file content
app.directive("fileread", [function () {
    return {
        scope: {
            fileread: "="
        },
        link: function (scope, element, attributes) {
            element.bind("change", function (changeEvent) {
                var reader = new FileReader();
                reader.onload = function (loadEvent) {
                    scope.$apply(function () {
                        scope.fileread = loadEvent.target.result;
                    });
                }
                reader.onerror = function (loadEvent) {
                    alert("Error!");
                }
                //reader.readAsDataURL(changeEvent.target.files[0]);
                reader.readAsArrayBuffer(changeEvent.target.files[0]);
            });
        }
    }
}]);

app.directive('jqdatepicker', function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, element, attrs, ctrl) {
            //$('#ui-datepicker-div').css('z-index', 99999999999999);
            $(element).datepicker({
                dateFormat: 'dd.mm.yy',
                changeMonth: true,
                changeYear: true,
                //beforeShow: function () { $('#ui-datepicker-div').css('z-index', 99999999999999); },
                onSelect: function (date) {
                    ctrl.$setViewValue(date);
                    ctrl.$render();
                    scope.$apply();
                }
            });
        }
    };
});

app.service("PromiseUtils", function ($q) {
    return {
        getPromiseHttpResult: function (httpPromise) {
            var deferred = $q.defer();
            httpPromise.then(function (data) {
                deferred.resolve(data);
            },function () {
                deferred.reject(arguments);
            });
            return deferred.promise;
        }
    }
});

app.factory('myService', function ($http, $q) {

    this.getlist = function (method, url, data) {
        if (method == 'GET') {
            return $http.get(url)
                .then(function (response) {
                    return response;
                }, function (response) {
                    return response;
                })
        }
        if (method == 'POST') {
            return $http.post(url, data)
                .then(function (response) {
                    return response;
                }, function (response) {
                    return response;
                })
        }
    }
    return this;
});

app.directive('aDisabled', function() {
    return {
        compile: function(tElement, tAttrs, transclude) {
            //Disable ngClick
            tAttrs["ngClick"] = "!("+tAttrs["aDisabled"]+") && ("+tAttrs["ngClick"]+")";

            //Toggle "disabled" to class when aDisabled becomes true
            return function (scope, iElement, iAttrs) {
                scope.$watch(iAttrs["aDisabled"], function(newValue) {
                    if (newValue !== undefined) {
                        iElement.toggleClass("disabled", newValue);
                    }
                });

                //Disable href on click
                iElement.on("click", function(e) {
                    if (scope.$eval(iAttrs["aDisabled"])) {
                        e.preventDefault();
                    }
                });
            };
        }
    };
});

app.directive('numberFormat', function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, element, attr, ctrl) {
            var strCheck = '0123456789';

            element.css({
                'text-align': 'right'
            });
            element.on('mouseup', function (event) {
                /*
                if (element.val() == '')
                    element.val('0,00');
                */
                if (ctrl.$viewValue == '') {
                    ctrl.$setViewValue('0,00');
                    ctrl.$render();
                }
            });
            element.on('focus', function (event) {
                element.css({
                    'color': '#0D0D49',
                    'font-weight':'bold'
                });
            });
            element.on('blur', function (event) {
                element.css({
                    'color': 'black',
                    'font-weight': 'normal'
                });
            });
            element.on('keydown', function (event) {
                event.preventDefault();
                /*
                if (element.val() == '')
                    element.val('0,00');
                */
                if (ctrl.$viewValue == '') {
                    ctrl.$setViewValue('0,00');
                    ctrl.$render();
                }
                ///if (!formatElementAmount(event, element.val())) {
                if (!formatElementAmount(event, ctrl.$viewValue)) {
                    Event.stop(event);
                }
            });

            function formatElementAmount(e, amount) {
                amount = amount.replace(/\./g, "");
                amount = amount.replace(/\,/g, "");
                amount = parseFloat(amount);
                amount = amount + ''; //tostring

                //var element = document.getElementById((e.target || e.srcElement).id);
                var strCheck = '0123456789';

                var whichCode = e.which || e.keyCode;
                if (whichCode == 13) {
                    return false;  // Enter
                }

                //tab it's ok
                if (whichCode == 9)
                    return true;
                // backspace should revert to previously entered data
                if (whichCode == 8 || whichCode == 46) {
                    if (amount.length > 0) {
                        amount = amount.substring(0, amount.length - 1);
                        //element.value = '';
                        //element.val('');
                    }
                    //element.value = format(amount);
                    //element.val(format(amount));
                    ctrl.$setViewValue(format(amount));
                    ctrl.$render();
                    return false;
                }

                //if (element.val().length > 27) {
                if (ctrl.$viewValue.length > 27) {
                    //element.val('');
                    //element.val(format(amount));
                    ctrl.$setViewValue(format(amount));
                    ctrl.$render();
                    //scope.$apply();
                    return false;
                }


                if (whichCode >= 96 && whichCode <= 105)
                    whichCode = whichCode - 48;
                key = String.fromCharCode(whichCode);  // Get key value from key code


                if (strCheck.indexOf(key) == -1) {
                    return false;  // Not a valid key
                }

                if ((amount.length == 0) && (key == '0'));
                else
                    amount = amount + key;

                var formatedAmount = format(amount);
                //element.val('');
                //element.val(formatedAmount);
                //alert(formatedAmount);
                ctrl.$setViewValue(formatedAmount);
                ctrl.$render();
                //e.preventDefault();
                //ctrl.$modelValue = formatedAmount;
                //scope.$apply();
                console.log('viewValue2 - ' + ctrl.$viewValue + ' / modelValue2 - ' + ctrl.$modelValue);

                return false;
            }
        }
    };
});