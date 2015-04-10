require_relative "die"

module StudioGame
  module GameTurn
  	def self.take_turn(player, die, treasure)
  	  val = die.roll
      if val <= 2
        player.blam
      elsif val > 4
        player.w00t
      end
      player.found_treasure(treasure)
  	end
  end
end
