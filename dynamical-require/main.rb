require 'lib/string'
require 'lib/choose'

class Init
  def load
    target = Choose.new.what_can_i_load
    begin
      require "modules/#{target}"
    rescue
      puts "Import error. Module not found."
      exit
    end

    begin
      module_object = target.camelize.constantize.new
    rescue
      puts "Load error. Module not found."
    end
  end
end

Init.new.load
