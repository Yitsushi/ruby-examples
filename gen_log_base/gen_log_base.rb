def gen_log_base(base)
  return Proc.new { |num| Math.log(num, base) }
end

def gen_logs(num, *logs)
  logs.each do |log|
    puts log.call num
  end
end

log2 = gen_log_base(2)
log10 = gen_log_base(10)

puts "Use:"
puts log2.call(4)
puts log2.call(19)
puts "\nMultiple use:"
puts log10.call(100)
puts log10.call(145)

puts "\nUse as parameter:"
gen_logs 134, log2, log10

=begin
Output:
  Use:
  2.0
  4.247927513443585

  Multiple use:
  2.0
  2.1613680022349744

  Use as parameter:
  7.066089190457772
  2.1271047983648073
=end
