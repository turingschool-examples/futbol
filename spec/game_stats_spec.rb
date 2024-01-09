require './spec/spec_helper.rb'

RSpec.describe GameStats do 
    describe '#initialize' do 
        it 'exists' do 
            stats = GameStats.new(4, 0, 6, 2)

            expect(stats.highest_score).to eq(4)
            expect(stats.lowest_score).to eq(0)
            expect(stats.home_team).to eq(6)
            expect(stats.away_team).to eq(2)
        end
    end
    # Highest sum of the winning and losing teams’ scores
    describe '#highest_total_score' do 
        xit 'calculates the highest total score' do 
            stats = GameStats.new 
            
            expect(stats.highest_total_score(hs + ls)).to eq(sum)
        end
    end
end