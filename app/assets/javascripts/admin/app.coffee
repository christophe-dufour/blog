app = angular.module('blog', [
  'templates',
  'ngRoute',
  'ngResource',
  'ngSanitize',
  'PostController',
  'PostsController',
  'angular-flash.service',
  'angular-flash.flash-alert-directive',
  'ngS3upload'
])

app.config(
  ($routeProvider, flashProvider)->
    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
    .when('/',
      templateUrl: "index.html"
      controller: 'PostsController'
    ).when('/posts/new',
      templateUrl: "posts/form.html"
      controller: 'PostController'
    ).when('/posts/:id',
      templateUrl: "posts/show.html"
      controller: 'PostController'
    ).when('/posts/:id/edit',
      templateUrl: "posts/form.html"
      controller: 'PostController'
    )
)
