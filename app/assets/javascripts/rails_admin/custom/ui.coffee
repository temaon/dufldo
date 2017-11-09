#= require ckeditor/init

$(document).on 'ready pjax:success', ->

  handleActiveBase = ->
    $('.sub-menu').each ->
      if $(this).hasClass('active')
        $(this).parent().prev().addClass 'active'
        $(this).parent().prev().addClass 'open'
        $(this).parent().slideDown()
      return
    return

  handleActiveBase()
  return

$ ->
  width = $('.nav-stacked').width()

  handleActiveBase = ->
    $('.sub-menu').each ->
      if $(this).hasClass('active')
        $(this).parent().prev().addClass 'active'
        $(this).parent().slideDown()
      return
    return

  $('.navbar-header').width width
  array_menu = []
  lvl_1 = null
  count = 0
  $('.sidebar-nav li').each (index, item) ->
    if $(item).hasClass('dropdown-header')
      lvl_1 = count++
      array_menu[lvl_1] = []
    else
      $(item).addClass 'sub-menu sub-menu-' + lvl_1
    return
  i = 0
  while i <= array_menu.length
    $('.sub-menu-' + i).wrapAll '<div class=\'sub-menu-container\' />'
    i++
  $('.sub-menu-container').hide()
  handleActiveBase()
  $('.dropdown-header').bind 'click', ->
    $('.dropdown-header').removeClass 'open'
    $(this).addClass 'open'
    $('.dropdown-header').removeClass 'active'
    $('.sub-menu-container').stop().slideUp()
    $(this).toggleClass 'active'
    $(this).next('.sub-menu-container').stop().slideDown()
    return
  return
