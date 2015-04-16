# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('.league-table tr').mouseover ->
		$(@).css(
				'background-color': 'rgba(231,42,8,1)'
				'color': 'white'

			)
		.mouseout ->
			$(@).css(
				'background-color': 'white'
				'color': '#333333'

			)


