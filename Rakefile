require 'open3'
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
task :compile => :cleanup do
  Dir["#{MOON_DIR}/*"].map do |script_dir|
    build = convert_yaml "#{script_dir}/build.yml"

    compiled_lua = build['local'].map do |file_token|
      compile_moon "#{script_dir}/#{file_token}.moon"
    end.join("\n\n------\n\n\n")

    File.open("#{LUA_DIR}/#{tokenize script_dir}.lua", 'w') do |fh|
      fh.write compiled_lua

    end
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



def compile_moon(moon_file)
  stdout, stderr, status = Open3.capture3("cat #{moon_file} | moonc --")
  raise "#{status} - #{stderr}" if stderr != ''
  stdout
end

def tokenize(file)
  file.gsub(/^.*\//, '').gsub(/\..*$/, '')
end

def convert_yaml(path)
  file = File.open("#{path}", "rb")
  contents = file.read
  YAML.load(contents)
end
