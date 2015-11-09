class Card

  attr_accessor :value, :suit

  def initialize options
    @value = options [:value] || 2
    @suit = options [:suit] || 'spades'
  end


  # determines name of a card, depending on its "value", and adds suit
  def name
   case @value
     when 0
       'Joker'

     when 11
       "Jack of #{@suit}"
     when 12
       "Queen of #{@suit}"
     when 13
       "King of #{@suit}"
     when 14
       "Ace of #{@suit}"
     else
       "#{@value.to_s} of #{@suit}"

   end
  end



end