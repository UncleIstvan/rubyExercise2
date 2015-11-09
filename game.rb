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

    print_turn_stats

    if @active_player.personal_deck.size == 0 # check if player has run our of cards, which means that another player has won

      victory_message

    elsif @main_deck.cards.size > 1 && @main_deck.cards[-1].suit == @main_deck.cards[-2].suit # check if top two cards are of same suit

      take_all_cards

    else

      next_player

    end
  end


  def determine_first_player
    # determines who gonna take first turn, second player has slight advantage here, because it doesn't reroll on equal

    if @players[0].roll_a_die(20)>@players[1].roll_a_die(20)
      @players[0], @players[1] = @players[1], @players[0]
    end
    puts "#{@players[0].name} wins the roll, and he'll take the first turn \n \n"
  end

# create standard 52 cards deck and make card order random
  def prepare_52cards_deck
    @main_deck.crack_new_one((2..14).to_a, %w{spades clubs diamonds hearts})
    @main_deck.shuffle_it
    puts "shuffling the deck \n \n"
  end

# split deck between two players
  def deal_cards
    puts "dealing cards to players \n \n"
    @active_player.personal_deck = @main_deck.cards.each_slice(@main_deck.cards.length/2).to_a[0]
    @nonactive_player.personal_deck = @main_deck.cards.each_slice(@main_deck.cards.length/2).to_a[1]
    @main_deck.cards = []
  end

# moves 'top' card from active_players array to main_deck array
  def play_a_card
    @main_deck.cards << @active_player.personal_deck[-1]
    @active_player.personal_deck.pop
    @turn_counter += 1
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
    puts ("#{@active_player.name} takes it all!")
    @active_player.personal_deck = @main_deck.cards.reverse + @active_player.personal_deck
    @main_deck.cards = []
    play
  end

  #passes turn to another player by switching players in array
  def next_player
    @active_player, @nonactive_player = @nonactive_player, @active_player
    play #(main_deck, active_player, nonactive_player)
  end


  def victory_message
    puts "\n#{@nonactive_player.name} was victorious!!!"
  end

  def wait_until_input

    puts 'press enter to continue'
    gets

  end


end