require "./lib/contestant"
require "./lib/game"
require "pry"
require 'rspec'

RSpec.configure do |config|
    config.formatter = :documentation 
    end

 RSpec.describe Game do
   describe '#initialize' do

        it 'should exist' do
            pick_4 = Game.new('Pick 4', 2)
            mega_millions = Game.new('Mega Millions', 5, true)

            expect(mega_millions).to be_an_instance_of(Game) 
            expect(pick_4).to be_an_instance_of(Game)
        end 

        it 'has a name' do
            pick_4 = Game.new('Pick 4', 2)
            mega_millions = Game.new('Mega Millions', 5, true)

            expect(mega_millions.name).to eq("Mega Millions")
            expect(pick_4.name).to eq("Pick 4")
        end

        it 'has a cost attributes' do
            pick_4 = Game.new('Pick 4', 2)
            mega_millions = Game.new('Mega Millions', 5, true) 

            expect(mega_millions.cost).to eq(5)
            expect(pick_4.cost).to eq(2)
        end
    end  
    describe '#national_drawing' do
        xit 'says whether or not it is a national drawing' do
            pick_4 = Game.new('Pick 4', 2)
            mega_millions = Game.new('Mega Millions', 5, true) 

            expect(mega_millions.national_drawing?).to eq(true)
            expect(pick_4.national_drawing?).to eq(false)
        end     
    end


end