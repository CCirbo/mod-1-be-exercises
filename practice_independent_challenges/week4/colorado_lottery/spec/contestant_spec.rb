require "./lib/contestant"
require "./lib/game"
require "pry"
require 'rspec'

RSpec.configure do |config|
    config.formatter = :documentation 
    end

 RSpec.describe Contestant do
    before(:each) do
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
    end
    describe '#initialize' do
        xit "should exist" do
            expect(@alexander).to be_a Contestant   
            expect(@benjamin).to be_a Contestant   
        end

        it "has a name" do
            expect(@alexander.full_name).to eq("Alexander Aigiades")
            expect(@benjamin.full_name).to eq("Benjamin Franklin")
        end

        it 'has an age' do
            expect(@alexander.age).to eq(28)
            expect(@benjamin.age).to eq(17)
        end

        it 'has a state of residence' do
            expect(@alexander.state_of_residence).to eq("CO")
            expect(@benjamin.state_of_residence).to eq("PA")
        end

        it "has spending money" do
           expect(@alexander.spending_money).to eq(10)
           expect(@benjamin.spending_money).to eq(100)
        end
    end

    describe '#out of state' do
        it "can tell if resident is not in Colorado" do
            expect(@alexander.out_of_state?).to eq(false)
            expect(@benjamin.out_of_state?).to eq(true)
        end
    end

    describe '#if resident has game interests' do
        it "it is empty by default" do
            expect(@alexander.game_interests).to eq([])
            expect(@benjamin.game_interests).to eq([])
        end

        it "if resident can add game interests" do
            expect(@alexander.game_interests).to eq([])
            @alexander.add_game_interest).to eq('Mega Millions')
            @alexander.add_game_interest).to eq('Pick 4')
            expect(@alexander.game_interests).to eq(["Mega Millions", "Pick 4"])

            expect(@benjamin.game_interests).to eq([])
            @benjamin.add_game_interest).to eq('Mega Millions')
            # expect(benjamin.add_game_interest).to eq('Pick 4')
            expect(@benjamin.game_interests).to eq(["Mega Millions"])

        end
    end
end




