class GameEngine

  attr_reader :players, :deck

  def initialize(players, size_of_hand=1)

    @deck = Deck.new(Card.create_cards)
    @deck.shuffle

    @players = players
    @players.each do |player|
      (0...size_of_hand).each do |index|
        player.take_card(@deck.deal)
      end
    end
  end

  def show
    puts "Current state of the game:"
    players.each {|player| player.show}
  end

  def play
    high_card_owner = nil
    players.each do |player|
      if high_card_owner.nil?
        high_card_owner = player
      else
        high_card_owner = highest_player(high_card_owner, player)
      end
    end

    puts "Winner: #{high_card_owner.name}"
  end

  def highest_player(player1, player2)
    card1 = player1.play_card
    card2 = player2.play_card
    highest_player = nil

    if Card.equal_rank(card1,card2) == 0
      # We need to compare the suit if the rank is the same
      if Card.equal_suit(card1,card2)  >= 0
        highest_player = player1
      else
        highest_player = player2
      end
    elsif Card.equal_rank(card1,card2) > 0
      highest_player = player1
    else
      highest_player = player2
    end

    highest_player
  end

end
