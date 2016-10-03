REAPER_HOME = "/Users/isu/Library/Application Support/REAPER/Scripts"
LUA_DIR = './lua'
MOON_DIR = './moon'


desc 'Deploy lua files to Reaper scripts folder'
task :deploy => :build do
  `cp -r #{LUA_DIR}/ '#{REAPER_HOME}'`
end


desc 'Build moons into luas'
task :build => :cleanup do
  `moonc -t #{LUA_DIR}/ #{MOON_DIR}/.`
end


desc 'Clean up unneeded lua files'
task :cleanup => [:make_moon_tokens, :make_lua_files] do
  @luas.each do |lua_file|
    file_token = tokenize lua_file
    reaper_file = "#{REAPER_HOME}/#{file_token}.lua"
    unless @moon_tokens.include? file_token
      File.delete lua_file
      puts "Removed #{lua_file}"
      if File.exists? reaper_file
        File.delete reaper_file
        puts "Removed #{reaper_file}"
      end
    end
  end
end


task :make_moon_tokens do
  @moon_tokens = Dir["#{MOON_DIR}/*.moon"].map do |moon_file|
    tokenize moon_file
  end
end


task :make_lua_files do
  @luas = Dir["#{LUA_DIR}/*.lua"]
end


def tokenize(file)
  file.gsub(/^.*\//, '').gsub(/\..*$/, '')
end
