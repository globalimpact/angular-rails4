//= require jquery
//= require jquery_ujs
//= require foundation


// Foundation Startup
$(function(){ $(document).foundation(); });

// Angular App

window.App = angular.module('angular-rails4', ['ngResource']);


// Post Controller
App.factory('Post', [
  '$resource', function($resource) {
    return $resource('/api/posts/:id', {
      id: '@id'
    });
  }
]);

App.controller('PostsCtrl', [
  '$scope', 'Post', function($scope, Post) {
    return $scope.posts = Post.query();
  }
]);