"use strict";

controllers = angular.module('controllers', [])

controllers.controller("PostsController", ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    $scope.search = (keywords)-> $location.path("/").search('keywords', keywords)
    $scope.posts = []
    $scope.view = (postId)-> $location.path("/posts/#{postId}")
    Post = $resource('/api/posts/:postId', {postId: "@id"})
    Post.query(keywords: $routeParams.keywords, (results)-> $scope.posts = results)
])


controllers.controller("PostController", ['$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope, $routeParams, $resource, $location, flash)->
    Post = $resource('/api/posts/:id', {id: "@id"})
    Post.get({id: $routeParams.id},
      ( (post)-> $scope.post = post ),
      ( (httpResponse)->
        $scope.post = null
        flash.error = "There is no post with ID #{$routeParams.id}"
      )
    )

    $scope.back = -> $location.path("/")
])