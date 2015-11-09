class Player
  attr_accessor :personal_deck, :name

  def initialize options = {}
    @name = options [:name] || 'John Doe'
    @personal_deck = options [:personal_deck] || Deck.new({})
  end



  # generates random number
  def roll_a_die (number_of_sides)
    if number_of_sides >  1
      rand(number_of_sides)
    else
      rand(6)
    end
  end


end