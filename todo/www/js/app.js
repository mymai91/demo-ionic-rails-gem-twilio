// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
angular.module('starter', ['ionic', 'restangular'])
  .constant('ApiEndpoint', {
    url: 'http://192.168.0.101:8100/v1'
  })
  .config(function($httpProvider) {
    //Enable cross domain calls
    $httpProvider.defaults.useXDomain = true;
  })
  .run(function($ionicPlatform) {
    $ionicPlatform.ready(function() {
      // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
      // for form inputs)
      if(window.cordova && window.cordova.plugins.Keyboard) {
        cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      }
      if(window.StatusBar) {
        StatusBar.styleDefault();
      }
    })
  })

  .config(function(
    $stateProvider,
    $urlRouterProvider) {
    $stateProvider
      .state('verify',{
        url: "/verify",
        templateUrl: "templates/verify.html",
        controller: "VerifyPhoneController"
      })
      .state('home', {
        url: '/',
        templateUrl: 'templates/phone.html',
        controller: 'PhoneController'
      })
      .state('welcome', {
        url: '/welcome',
        templateUrl: 'templates/welcome.html'
      })

    $urlRouterProvider.otherwise('/');
  });
