log = (message='[no message]') ->
  reaper.ShowConsoleMsg message..'\n'

log "Hello World, you have a whole #{reaper.CountTracks(0)} tracks!"

i = 0
file_name = ''

file = (i) ->
  file_name = reaper.EnumerateFiles('/SOUNDS/STEMS+RAWS/', i)

log file(0)
