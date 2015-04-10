require_relative "player"

module StudioGame
  class BerserkPlayer < Player
  
    attr_reader :number_of_w00ts
  
    def initialize(name, health)
      super(name, health)
      @number_of_w00ts = 0
    end
  
    def berserk?
      @number_of_w00ts > 5
    end
  
    def w00t
      super
      @number_of_w00ts += 1
      puts "#{name.capitalize} is Berserk" if berserk?
    end
  
    def blam
      berserk? ? w00t : super
    end
  
  end

  if __FILE__ == $0
    berserker = BerserkPlayer.new("berserker", 50)
    6.times { berserker.w00t }
    2.times { berserker.blam }
  end
end