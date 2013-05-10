$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "lib")
require "player"
require "card"
require "deck"
require "game_engine"

#
# A simple game where each player is dealt 1 card and who-ever has the highest card wins
#

HAND_SIZE = 1
SIZE_OF_DECK = 52

# Get the number of players, then their names

puts "Welcome to the High Card Game"
puts "Enter number of players"
player_count = gets
player_count = player_count.to_i

if player_count > 0 and player_count < (SIZE_OF_DECK / HAND_SIZE)
  # Load up some players
  players = []
  
  (0...player_count).each do |index|
    print "Enter name for player ##{index + 1}: "
    name = gets
    name = name.chomp
    players << Player.new(name)
  end

  # Initialize a new game
  game_engine = GameEngine.new(players, HAND_SIZE)

  # Let's see the setup game
  game_engine.show
  
  # Let's play and see who wins
  game_engine.play

else

  puts "Player count should be between 0 and #{(SIZE_OF_DECK / HAND_SIZE)}"

end