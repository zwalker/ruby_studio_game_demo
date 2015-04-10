module StudioGame
  module Auditable
  
    def audit
      puts "Rolled a #{self.number} (#{self.class.to_s})"
    end
  
  end
end