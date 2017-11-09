#= require '../lib/jquery.countdown.min'
#= require '../lib/owl.carousel.min'

document.addEventListener "ready turbolinks:load", () ->
  $('a.link-video').click (e) ->
    e.preventDefault()
    $(@).siblings('iframe').addClass 'video-active'
    $(@).siblings('div.frame').addClass 'frame-active'
    return
