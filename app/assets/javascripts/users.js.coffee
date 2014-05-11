# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  return_to_top = $('#return-to-top')
  return_to_top.hide()

  $(window).scroll( ->
    if ($(this).scrollTop() > 100)
      return_to_top.fadeIn()
    else
      return_to_top.fadeOut()
  )

  return_to_top.click( (e) ->
    e.preventDefault()
    $('body, html').animate(
      scrollTop: 0,
      400
    )
  )

