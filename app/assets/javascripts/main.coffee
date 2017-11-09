document.addEventListener "turbolinks:load", () ->
  $('a.facebook').on 'click', (e) ->
    window.open $(@).attr('href'), 'Facebook', 'width=600,height=300,left=' + screen.availWidth / 2 - 300 + ',top=' + screen.availHeight / 2 - 150 + ''
    e.preventDefault()
  $('a.twitter').on 'click', (e) ->
    window.open $(@).attr('href'), 'Twitter share', 'width=600,height=300,left=' + screen.availWidth / 2 - 300 + ',top=' + screen.availHeight / 2 - 150 + ''
    e.preventDefault()
  $('a.g-puls').on 'click', (e) ->
    window.open $(@).attr('href'), 'Google plus', 'width=585,height=666,left=' + screen.availWidth / 2 - 292 + ',top=' + screen.availHeight / 2 - 333 + ''
    e.preventDefault()

  $('a.link-video').click (e) ->
    e.preventDefault()
    $('body').find('iframe.video-active').removeClass 'video-active'
    $('body').find('div.frame').removeClass 'frame-active'
    $(this).siblings('iframe').addClass 'video-active'
    $(this).siblings('div.frame').addClass 'frame-active'
    return

  $('[data-toggle="tooltip"]').tooltip()

window.addEventListener 'scroll', (e) ->
  distanceY = window.pageYOffset || document.documentElement.scrollTop
  shrinkOn = 100
  header = document.querySelector('#header-container')
  if distanceY > shrinkOn
    $('#header-holder').addClass 'header_fixed'
  else
    $('#header-holder').removeClass 'header_fixed'
  return



#  offset = $('#header-container').offset().top
#
#  $(window).scroll ->
#    if $(window).scrollTop() >= $('#header-container').height() + 10
#      $('#header-holder').addClass 'header_fixed'
#    else
#      $('#header-holder').removeClass 'header_fixed'
