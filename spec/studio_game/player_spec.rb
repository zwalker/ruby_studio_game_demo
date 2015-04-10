require 'studio_game/player'
require 'studio_game/treasure_trove'

module StudioGame
  describe Player do
  
    before do
      @initial_health = 150
      @player = Player.new("larry", @initial_health)
    end
  
    # Old rspec
  #  it "has a capitalized name" do
  #    @player.name.should == "Larry"
  #  end
  
    it "has a capitalized name" do
      expect(@player.name).to eq("Larry")
    end
  
    it "has an initial health" do
      expect(@player.health).to eq(150)
    end
  
    it "has a string representation" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))
      expect(@player.to_s).to include("I'm Larry with a health of 150 and a score 250")
    end
  
    it "computes a score as the sum of its health and points" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))
      expect(@player.score).to eq(@initial_health + 50 + 50)
    end
  
    it "increases health by 15 when w00ted" do
      @player.w00t
      expect(@player.health).to eq(@initial_health + 15)
    end
  
    it "decreases health by 10 when blamed" do
      @player.blam
      expect(@player.health).to eq(@initial_health - 10)
    end
  
    it "computes points as the sum of all treasure points" do
      expect(@player.points).to eq(0)
      @player.found_treasure(Treasure.new(:hammer,50))
      expect(@player.points).to eq(50)
      @player.found_treasure(Treasure.new(:crowbar, 400))
      expect(@player.points).to eq(450)
      @player.found_treasure(Treasure.new(:hammer, 50))
      expect(@player.points).to eq(500)
    end
  
    it "yields each found treasure and its total points" do
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
    
      yielded = []
      @player.each_found_treasure do |treasure|
        yielded << treasure
      end
    
      expect(yielded).to eq([
        Treasure.new(:skillet, 200),
        Treasure.new(:hammer, 50),
        Treasure.new(:bottle, 25)
        ])
    end
    

    context "player with health of 150" do
  
      before do
        @player = Player.new("zach", 150)
      end
  
      it "is strong" do
        expect(@player.strong?).to eq(true)
        expect(@player).to be_strong
      end
    end

    context "player with health of 100" do
  
      before do
        @player = Player.new("zach", 100)
      end
  
      it "is not strong" do
        expect(@player).not_to be_strong
      end 
    end

    context "in a collection of players" do
      before do
        @player1 = Player.new("moe", 100)
        @player2 = Player.new("curly", 200)
        @player3 = Player.new("larry", 300)
    
        @players = [@player1, @player2, @player3]
      end

      it "is sorted by decreasing score" do
        expect(@players.sort).to eq([@player3, @player2, @player1])
      end
    end

  end
end