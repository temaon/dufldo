#=require lib/jquery.flexslider-min

$(document).on 'ready pjax:success turbolinks:load', ->
  hash = window.location.hash;
  hash && $('ul.nav a[href="' + hash + '"]').tab('show');
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