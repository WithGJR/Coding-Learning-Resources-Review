 (function(){
  var app = angular.module('reviewControllers', []);

  app.controller('TabController', function(){
    this.selectedTab = 1;
  });

  app.controller('FindController', ['Post', function(Post){
    this.posts = Post.query();
  }]);

  app.controller('ReadPostController', ['$http', '$routeParams', function($http, $routeParams){
    var readPostCtrl = this;
    this.post = {};
    this.id   = $routeParams.postId;

    $http.get('/posts/' + $routeParams.postId + '/reading-version').success(function(response){
      readPostCtrl.post = response;
    });
  }]);

  app.controller('EditPostController', ['Post', '$routeParams', function(Post, $routeParams){
    var editPostCtrl = this;
    this.post = Post.get({ postId: $routeParams.postId });

    this.submit = function(){
      editPostCtrl.post.$update(function(response){
        editPostCtrl.response = response;
      });
    };
  }]);

  app.controller('ManagePostController', ['$http', function($http){
    var user = this;
    $http.get('/user-posts').success(function(posts){
      user.posts = posts;
    });

  }]);

  app.controller('DeletePostController', ['$http',  function($http){
    this.delete = function(id){
      $http.delete('/posts/' + id).success(function(response){
        $('#' + id).closest('tr').remove();

        var message = '<div class="alert alert-info alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>' + response.message + '</div>';

        $('#message').html(message);
      });
    };
  }]);

  app.controller('PostController', ['Post',  function(Post){
    var postCtrl = this;

    this.post = {}; 
    this.response = {};

    this.create = function(){
      var newPost = new Post({ url: this.post.url, title: this.post.title, description: this.post.description });
      newPost.$save(function(response){
        postCtrl.response = response;    
      });
    };
  }]);
 })(); 
