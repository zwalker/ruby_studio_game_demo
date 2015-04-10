require 'studio_game/game'
require 'studio_game/player'
require 'studio_game/die'

module StudioGame
  describe Game do

    before do
      @game = Game.new("Knuckleheads")

      @initial_health = 100
      @player = Player.new("moe", @initial_health)
    
      @game.add_player(@player)
    end
  
    it "should w00t on roll >= 5" do
      # Old rspec
      #Die.any_instance.stub(:roll).and_return(5)
      # new rspec
      allow_any_instance_of(Die).to receive(:roll).and_return(5)
      rounds = 2
      @game.play(rounds)
      expect(@player.health).to eq(@initial_health + rounds * 15)
    end
  
    it "should not change health when 2 < roll < 5" do
      allow_any_instance_of(Die).to receive(:roll).and_return(3)
      @game.play(1)
      expect(@player.health).to eq(@initial_health)
    end
  
    it "should blam on roll <= 2" do
      allow_any_instance_of(Die).to receive(:roll).and_return(2)
      rounds = 2
      @game.play(rounds)
      expect(@player.health).to eq(@initial_health - rounds * 10)
    end
  
    it "assigns a treasure for points during a player's turn" do
      game = Game.new("Knuckleheads")
      player = Player.new("moe")
      game.add_player(player)
      game.play(1)
      expect(player.points).not_to be_zero
    end
  
  end
end