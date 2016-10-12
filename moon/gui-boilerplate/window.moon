class Window
  new: (@x, @y, @w, @h, @title='', @dockstate=0) =>
  buttons: {}
  init: =>
    gfx.init(@title, @w, @h, @dockstate, @x, @y)
    gfx.clear = 0

    for btn in @buttons
      btn.init!

  write: (x, y, text, font='Arial', fontSize=20) =>
    gfx.x = x
    gfx.y = y
    gfx.setfont(1, font, fontSize)
    gfx.drawstr(text)
