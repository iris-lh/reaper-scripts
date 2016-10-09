local foo = {
  asdf = function()
    return print("foo's asdf")
  end
}
local bar = {
  asdf = function()
    return print("bar's asdf")
  end
}
local main = {
  init = function()
    return print(foo.asdf(), bar.asdf())
  end
}
return main.init()
