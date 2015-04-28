angular.module('PostsController', []).controller("PostsController",
  ($scope, $routeParams, $location, $resource, flash)->
    Post = $resource('/api/posts/:id', {id: "@id"})
    $scope.search = (keywords)-> $location.path("/").search('keywords', keywords)
    $scope.posts = []
    $scope.view = (postId)-> $location.path("/posts/#{postId}")
    $scope.edit = (post)-> $location.path("/posts/#{post.id}/edit")
    onError = (_httpResponse)-> flash.error = "Something went wrong"
    $scope.delete = (post) ->
      if confirm 'Are sure sure?'
        Post.delete(post,
          ( ()->
            index = $scope.posts.indexOf(post)
            $scope.posts.splice(index, 1)
          ),
          onError
        )


    PublishPost = $resource('/api/posts/:id/publish', {id: "@id"}, {
      'publish': {method: 'POST'},
      'unpublish': {method: 'DELETE'}
    })

    $scope.publish = (post) ->
      PublishPost.publish(post,
        ()-> post.published_at = Date.now,
        onError
      )
    $scope.unpublish = (post) ->
      PublishPost.unpublish(post
        ()-> post.published_at = null,
        onError
      )


    $scope.newPost = -> $location.path("/posts/new")

    Post.query(keywords: $routeParams.keywords, (results)-> $scope.posts = results)
)


