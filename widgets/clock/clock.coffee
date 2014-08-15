class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    h = today.getHours()
    m = today.getMinutes()
    s = today.getSeconds()
    m = @formatTime(m)
    s = @formatTime(s)

    dd = " AM"

    if h >= 12
      dd = " PM"

    if h > 12
      h = h - 12

    @set('time', h + ":" + m + ":" + s + dd)
    @set('date', today.toDateString())
    @set('closing', @closingTime(today))

  formatTime: (i) ->
    if i < 10 then "0" + i else i

  closingTime: (date) ->
    day = date.getDay()
    closing_string = "The library closes tonight at "

    if day in [1, 2, 3, 4]
      closing_string + "11pm"
    else if day in [5, 7]
      closing_string + "9pm"
    else if day == 6
      closing_string + "6pm"
