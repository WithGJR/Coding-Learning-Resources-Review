(function(){
  var app = angular.module('review', ['ngRoute', 'reviewControllers', 'postService', 'ngSanitize']);
  app.config(['$routeProvider',
    function($routeProvider) {
      $routeProvider.
        when('/', {
          templateUrl: 'partials/home.html'
        }).
        when('/about', {
          templateUrl: 'partials/about.html',
        }).
        when('/find', {
          templateUrl: 'partials/find.html',
          controller : 'FindController'
        }).
        when('/share', {
          templateUrl: '/share.html',
          controller : 'PostController'
        }).
        when('/manage', {
          templateUrl: '/manage.html',
          controller : 'ManagePostController'
        }).
        when('/posts/:postId', {
          templateUrl: 'partials/post.html',
          controller : 'ReadPostController'
        }).
        when('/posts/:postId/edit', {
          templateUrl: 'partials/post-edit.html',
          controller : 'EditPostController'
        }).
        otherwise({
          redirectTo: '/'
        });
  }]);
})();

