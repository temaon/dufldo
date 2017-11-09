#=require lib/jquery.flexslider-min
$(window).on 'load', ->
  'use strict'
  $('#flexCarousel').flexslider
    animation: 'slide'
    controlNav: false
    animationLoop: false
    slideshow: true
    itemWidth: 70
    asNavFor: '#postSlider'
  $('#postSlider').flexslider
    animation: 'slide'
    controlNav: false
    animationLoop: false
    slideshow: true
    sync: '#flexCarousel'
  return
