#= require lib/datepicker.js

$(document).on 'ready pjax:success turbolinks:load', ->
  monthNames = ["", "Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
    "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"
  ]

  $('#filter_date').datepicker
    onRenderCell: (date, cellType) ->
      currentMonth = date.getMonth() + 1
      currentYear = date.getFullYear()
      currentDate = date.getDate()
      if cellType == 'year'
        return {
          html: '<a class="date_link" data-turbolinks="false" data-remote="true" href="?year=' + currentYear + ' ">' + currentYear + '</a>'
        }
      if cellType == 'month'
        return {
          html: '<a class="date_link" data-turbolinks="false" data-remote="true" href="?year=' + currentYear + '&month=' + currentMonth + '">' + monthNames[currentMonth] + '</a>'
        }
      if cellType == 'day'
        return {
          html: '<a class="date_link" data-turbolinks="false" data-remote="true" href="?year=' + currentYear + '&month=' + currentMonth + '&day=' + currentDate + ' ">' + currentDate + '</a>'
        }
      return
    onSelect: (fd, date, c) ->
      title = ''
      content = ''
      $('.date_link').on 'click', () ->
        $(@).preventDefault()
      return false
