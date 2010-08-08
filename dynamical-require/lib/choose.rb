class Choose
  def what_can_i_load
    return "my_first_class" unless rand.round.zero?
    "my_second_class"
  end
end
