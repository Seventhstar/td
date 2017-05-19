# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@doChosen = ->
	$('.schosen').chosen(width: '99.5%').on 'change', ->
		sortable_query()

$(document).ready ->
	doChosen()
	
$( document ).ajaxStop ->
	doChosen()