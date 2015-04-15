describe "PostsController", ->
  scope = null
  ctrl = null
  location = null
  routeParams = null
  resource = null


  # access injected service later
  httpBackend = null

  setupController = (keywords, results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope = $rootScope.$new()
      location = $location
      resource = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      # capture the injected service
      httpBackend = $httpBackend

      if results
        request = new RegExp("\/api/posts.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)


      ctrl = $controller('PostsController',
        $scope: scope
        $location: location)
    )

  beforeEach(module("blog"))


  describe 'controller initialization', ->
    describe 'when no keywords present', ->
      it 'defaults to no posts', ->
        expect(scope.posts).toEqualData([])

      beforeEach(setupController())

    describe 'with keywords', ->
      keywords = 'foo'
      posts = [
        {
          id: 2
          title: 'Baked Potatoes'
        },
        {
          id: 4
          title: 'Potatoes Au Gratin'
        }
      ]
      beforeEach ->
        setupController(keywords, posts)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.posts).toEqualData(posts)

  describe 'search()', ->
    it 'redirects to itself with a keyword param', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe('/')
      expect(location.search()).toEqualData({keywords: keywords})

