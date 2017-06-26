# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.letter').each ->
    col = $(this).attr('color')
    if col == undefined then col = 'c7c7c7'
    col = '#'+col
    $(this).css("backgroundColor", col)
