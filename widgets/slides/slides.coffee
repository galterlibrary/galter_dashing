class Dashing.Slides extends Dashing.Widget

  ready: ->
    @current_index = 0
    @slide_container = $(@node).find('#slide_image')
    @next_slide()
    @start_carousel()

  onData: (data) ->
    @current_index = 0

  start_carousel: ->
    interval = $(@node).attr('data-interval')
    interval = '30' if not interval
    setInterval(@next_slide, parseInt( interval ) * 1000)

  next_slide: =>
    slides = @get('image_list')
    if slides
      @slide_container.fadeOut =>
        @current_index = (@current_index + 1) % slides.length
        @set 'image', slides[@current_index]
        @slide_container.fadeIn()
    else
      @set 'image', '/assets/content/welcome_mat.jpg'
