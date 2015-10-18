angular.module('starter')
  .factory('userService', function (Restangular, ApiEndpoint) {
    console.log('ApiEndpoint', ApiEndpoint)
    return {
      sendPhone: function (data) {
        var service = Restangular.allUrl('verifyphone', ApiEndpoint.url + '/users/send');
        return service.post(data);
      },
      verifyPhone: function (data) {
        var service = Restangular.allUrl('verifyphone', ApiEndpoint.url + '/users/verify');
        return service.post(data);
      }
    }
  });
