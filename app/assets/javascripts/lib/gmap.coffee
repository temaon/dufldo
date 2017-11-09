#= require lib/scripts_loader
#=require underscore

class GoogleMap
  # исходные настройки
  zoom =
    initialView: 17
    closeView: 18
  markers = []
  map = undefined

  constructor: (home) ->
  # определяем центр карты и параметры отображения
    lat = home.lat
    lon = home.lng
    myLatlng = new google.maps.LatLng(lat, lon)
    mapOptions =
      zoom: zoom.initialView
      center: myLatlng

    # создаём карту
    map = new google.maps.Map(document.getElementById("map"), mapOptions)

  addMarker: (location, title) ->
  # создаём маркер и добавляем в массив маркеров
    marker = new google.maps.Marker(
      position: location,
      title: title,
      map: map
    )
    markers.push marker

    # добавляем обработчик события
    google.maps.event.addListener marker, "click", ->
      map.setZoom zoom.closeView
      map.setCenter marker.getPosition()

  addMarkers: (markerList) ->
  # добавляем все маркеры
    _.each markerList, (marker) =>
      position = new google.maps.LatLng marker["lat"], marker["lon"]
      title = "#{marker['full_address']}"
      @addMarker position, title

  drawMarkers: (map) ->
  # отрисовываем маркеры
    _.each markers, (marker) ->
      marker.setMap map
  # ВАЖНО: вызов метода setMap на маркере отрисовывает маркер, вызов с параметром null – стирает

  showMarkers: ->
    @setAllMap map

  hideMarkers: ->
    @setAllMap null

  removeListeners: ->
    _.each markers, (marker) ->
      google.maps.event.clearInstanceListeners(marker)

  deleteMarkers: ->
    @hideMarkers()
    @removeListeners()
    markers = []

#app.google or= { classes: {} }
#app.google.classes.GoogleMap = GoogleMap

$ ->
  if (window._loader = if (window._loader == undefined || window._loader) then new ScriptsLoader() else false)
    window._loader.script_loader(["//maps.googleapis.com/maps/api/js"]).then(() =>
      googleMap = new GoogleMap({lat: '48.461868', lng: '35.059682'})
      googleMap.addMarkers [{full_address: 'ул. Дзержинского, 23, Днепропетровск', lat: '48.461868', lon: '35.059682'}]
    )

