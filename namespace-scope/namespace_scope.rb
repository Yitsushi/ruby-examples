class AppleTree
  def initialize
    puts "OMG! /root"
  end
end

module NS
  class AppleTree
    def initialize
      puts "ROFL /root/NS"
    end
  end

  class CallAppleTree
    def initialize
      AppleTree.new
    end
  end
  
  class CallRootAppleTree
    def initialize
      ::AppleTree.new
    end
  end
end

AppleTree.new
NS::AppleTree.new
NS::CallAppleTree.new
NS::CallRootAppleTree.new

=begin
Output:
=======

OMG! /root
ROFL /root/NS
ROFL /root/NS
OMG! /root

=end
