require 'spec_helper'
require './lib/game_statistics'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe GameStatistics do
  before(:each) do
    @games = CSV.read('./data/games.csv', headers: true, header_converters: :symbol)
    @game_statistics = GameStatistics.new(@games)
  end

  describe 'initialization' do
    it '#initialize' do
      expect(@game_statistics).to be_an_instance_of(GameStatistics)
    end

    it '#attributes' do
      expect(@game_statistics.instance_variable_get(:@games)).not_to be_empty
    end
  end

  describe 'instance methods' do
    describe '#calculate_percentage' do
      it 'percentage of home wins' do
        percentage = @game_statistics.calculate_percentage { |game| game[:home_goals].to_i > game[:away_goals].to_i }
        expect(percentage).to eq(0.44) 
      end

      it 'percentage of visitor wins' do
        percentage = @game_statistics.calculate_percentage { |game| game[:away_goals].to_i > game[:home_goals].to_i }
        expect(percentage).to eq(0.36) 
      end

      it 'percentage of ties' do
        percentage = @game_statistics.calculate_percentage { |game| game[:home_goals].to_i == game[:away_goals].to_i }
        expect(percentage).to eq(0.2) 
      end
    end

    describe '#highest_total_score' do
      it '#highest_score' do
        expect(@game_statistics.highest_score).to eq(11) 
      end
      it 'highest sum of the winning/losing teams scores' do
        expect(@game_statistics.highest_total_score).to eq(11) 
      end
    end

    describe '#lowest_total_score' do
      it '#lowest_score' do
        expect(@game_statistics.lowest_score).to eq(0) 
      end
      it 'lowest sum of the winning/losing teams scores' do
        expect(@game_statistics.lowest_total_score).to eq(0) 
      end
    end

    describe '#percentage_home_wins' do
      it 'percentage of games that a home team has won' do
        expect(@game_statistics.percentage_home_wins).to eq(0.44) 
      end
    end

    describe '#percentage_visitor_wins' do
      it 'percentage of games that a visitor has won' do
        expect(@game_statistics.percentage_visitor_wins).to eq(0.36) 
      end
    end

    describe '#percentage_ties' do
      it 'percentage of games that has resulted in a tie' do
        expect(@game_statistics.percentage_ties).to eq(0.2) 
      end
    end

    describe '#count_of_games_by_season' do
      it 'games returned as values' do
        expect(@game_statistics.count_of_games_by_season).to eq({
          "20122013"=>806, "20132014"=>1323, "20142015"=>1319, "20152016"=>1321, "20162017"=>1317, "20172018"=>1355
        }) 
      end
    end

    describe '#average_goals_per_game' do
      it 'average goals scored in a game across all seasons' do
        expect(@game_statistics.average_goals_per_game).to eq(4.22) 
      end
    end

    describe '#average_goals_by_season' do
      it 'number of goals in a game for that season returned as values' do
        expect(@game_statistics.average_goals_by_season).to eq({
          "20122013"=>4.12, "20132014"=>4.19, "20142015"=>4.14, "20152016"=>4.16, "20162017"=>4.23, "20172018"=>4.44
        }) 
      end
    end
  end
end