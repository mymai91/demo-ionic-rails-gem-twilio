'use strict';
angular.module('starter')
  /**
    * Verify Controller
    */
  .controller('VerifyPhoneController', function (
    $rootScope, $scope, userService, $state, dataShare
  ) {
    $scope.error = false
    $scope.verify = function(data) {
      data.phone = dataShare.data.phone
      userService
        .verifyPhone(data)
        .then(function successCallback(resp) {
          $scope.error = false
          $state.go('welcome')
        }, function errorCallback(resp) {
          $scope.error = true
          $scope.message = resp.data.errors
        });
    }
  });
