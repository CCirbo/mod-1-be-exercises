require "./lib/contestant"
require "./lib/game"
require "./lib/colorado_lottery"
require "pry"
require 'rspec'

RSpec.configure do |config|
    config.formatter = :documentation 
    end

 RSpec.describe ColoradoLottery do
    before(:each) do
        @lottery = ColoradoLottery.new
        @pick_4 = Game.new('Pick 4', 2)
        @mega_millions = Game.new('Mega Millions', 5, true)
        @cash_5 = Game.new('Cash 5', 1)
        @alexander = Contestant.new({first_name: 'Alexander',
                                    last_name: 'Aigiades',
                                    age: 28,
                                    state_of_residence: 'CO',
                                    spending_money: 10})
        @benjamin = Contestant.new({
                                    first_name: 'Benjamin',
                                    last_name: 'Franklin',
                                    age: 17,
                                    state_of_residence: 'PA',
                                    spending_money: 100}) 
        @frederick = Contestant.new({
                                    first_name:  'Frederick',
                                    last_name: 'Douglass',
                                    age: 55,
                                    state_of_residence: 'NY',
                                    spending_money: 20})
        @winston = Contestant.new({
                                    first_name: 'Winston',
                                    last_name: 'Churchill',
                                    age: 18,
                                    state_of_residence: 'CO',
                                    spending_money: 4})                            
    end

    it 'it exists' do
        expect(@lottery).to be_an_instance_of(ColoradoLottery)
    end

    it "has no registered_contestants by default" do
        expect(@lottery.registered_contestants).to eq({})        
    end

    it 'has no lottery_winners by default' do
        expect(@lottery.winners).to eq([])
    end

    it 'has no lottery_current_winners by default' do
        expect(@lottery.current_contestants).to eq({})
    end

    it "can tell if a contestant is interested in a game and over 18" do
        @alexander.add_game_interest('Pick 4')
        # @alexander.add_game_interest('Mega Millions')
        expect(@lottery.interested_and_18?(@alexander, @pick_4)).to eq(true)
        expect(@lottery.interested_and_18?(@alexander, @cash_5)).to eq(false)
      
        # @winston.add_game_interest('Mega Millions')

        @benjamin.add_game_interest('Mega Millions')
        expect(@lottery.interested_and_18?(@benjamin, @mega_millions)).to eq(false)
        expect(@lottery.interested_and_18?(@benjamin, @cash_5)).to eq(false)
        # @winston.add_game_interest('Cash 5')
    end

    it "can register? contestants if interested, 18 and is in CO" do
        @alexander.add_game_interest('Pick 4')  #we need a string back 
        @alexander.add_game_interest("Mega Millions")  #we need a string back 
        expect(@lottery.can_register?(@alexander, @pick_4)).to eq(true)
        expect(@lottery.can_register?(@alexander, @mega_millions)).to eq(true)
        expect(@lottery.can_register?(@alexander, @cash_5)).to eq(false)

        @frederick.add_game_interest('Mega Millions')
        @frederick.add_game_interest('Cash 5')
        expect(@lottery.can_register?(@frederick, @mega_millions)).to eq(true)
        expect(@lottery.can_register?(@frederick, @cash_5)).to eq(false)

        @winston.add_game_interest('Cash 5')
        @winston.add_game_interest('Mega Millions')
        expect(@lottery.can_register?(@winston, @cash_5)).to eq(true)
        expect(@lottery.can_register?(@winston, @cash_5)).to eq(true)

        @benjamin.add_game_interest('Mega Millions')
        expect(@lottery.can_register?(@benjamin, @mega_millions)).to eq(false)
    end

    it 'can register_contestants that can register' do
        # if contestant can register(we have this), then shovel them in registered contestent
        # return a contestant
        # make sure the hash @register_contestants contains the contestants
        # registered_contestents is a hash with keys of games and values of
        # contestants registered.
        # We will only register contestants that `#can_register?`
        # `register_contestant`       | `Contestant`
        @alexander.add_game_interest('Pick 4')  
        @alexander.add_game_interest("Mega Millions")  #we need a string back 

        @frederick.add_game_interest('Mega Millions')
        @frederick.add_game_interest('Cash 5') #cannot register

        @benjamin.add_game_interest('Mega Millions')
    
        expect(@lottery.register_contestant(@alexander, @pick_4)).to eq(@alexander)
        expect(@lottery.registered_contestants).to eq({@pick_4 => [@alexander]})
        expect(@lottery.register_contestant(@alexander, @mega_millions)).to eq(@alexander)
        expect(@lottery.registered_contestants).to eq({@pick_4 => [@alexander], @mega_millions => [@alexander]})
        
        expect(@lottery.register_contestant(@frederick, @mega_millions)).to eq(@frederick)
      
        expect(@lottery.registered_contestants).to eq({@pick_4 => [@alexander], @mega_millions => [@alexander, @frederick]})
        expect(@lottery.register_contestant(@frederick, @cash_5)).to eq(@frederick)
        expect(@lottery.registered_contestants).to eq({@pick_4 => [@alexander], @mega_millions => [@alexander, @frederick]})

        expect(@lottery.register_contestant(@benjamin, @mega_millions)).to eq(@benjamin)
        expect(@lottery.registered_contestants).to eq({@pick_4 => [@alexander], @mega_millions => [@alexander, @frederick]})


    end
     
    it "can have eligible_contestants" do
        # `eligible_contestants`      | `Array` of `Contestant` objects
        # who have registered for a given game()and have more spending monet
        # than the cost to play
        @alexander.add_game_interest('Pick 4')  
        @alexander.add_game_interest("Mega Millions")  #we need a string back 

     
        @frederick.add_game_interest('Mega Millions')

   

        @winston.add_game_interest('Mega Millions')

        @lottery.register_contestant(@alexander, @pick_4)
        @lottery.register_contestant(@alexander, @mega_millions)
        
        @lottery.register_contestant(@frederick, @mega_millions)
   

        @lottery.register_contestant(@winston, @mega_millions)
        expect(@lottery.registered_contestants).to eq({@pick_4 => [@alexander], @mega_millions => [@alexander, @frederick, @winston]})
        expect(@lottery.eligible_contestants(@pick_4)).to eq([@alexander])
        expect(@lottery.eligible_contestants(@mega_millions)).to eq([@alexander, @frederick])
    end
    #  it "it can charge contestants" do 
    #     @alexander.add_game_interest('Pick 4')  
    #     @alexander.add_game_interest("Mega Millions")  #we need a string back 
     
    #     @frederick.add_game_interest('Mega Millions')

    #     @winston.add_game_interest('Mega Millions')

    #     @lottery.register_contestant(@alexander, @pick_4)
    #     @lottery.register_contestant(@alexander, @mega_millions)
        
    #     @lottery.register_contestant(@frederick, @mega_millions)
   
    #     @lottery.register_contestant(@winston, @mega_millions)
    #     # expect(@lottery.eligible_contestants(@pick_4)).to eq([@alexander])
    #     # expect(@lottery.eligible_contestants(@mega_millions)).to eq([@alexander, @frederick])
    #     expect(@lottery.current_contestants).to eq({})
    #     @lottery.charge_contestants(@pick_4)
    #     expect(@lottery.current_contestants).to eq({@pick_4 => [@alexander], @mega_millions => [@alexander, @frederick]})
    #     expext(@alexander.spending_money).to eq(10)
    #  end    
    # `current_contestants` |`Hash` where the key is a `Game` object and 
    # the values is an array of contestant names 
    # take their money and put them in the current array
   

end