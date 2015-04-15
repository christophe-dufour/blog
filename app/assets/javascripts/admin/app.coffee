"use strict";

app = angular.module('blog', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

app.config(['$routeProvider', 'flashProvider',
  ($routeProvider, flashProvider)->
    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
    .when('/',
      templateUrl: "index.html"
      controller: 'PostsController'
    )
    .when('/posts/:id',
      templateUrl: "posts/show.html"
      controller: 'PostController'
    )
])
