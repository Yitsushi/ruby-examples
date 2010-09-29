class ValidationError
  attr_reader :field, :message
  def initialize(argv)
    @field   = argv[:field]
    @message = argv[:message]
  end
  
  def to_s
    "#{self.class}: [#{@field}] #{@message}"
  end
end

class Class
  def attr_validated(attribute, error_msg = nil, &validation)
    attr_accessor :errors

    unless method_defined? "_add_error"
      define_method "_add_error" do |field, message|
        instance_variable_get("@errors")[field] = ValidationError.new({
          :field => field, :message => message
        })
      end
    end
    unless method_defined? "_remove_error"
      define_method "_remove_error" do |field|
        instance_variable_get("@errors").delete(field)
      end
    end
    unless method_defined? "has_error?"
      define_method "has_error?" do
        instance_variable_get("@errors").length > 0 rescue false
      end
    end

    define_method "#{attribute}=" do |value|
      unless instance_variable_defined? "@errors"
        instance_variable_set "@errors", {}
      end
      unless validation.call value
        _add_error attribute, (error_msg || 'Invalid attribute')
        return nil
      end
      _remove_error attribute
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
puts " --- Phase 1"
t.name = 'Balazs Nadasdi'
t.age  = 23

if t.has_error?
  puts " +--- ERROR --- -- -"
  t.errors.each do |e|
    puts " | #{e.message}"
  end
  puts " +------------- -- -"
else
  puts t.name
  puts t.age
end

puts " --- Phase 2"
t.name = 'yitsushi'
t.age = 12

if t.has_error?
  puts " +--- ERROR --- -- -"
  t.errors.each do |field, e|
    puts " | #{e}"
    puts " |   >>> #{e.message}"
  end
  puts " +------------- -- -"
else
  puts t.name
  puts t.age
end

=begin
Output:

 --- Phase 1
 Balazs Nadasdi
 23
 --- Phase 2
 +--- ERROR --- -- -
 | ValidationError: [name] Invalid name! (Please enter your valid REAL name...)
 |   >>> Invalid name! (Please enter your valid REAL name...)
 | ValidationError: [age] Invalid attribute
 |   >>> Invalid attribute
 +------------- -- -
=end
