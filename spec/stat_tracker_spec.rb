require './spec/spec_helper.rb'

RSpec.describe StatTracker do 
    describe '#initialize' do 
        it 'exists' do 
            game_statistics_instance = GameStatistics.new
            stat_tracker = StatTracker.new(game_statistics_instance)
      
            expect(stat_tracker).to be_a StatTracker
            expect(stat_tracker.game_statistics).to be_a GameStatistics
        end
    end

    describe '#self.from_csv(location)' do 
        it 'can access the location' do 
            game_statistics_instance = GameStatistics.new
            stat_tracker = StatTracker.new(game_statistics_instance)

        end
    end
end