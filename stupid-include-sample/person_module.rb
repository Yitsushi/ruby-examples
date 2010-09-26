module Person
  @birthday = Time.now
  def age
    Time.now.year - @birthday.year
  end
end
