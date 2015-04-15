describe "PostController", ->
  scope = null
  ctrl = null
  routeParams = null
  httpBackend = null
  flash = null
  postId = 42

  fakePost =
    id: postId
    title: "Baked Potatoes"
    text: "Pierce potato with fork, nuke for 20 minutes"

  setupController = (postExists = true)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope = $rootScope.$new()
      location = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.postId = postId
      flash = _flash_

      request = new RegExp("\/api/posts/#{postId}")
      results = if postExists
        [200, fakePost]
      else
        [404]

      httpBackend.expectGET(request).respond(results[0], results[1])


      ctrl = $controller('PostController',
        $scope: scope)
    )

  beforeEach(module("blog"))


  describe 'controller initialization', ->
    describe 'post is found', ->
      beforeEach(setupController())
      it 'loads the given post', ->
        httpBackend.flush()
        expect(scope.post).toEqualData(fakePost)
    describe 'post is not found', ->
      beforeEach(setupController(false))
      it 'loads the given post', ->
        httpBackend.flush()
        expect(scope.post).toBe(null)
        expect(flash.error).toBe("There is no post with ID #{postId}")