angular.module('PostController', []).controller("PostController",
  ($scope, $routeParams, $resource, $location, flash)->
    Post = $resource('/api/posts/:id', {id: "@id"}, {
      'save': {method: 'PUT'},
      'create': {method: 'POST'}
    })

    $scope.post = {}

    if $routeParams.id
      Post.get({id: $routeParams.id},
        ( (post)-> $scope.post = post ),
        ( (httpResponse)->
          flash.error = "There is no post with ID #{$routeParams.id}"
        )
      )

    $scope.back = -> $location.path("/")
    $scope.edit = -> $location.path("/posts/#{$scope.post.id}/edit")
    $scope.cancel = ->
      if $scope.post.id
        $location.path("/posts/#{$scope.post.id}")
      else
        $location.path("/")


    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.post.id
        $scope.post.$save(
          ( ()-> $location.path("/posts/#{$scope.post.id}") ),
          onError)
      else
        Post.create($scope.post,
          ( (newPost)-> $location.path("/posts/#{newPost.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.post.$delete()
      $scope.back()
)