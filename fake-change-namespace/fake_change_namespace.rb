class Queue
  @@list = []
  def self.add(entry)
    @@list << entry
  end 

  def self.list
    @@list
  end 
end


module Online
  def self.send_queue
    puts "  send queue [#{::Queue.list.length}]" unless ::Queue.list.empty?
    ::Queue.list.each do |msg|
      puts "  #{msg[:to]} => #{msg[:subject]}"
    end 
  end 

  def self.send_message(to, subject, msg)
    puts "Send message via Email"
    self.send_queue
    puts "#{to} => #{subject}"
  end 
end

module Offline
  def self.send_queue
  end 

  def self.send_message(to, subject, msg)
    puts "Store message into queue"
    ::Queue.add({:to => to, :subject => subject, :msg => msg})
  end 
end

$status = Online
$status.send_message('target@email.addr', 'Message I.', 'body')

$status = Offline
$status.send_message('target@email.addr', 'Message II.', 'body')
$status.send_message('target@email.addr', 'Message III.', 'body')
$status.send_message('target@email.addr', 'Message IV.', 'body')
$status.send_message('target@email.addr', 'Message V.', 'body')

$status = Online
$status.send_message('target@email.addr', 'Message VI.', 'body')

=begin
# Output:
Send message via Email
  target@email.addr => Message I.
Store message into queue
Store message into queue
Store message into queue
Store message into queue
Send message via Email
  send queue [4]
    target@email.addr => Message II.
    target@email.addr => Message III.
    target@email.addr => Message IV.
    target@email.addr => Message V.
  target@email.addr => Message VI.
=end
