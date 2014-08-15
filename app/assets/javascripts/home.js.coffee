# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@funModule.controller('HomeController', ['$scope', '$http', '$sce', ($scope, $http, $sce) ->
	idsToSearchResults = {}
	$scope.search_results = []
	$scope.query = ""

	$scope.search = ->
		queryUrl = "https://www.googleapis.com/youtube/v3/search?maxResults=50&part=snippet&order=viewcount&type=video%20&videoEmbeddable=true&key=AIzaSyCUZV_CNWfiW_Zb6aBQyX_xvffZVj_OcH0&q=" + $scope.query

		$http.get(queryUrl).success (data) ->
			$scope.search_results = []
			for item in data.items
				newItem = {
					id: item.id.videoId,
					title: item.snippet.title,
					preview_html: ""
				}

				$scope.search_results.push(newItem)
				idsToSearchResults[newItem.id] = newItem

	$scope.preview_video = (id) ->
		currentPreviewHtml = idsToSearchResults[id].preview_html
		if(currentPreviewHtml != "")
			idsToSearchResults[id].preview_html = ""
			return

		playerHtml = $sce.trustAsHtml "<iframe id=\"ytplayer\" type=\"text/html\" width=\"640\" height=\"390\" src=\"http://www.youtube.com/embed/" + id + "\" frameborder=\"0\"/>"
		idsToSearchResults[id].preview_html = playerHtml

])