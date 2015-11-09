class Deck

  attr_accessor :cards

  def initialize options
    @cards = options [:cards] || []
  end


  # creates new unshuffled  deck, depending on number of card values and suits
  def crack_new_one (card_count_array, suits_array)
    @cards = []
    card_count_array.each {|value|  suits_array.each{|suit|
      new_card = Card.new ({
                              value: value,
                              suit: suit
                          })
      @cards.push(new_card)
    }}
    @cards
  end


  # shuffles a deck
  def shuffle_it
    @cards.shuffle!
  end
end