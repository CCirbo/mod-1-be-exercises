class ColoradoLottery
    attr_reader :registered_contestants,
                :winners,
                :current_contestants
    def initialize
     @registered_contestants = Hash.new { |hash, key| hash[key] = [] }
     @winners = []
     @current_contestants = {}
    end

    def interested_and_18?(contestant, game)
        contestant.age >= 18 && contestant.game_interests.include?(game.name)
     
        # if contestant is both interested in a given name 
        # and 18 and over
        # return true
        # else false
        # binding.pry
    end

    def can_register?(contestant, game)
        # binding.pry
        # if contestant is interested, 18 and lives in CO, they can get any game
        # so don't need to test for that, we only need to look at who is not
        # a resident of colorado
        # if a game is national, they can register
        # then can register for game
        # game.national_drawing? == false it is for CO residents only
        if game.national_drawing? == false && contestant.state_of_residence != "CO" 
            false
        else
         interested_and_18?(contestant, game) 
        end
    end

    def register_contestant(contestant, game)
     
        @registered_contestants[game] << contestant if can_register?(contestant, game)
        contestant 
    end

    def eligible_contestants(game)
      @registered_contestants[game].select do |contestant|
        contestant.spending_money >= game.cost
      end
    end

    
end   