class Array
  def randomize
    self.sort {rand(self.length / 3)-1}
  end
end

n=5
a = (1..95).to_a

puts "Lottery numbers: (^_^)"
p a.randomize[0..(n-1)]
p a.randomize[0..(n-1)]
p a.randomize[0..(n-1)]
p a.randomize[0..(n-1)]
p a.randomize[0..(n-1)]
p a.randomize[0..(n-1)]
p a.randomize[0..(n-1)]


# Output:
# #
# # Lottery numbers: (^_^)
# # [20, 27, 4, 95, 46]
# # [26, 20, 95, 39, 65]
# # [27, 54, 53, 3, 95]
# # [13, 59, 95, 7, 88]
# # [85, 19, 75, 95, 16]
# # [83, 28, 65, 95, 49]
# # [60, 84, 16, 5, 95]
