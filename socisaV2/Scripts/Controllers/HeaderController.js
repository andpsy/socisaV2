app.controller('HeaderController', function ($rootScope, $scope, $http, ngDialog) {

    $scope.ShowContact = function () {
        ngDialog.open({
            template: $rootScope.ExternalUser.Value ? '../../Contact.html' : '../Contact.html',
            className: 'ngdialog-theme-default'
        });
    };

    $scope.ShowDespre = function () {
        ngDialog.open({
            template: $rootScope.ExternalUser.Value ? '../../About.html' : '../About.html',
            className: 'ngdialog-theme-default custom-width'
        });
    };

    $scope.ChangeCulture = function (culture) {
        EnableDisableInputs('#main_container', spinner, '#main_container', true, true);
        $rootScope.CULTURE_INFO = culture;
        $http.post('/Utilizatori/ChangeCulture', { culture: culture })
            .then(function (response) {
                console.log('ok');
                location.reload();
                EnableDisableInputs('#main_container', spinner, '#main_container', false, true);
            }, function (response) {
                EnableDisableInputs('#main_container', spinner, '#main_container', false, true);
                alert('Erroare: ' + response.status + ' - ' + response.data);
            });
    };
        
});