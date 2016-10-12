-- Modified from the original version written by spk77 from the Cockos forum
-- http://forum.cockos.com/showthread.php?t=173938



ttOffsetX = 15  -- tooltip x offset from mouse cursor
ttOffsetY = 15  -- tooltip y offset from mouse cursor

gui = {}

init = ->

  -- Add stuff to gui table --
  gui.settings = {}
  gui.settings.font_size = 20
  gui.settings.docker_id = 0    -- try 0, 1, 257, 513, 1027 etc.

  -- Initialize gfx window --
  gfx.init('', 300, 250, gui.settings.docker_id)
  gfx.setfont(1,'Arial', gui.settings.font_size)
  gfx.clear = 3355443



mainloop = ->
  gfx.x = 10
  gfx.y = 10
  mouseX, mouseY = gfx.mouse_x, gfx.mouse_y
  mouseScreenX, mouseScreenY = gfx.clienttoscreen(mouseX,mouseY)

  dock_state, windowX, windowY, windowW, windowH = gfx.dock(-1,0,0,0,0)

  position_info = '\n' .. 'Mouse X - screen: '     .. tostring(mouseScreenX) ..
                  '\n' .. 'Mouse Y - screen: '     .. tostring(mouseScreenY) ..
                  '\n' .. 'Mouse X - gfx window: ' .. tostring(mouseX)       ..
                  '\n' .. 'Mouse Y - gfx window:'  .. tostring(mouseY)       ..
                  '\n' .. 'Window X: '             .. tostring(windowX)      ..
                  '\n' .. 'Window Y: '             .. tostring(windowY)

  rect1 = {
    x: 10
    y: 10
    w: 20
    h: 20
  }
  gfx.rect(rect1.x, rect1.y, rect1.w, rect1.h, 0)

  rect2 = {
    x: 100
    y: 10
    w: 40
    h: 20
  }
  gfx.rect(rect2.x, rect2.y, rect2.w, rect2.h, 0)

  if  mouseX > rect1.x         and
      mouseX < rect1.x+rect1.w and
      mouseY > rect1.y         and
      mouseY < rect1.y+rect1.h
    reaper.TrackCtl_SetToolTip('mouse on rectangle 1', mouseScreenX + ttOffsetX, mouseScreenY + ttOffsetY, true)

  elseif  mouseX > rect2.x     and
      mouseX < rect2.x+rect2.w and
      mouseY > rect2.y         and
      mouseY < rect2.y+rect2.h
    reaper.TrackCtl_SetToolTip('mouse on rectangle 2', mouseScreenX + ttOffsetX, mouseScreenY + ttOffsetY, true)

  else -- clear tool tip
    reaper.TrackCtl_SetToolTip('', mouseScreenX, mouseScreenY, true)



  -- Draw position info --
  gfx.y = 25
  gfx.drawstr(position_info)
  gfx.update!
  if gfx.getchar! >= 0
    reaper.defer(mainloop)



init!
mainloop!
