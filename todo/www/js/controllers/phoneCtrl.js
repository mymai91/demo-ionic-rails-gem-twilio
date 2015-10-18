'use strict';
angular.module('starter')
  /**
    * Phone Controller
    */
  .controller('PhoneController', function (
    $scope, userService, $state, dataShare
  ) {
    $scope.error = false
    $scope.sendPhone = function(data) {
      userService
        .sendPhone(data)
        .then(function successCallback(resp) {
          dataShare.data = data
          console.log(dataShare.data)
          $scope.error = false
          $state.go('verify')
        }, function errorCallback(resp) {
          $scope.error = true
          $scope.message = resp.data.errors
        });
    }
  });
