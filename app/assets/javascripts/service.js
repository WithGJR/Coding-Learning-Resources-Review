(function(){
  var app = angular.module('postService', ['ngResource']);
  app.factory('Post', ['$resource', function($resource){
    return $resource('posts/:postId.json', {
      postId: "@id"
    }, {
      update: { method: "PUT" }
    });
  }]);
})();
