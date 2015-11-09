require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'game'

# creates two test player objects

ivan = Player.new ({
                      name: 'Ivan'
                  })
stepan = Player.new ({
                       name: 'Stepan'
                    })


# creates and launches new GAME object
game = Game.new ({
                   players: [ivan,stepan]
               })
game.game_start




