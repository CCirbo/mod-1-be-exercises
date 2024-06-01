class Game
    attr_reader :name,
                :cost,
                :drawing

    def initialize(name, cost, drawing = true)
        @name = name
        @cost = cost
        @drawing = drawing
    end

end