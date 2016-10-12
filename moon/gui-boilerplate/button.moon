class Button
  new: (@x, @y, @w, @h, @text='', @tooltip='', @filled=false) =>
    if @filled == false
      @filled = 0
    elseif @filled == true
      @filled = 1

  init: =>
    gfx.rect(@x, @y, @w, @h, @filled)
