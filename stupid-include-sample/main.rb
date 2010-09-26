require 'rubygems'
require 'time'
require 'person_module'

class Man
  include Person
  def initialize(birthday)
    @birthday = Time.parse(birthday)
  end
end

# Then the Man class have a function: age
you = Man.new('1987-11-16')
puts you.age

########## Othe example
puts " --- Other"
require 'functions'

# call operations
begin
  puts operation_a( 10 ); rescue Exception => e; puts "ERROR: #{e.message}"
end

begin
  puts operation_b( 4 ); rescue Exception => e; puts "ERROR: #{e.message}"
end


# But if i include the module
include Functions
begin
  puts operation_a( 10 ); rescue Exception => e; puts "ERROR: #{e.message}"
end

begin
  puts operation_b( 4 ); rescue Exception => e; puts "ERROR: #{e.message}"
end
