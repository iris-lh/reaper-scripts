require 'yaml'

REAPER_HOME = "/Users/#{ENV['USER']}/Library/Application Support/REAPER/Scripts"
PWD = ENV['PWD']
LUA_DIR = "#{PWD}/lua"
MOON_DIR = "#{PWD}/moon"



desc 'Deploy lua files to Reaper scripts folder'
task :deploy => :compile do
  `cp -r #{LUA_DIR}/ '#{REAPER_HOME}'`
end



desc 'Compile stacked moons into luas'
task :compile do # => :stack do
  Dir["#{MOON_DIR}/*"].map do |script_dir|
    `moonc -o #{LUA_DIR}/#{tokenize script_dir}.lua #{script_dir}/stacked.moon`
  end
end



desc 'Stack moons on top of each other'
task :stack => :cleanup do
  Dir["#{MOON_DIR}/*"].map do |moon_file|
    script_name = tokenize moon_file
    script_dir = "#{MOON_DIR}/#{script_name}"
    stack = convert_yaml "#{script_dir}/stackfile.yml"
    target_file = File.open("#{script_dir}/stacked.moon", "w")

    stack['local'].each do |file|
      File.open("#{script_dir}/#{file}.moon", "rb") do |f|
        contents = f.read
        target_file.write contents
      end
    end

    target_file.close
  end
end



desc 'Clean up unneeded lua files'
task :cleanup => :make_tokens do
  @lua_tokens.each do |lua_token|
    reaper_file = "#{REAPER_HOME}/#{lua_token}.lua"
    unless @moon_tokens.include? lua_token
      File.delete "#{LUA_DIR}/#{lua_token}.lua"
      puts "Removed #{LUA_DIR}/#{lua_token}.lua"
      if File.exists? reaper_file
        File.delete reaper_file
        puts "Removed #{reaper_file}"
      end
    end
  end
end



desc 'Wipe all lua files from the repository'
task :wipe_lua do
  Dir.glob("#{PWD}/**/*.lua").each do |file|
    File.delete file
  end
end



task :make_tokens do
  @moon_tokens = Dir["#{MOON_DIR}/*"].map do |moon_file|
    tokenize moon_file
  end
  @lua_tokens = Dir["#{LUA_DIR}/*.lua"].map do |lua_file|
    tokenize lua_file
  end
end



def tokenize(file)
  file.gsub(/^.*\//, '').gsub(/\..*$/, '')
end

def convert_yaml(path)
  file = File.open("#{path}", "rb")
  contents = file.read
  YAML.load(contents)
end
