class GameEngine

  SUITS = %w(Clubs Diamonds Hearts Spades)
  RANKS = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)

  def initialize(players, size_of_hand=1)
    cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(rank, suit)
      end
    end

    @deck = Deck.new(cards)
    @deck.shuffle
    
    @players = players
    @players.each do |player|
      (0...size_of_hand).each do |index|
        player.hand << @deck.deal
      end
    end
  end

  def show
    puts "Current state of the game:"
    @players.each {|player| player.show}
  end

  def play
    high_card_owner = nil
    @players.each do |player|
      if high_card_owner.nil? 
        high_card_owner = player
      else
        high_card_owner = highest_player(high_card_owner, player)
      end
    end

    puts "Winner: #{high_card_owner.name}"
  end

  def highest_player(player1, player2)
    card1 = player1.hand.first
    card2 = player2.hand.first
    highest_player = nil

    if RANKS.index(card1.rank) == RANKS.index(card2.rank)
      # We need to compare the suit if the rank is the same
      if SUITS.index(card1.suit) >= SUITS.index(card2.suit)
        highest_player = player1
      else
        highest_player = player2
      end
    elsif RANKS.index(card1.rank) > RANKS.index(card2.rank)
      highest_player = player1
    else
      highest_player = player2
    end

    highest_player
  end

end