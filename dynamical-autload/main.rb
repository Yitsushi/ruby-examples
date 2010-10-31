load 'lib/string.rb'

Dir['./modules/*.rb'].each do |file|
  target = file.gsub(/.*\//, "").sub(/\.rb/, "")
  autoload(target.camelize.to_sym, file)
end

class Init
  def load
    begin
      MyFirstClass.new
      MySecondClass.new
    rescue
      puts "Load error. Module not found."
    end
  end
end

Init.new.load
