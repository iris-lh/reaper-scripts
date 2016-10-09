foo = {
  asdf: ->
    print "foo's asdf"
}
bar = {
  asdf: ->
    print "bar's asdf"
}
main = {
  init: ->
    print(foo.asdf!, bar.asdf!)
}

main.init!
