class Class
  public
  def attr_validated(attribute, error_msg = nil, &validation)
    define_method "#{attribute}=" do |value|
      raise (error_msg || 'Invalid attribute') unless validation.call value
      instance_variable_set "@#{attribute}", value
    end

    define_method "#{attribute}" do
      instance_variable_get "@#{attribute}"
    end
  end
end

class TestClass
  attr_validated :name, "Invalid name! (Please enter your valid REAL name...)" do |n|
    (not n.nil? and
     n.class == String and
     n.length > 3 and
     n.include? " "
    )
  end
  attr_validated :age do |n|
    n >= 18
  end
end

t = TestClass.new
t.name = 'Balazs Nadasdi'
t.age  = 23
puts t.name
puts t.age

begin
  t.name = 'yitsushi'
rescue Exception => e
  puts e.message
end

begin
  t.age = 12
rescue Exception => e
  puts e.message
end

=begin
Output:

  Balazs Nadasdi
  23
  Invalid name! (Please enter your valid REAL name...)
  Invalid attribute
=end
