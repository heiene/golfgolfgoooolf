# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#users').dataTable({
    "sDom": "<'row'<'span7'l><'span7'f>r>t<'row'<'span7'i><'span7'p>>",
    "sPaginationType": "bootstrap"
  });


