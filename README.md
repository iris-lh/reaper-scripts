# reaper-scripts
Some scripts written in MoonScript for the Reaper DAW. (with some Ruby and Bash for housekeeping) :)

To set up Rake and deploy scripts to Reaper:

1. `bundle install`
2. `bundle exec rake deploy`

You can also use Guard to watch your MoonScript files.

`bundle exec guard`

It will deploy when it detects changes to moon files.
