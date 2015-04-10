require_relative "die"
require_relative "game_turn"
require_relative "treasure_trove"

module StudioGame
  class Game
  
    attr_reader :title
  
    def initialize(title)
      @title = title 
      @players = []
      @die = Die.new
      @round_number = 1
    end
  
    def load_players(players_file)
      File.open(players_file) do |file|
        file.readlines.each do |line|
          add_player(Player.from_csv(line))
        end
      end
    end
  
    def add_player(player)
      @players.push(player)
    end
  
    def print_player_name_and_health(player)
      puts "#{player.name.capitalize} (#{player.health})\n"
    end
  
    def high_score_entry(player)
      "#{player.name.capitalize.ljust(20, '.')} #{player.score}"
    end
  
    def save_high_scores(high_scores_file="high_scores.txt")
      File.open(high_scores_file, 'w') do |file|
        file.puts "#{@title.capitalize} High Scores:\n"
        @players.sort.each do |player|
          file.puts high_score_entry(player)
        end
      end
    end
  
    def print_stats
      strong, wimpy = @players.partition { |p| p.strong? }
      puts "\n#{@title.capitalize} Statistics:\n\n"
      puts "#{strong.length} strong players:\n"
      strong.each do |player|
        print_player_name_and_health(player)
      end
      puts "\n"
      puts "#{wimpy.length} wimpy players:\n"
      wimpy.each do |player|
        print_player_name_and_health(player)
      end
    
      @players.each do |player|
        puts"\n#{player.name}'s total points:\n"
        player.each_found_treasure { |treasure| puts "#{treasure.points} total #{treasure.name} points"}
        puts"#{player.points} grand total points\n"
      end
    
      puts "\n#{@title.capitalize} High Scores:\n"
      @players.sort.each do |player|
        puts high_score_entry(player)
      end
    
    end
  
    def play(rounds)
      puts "\nThere are #{@players.length} players in #{@title}\n"
      @players.each do |player|
        puts player
      end
    
      treasures = TreasureTrove::TREASURES
      puts "\nThere are #{treasures.length} treasures to be found\n"
      treasures.each do |treasure|
        puts "A #{treasure.name} is worth #{treasure.points} points\n"
      end
    
      1.upto(rounds) do |round|
        puts "\nRound #{@round_number}"
        @players.each do |player|
          GameTurn.take_turn(player, @die, TreasureTrove.random)
        end
        @round_number += 1
      end
    end
  end
end
