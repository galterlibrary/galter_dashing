class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    h = today.getHours()
    m = today.getMinutes()
    m = @formatTime(m)

    dd = " AM"

    if h >= 12
      dd = " PM"

    if h > 12
      h = h - 12

    @set('time', h + ":" + m + dd)
    @set('date', today.toDateString())

  formatTime: (i) ->
    if i < 10 then "0" + i else i
