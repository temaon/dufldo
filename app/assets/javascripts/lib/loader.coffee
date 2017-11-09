class @Loader
  constructor: (config) ->
    @build_loader()
    document.addEventListener('turbolinks:click', () -> window.__loader = new Loader())
    document.addEventListener('turbolinks:load', () ->
      setTimeout((() ->window.__loader.destroy_loader()), 1000)
    )

  build_loader: () =>
    div_wrapper = document.createElement('div');
    div_wrapper.setAttribute("id", "loader-wrapper");
    div_loader = document.createElement('div')
    div_loader.setAttribute("id", "loader");
    div_sf = document.createElement('div')
    div_ss = document.createElement('div')
    div_sf.className = 'loader-section section-right'
    div_ss.className = 'loader-section section-left'
    div_loader.appendChild(div_ss)
    div_loader.appendChild(div_sf)
    div_wrapper.appendChild(div_loader)
    div_wrapper.appendChild(div_loader)
    document.body.appendChild(div_wrapper);
#    $('body').append(
#      $('<div></div>', id: 'loader-wrapper')
#        .append($('<div></div>', id: 'loader'))
#        .append($('<div></div>', class: 'loader-section section-left'))
#        .append($('<div></div>', class: 'loader-section section-right')
#      )
#    )

  get_loader_wrapper: () ->
    $('#loader-wrapper')

  destroy_loader: () ->
    element = document.getElementById("loader-wrapper");
    element.outerHTML = "" if element

#$(document).on 'ready', () ->
#  console.log 'first'
#
#$(document).on('turbolinks:load', ()->
#  setTimeout( (() ->
#    window.__loader.destroy_loader())
#    , 1000)
#)

#$(document).on('DOMContentLoaded turbolinks:before-visit', ()->
#  window.__loader = new Loader()
#)



#document.addEventListener('turbolinks:visit', ()->
#  console.log('tut'))
#document.addEventListener('turbolinks:render', ()->
#  console.log('tut1'))
#document.addEventListener('turbolinks:request-start', ()->
#  console.log('tut2'))
#document.addEventListener('turbolinks:request-end', ()->
#  console.log('tut3'))
#document.addEventListener('turbolinks:before-visit', ()->
#  console.log('tut4'))
#document.addEventListener('turbolinks:before-render', ()->
#  console.log('tut5'))
#document.addEventListener('turbolinks:before-click', ()->
#  console.log('tut6'))
#document.addEventListener('turbolinks:before-cache', ()->
#  console.log('tut7'))



