
module StudioGame
  module Playable
  
    def w00t
      self.health += 15
      puts "#{self.name} got w00ted!"
    end
  
    def blam
      self.health -= 10
      puts "#{self.name} got blammed!"
    end
  
    def strong?
      self.health > 100
    end

  end
end