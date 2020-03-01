'use strict';
app.controller('TestController',
    function ($scope, $http, $filter, $rootScope, $window, Upload) {
        /*
        $scope.save = function () {
            var image = document.getElementById("sketchpad").toDataURL("image/png");
            image = image.replace('data:image/png;base64,', '');
            $("#imageData").val(image);

            $.ajax({
                type: 'POST',
                url: '/Test/UploadImage',
                data: '{ "imageData" : "' + image + '" }',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json'
            }).done(function (data) {
                alert('Image saved successfully !');
            }).fail(function (jqXHR, textStatus) {
                alert(textStatus);
            });
        };
        */
        $scope.save = function () {
            var image = document.getElementById("sketchpad").toDataURL("image/png");
            image = image.replace('data:image/png;base64,', '');
            $http.post('/Test/UploadImage', { imageData: image }, { responseType: 'arraybuffer' })
                .then(function (response) {
                    alert('Image saved successfully !');
                    var blob = new Blob([response.data], { type: "application/pdf" });
                    var objectUrl = URL.createObjectURL(blob);
                    window.open(objectUrl);
                }, function (response) {
                    alert('Erroare: ' + response.status + ' - ' + response.data);
                });
        };
});