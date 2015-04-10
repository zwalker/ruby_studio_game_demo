require 'studio_game/treasure_trove'

module StudioGame
  describe TreasureTrove do
    it "returns a random treasure" do
      treasure = TreasureTrove.random
  
      expect(TreasureTrove::TREASURES).to include(treasure)
    end
  end
end
