require 'rubygems'
require 'yaml'

module MyApp
  class Config
    @@config = []
    @@filename = ''

    def self.load(f)
      @@config = YAML.load_file f
      @@filename = f
    end

    def self.[](name)
      @@config[name]
    end

    def self.[]=(name, value)
      @@config[name] = value
    end

    def self.save
      File.open(@@filename, 'w') { |out| YAML.dump(@@config, out) }
    end

    def self.reload
      self.load @@filename
    end
  end
end

def print_datas
  print "#{MyApp::Config['name']}"
  print " #{MyApp::Config['version']}"
  puts  " by #{MyApp::Config['author']}"
  print "#{MyApp::Config['window']['width']}x#{MyApp::Config['window']['height']}"
  puts  "#{MyApp::Config['window']['x']}#{MyApp::Config['window']['y']}"
end

puts "==> Load config"
MyApp::Config.load "app.yaml"
print_datas

puts "==> Change some data"
MyApp::Config['window']['width'] = 250 + (rand*100).round - 50
MyApp::Config['window']['height'] = 200 + (rand*100).round - 50
print_datas

puts "==> Reload config without save"
MyApp::Config.reload
print_datas

puts "==> Change some data and save"
MyApp::Config['window']['width'] = 540 + (rand*100).round - 50
MyApp::Config['window']['height'] = 365 + (rand*100).round - 50
MyApp::Config.save
print_datas

puts "==> Reload config"
MyApp::Config.reload
print_datas
