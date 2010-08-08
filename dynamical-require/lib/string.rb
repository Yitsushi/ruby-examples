class String
  def camelize(first_letter_in_uppercase = :upper)
    s = gsub(/\/(.?)/){|x| "::#{x[-1..-1].upcase unless x == '/'}"}.gsub(/(^|_)(.)/){|x| x[-1..-1].upcase}
    s[0...1] = s[0...1].downcase unless first_letter_in_uppercase == :upper
    s
  end

  def constantize
    raise(NameError, "#{inspect} is not a valid constant name!") unless m = /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/.match(self)
    Object.module_eval("::#{m[1]}", __FILE__, __LINE__)
  end
end
