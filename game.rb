class Game

  attr_accessor :players

  def initialize options = {}
    @players = options [:players] || []
    @turn_counter = 0
    @main_deck = Deck.new({})
    @active_player = @players[0]
    @nonactive_player = @players[1]
  end

  def game_start

    determine_first_player

    prepare_52cards_deck

    deal_cards

    play

  end

  def play

    play_a_card

    @turn_counter += 1

    print_turn_stats


    if @active_player.personal_deck.size == 0 # check if player has run our of cards, which means that another player has won

      victory_message

    elsif @main_deck.cards.size > 1 && @main_deck.cards[-1].suit == @main_deck.cards[-2].suit # check if top two cards are of same suit

      take_all_cards

      play
    else

      next_player

      play
    end
  end


  def determine_first_player
    # determines who gonna take first turn, second player has slight advantage here, because it doesn't reroll on equal

    if @active_player.roll_a_die(20)<@nonactive_player.roll_a_die(20)
      next_player
    end
    print_roll_winner
  end

  def print_roll_winner
    puts "#{@active_player.name} wins the roll, and he'll take the first turn \n \n"
  end

# create standard 52 cards deck and make card order random
  def prepare_52cards_deck

    @main_deck.crack_new_one((2..14).to_a, %w{spades clubs diamonds hearts})
    @main_deck.shuffle_it
    print_shuffle

  end

  def print_shuffle
    puts "shuffling the deck \n \n"
  end

# split deck between two players
  def deal_cards
    print_dealing
    @active_player.personal_deck = @main_deck.cards.each_slice(@main_deck.cards.length/2).to_a[0]
    @nonactive_player.personal_deck = @main_deck.cards.each_slice(@main_deck.cards.length/2).to_a[1]
    clear_deck
  end

  def clear_deck
    @main_deck.cards = []
  end

  def print_dealing
    puts "dealing cards to players \n \n"
  end


# moves 'top' card from active_players array to main_deck array
  def play_a_card
    @main_deck.cards << @active_player.personal_deck[-1]
    @active_player.personal_deck.pop
  end

#prints some info about current state of affairs and wait for any input
  def print_turn_stats
    puts "Turn № #{@turn_counter}"
    puts "it's #{@active_player.name}s turn"
    puts "Current card is: #{@main_deck.cards[-1].name}"
    puts "#{@active_player.name} has #{@active_player.personal_deck.size} cards.
#{@nonactive_player.name} has #{@nonactive_player.personal_deck.size} cards. "

    wait_until_input
  end

#adds all the cards from main deck to the start of active player array,
# empties main deck, then active player takes another turn
  def take_all_cards
    taker_print
    @active_player.personal_deck = @main_deck.cards.reverse + @active_player.personal_deck
    clear_deck
  end

  def taker_print
    puts ("#{@active_player.name} takes it all!")
  end

  #passes turn to another player by switching players in array
  def next_player
    @active_player, @nonactive_player = @nonactive_player, @active_player

  end


  def victory_message
    puts "\n#{@nonactive_player.name} was victorious!!!"
  end

  def wait_until_input

    wait_print
    gets

  end

  def wait_print

    puts 'press enter to continue'

  end


end