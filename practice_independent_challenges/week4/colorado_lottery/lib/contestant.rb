class Contestant
    attr_reader :first_name,
                :last_name,
                :age,
                :state_of_residence,
                :spending_money,
                :game_interests
            

    def initialize(contestant_info)
       @first_name = contestant_info[:first_name] 
       @last_name = contestant_info[:last_name]
       @age = contestant_info[:age]
       @state_of_residence = contestant_info[:state_of_residence]
       @spending_money = contestant_info[:spending_money]
       @game_interests = []

    #    could have done this also, 
    #  @full_name = "#{contestant_info[:first_name]} #{contestant_info[:last_name]}"
    # or @full_name = contestant_info[:first_name] + ' ' + contestant_info[:last_name]
    end

    def full_name
        "#{first_name} #{last_name}"
    end

    def out_of_state?
    @state_of_residence != "CO"
    # how did we get this, @state_of_residence != "CO" because the test and the 
    # pattern is asking us who is not from CO. Simple
    end
    
    def add_game_interest(game)
        @game_interests << game

    end
 
end