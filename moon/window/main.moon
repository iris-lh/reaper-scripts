-- Modified from the original version written by spk77 from the Cockos forum
-- http://forum.cockos.com/showthread.php?t=173938



tt_x_offset = 20  -- tooltip x offset from mouse cursor
tt_y_offset = 20  -- tooltip y offset from mouse cursor
titlebar_h = 31   -- gfx window titlebar height
border_w = 8      -- gfx window border width



----------
-- Init --
----------

-- GUI table ----------------------------------------------------------------------------------
--   contains GUI related settings (some basic user definable settings), initial values etc. --
-----------------------------------------------------------------------------------------------

gui = {}

init = ->

  -- Add stuff to '`gui`' table
  gui.settings = {}                 -- Add 'settings' table to 'gui' table
  gui.settings.font_size = 20       -- font size
  gui.settings.docker_id = 0        -- try 0, 1, 257, 513, 1027 etc.

  ---------------------------
  -- Initialize gfx window --
  ---------------------------

  gfx.init('', 300, 220, gui.settings.docker_id)
  gfx.setfont(1,'Arial', gui.settings.font_size)
  gfx.clear = 3355443  -- matches with 'FUSION: Pro&Clean Theme :: BETA 01' http://forum.cockos.com/showthread.php?t=155329
    -- (Double click in ReaScript IDE to open the link)



--------------
-- Mainloop --
--------------

mainloop = ->
  gfx.x = 10
  gfx.y = 10
  mouseX, mouseY = gfx.mouse_x, gfx.mouse_y   -- current mouse coordinates are stored to 'mouseX' and 'mouseY'

  dock_state, windowX, windowY, windowWidth, windowHeight = gfx.dock(-1,0,0,0,0)


  position_info = 'Mouse X - screen ' .. tostring(mouseX+windowX+8) ..
                        '\n' ..'Mouse Y - screen: ' .. tostring(mouseY+windowY+31) ..
                        '\n' ..'Mouse X - gfx window: ' .. tostring(mouseX) ..
                        '\n' ..'Mouse Y - gfx window:' .. tostring(mouseY) ..
                        '\n' .. 'Window X: ' .. tostring(windowX) ..
                        '\n' .. 'Window Y: ' .. tostring(windowY)


  -- rect 1
  gfx.rect(10,10,20,20,0)
  if mouseX > 10 and mouseX < 10+20 and mouseY > 10 and mouseY < 10+20 then -- is mouse on rect 1?
    reaper.TrackCtl_SetToolTip('mouse on rectangle 1', mouseX+windowX+tt_x_offset+border_w, mouseY+windowY+tt_x_offset+titlebar_h, true)
  else -- clear tool tip
    reaper.TrackCtl_SetToolTip('', mouseX+windowX+tt_x_offset+border_w, mouseY+windowY+tt_y_offset+titlebar_h, true)


  -- rect 2
  gfx.rect(100,10,20,20,0)
  if mouseX > 100 and mouseX < 100+20 and mouseY > 10 and mouseY < 10+20 then -- is mouse on rect 2?
    reaper.TrackCtl_SetToolTip('mouse on rectangle 2', mouseX+windowX+tt_x_offset+border_w, mouseY+windowY+tt_x_offset+titlebar_h, true)
  else -- clear tool tip
    reaper.TrackCtl_SetToolTip('', mouseX+windowX+tt_x_offset+border_w, mouseY+windowY+tt_y_offset+titlebar_h, true)


  -- Draw 'position info'
  gfx.y = gfx.y+50
  gfx.drawstr(position_info)
  gfx.update!
  if gfx.getchar! >= 0 then reaper.defer(mainloop)



init!
mainloop!
