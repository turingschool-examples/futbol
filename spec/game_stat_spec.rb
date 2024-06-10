require 'spec_helper'
require 'rspec'

RSpec.configure do |config|
  config.formatter = :documentation
  end
  
RSpec.describe GameStats do
  before(:each) do
    game_path       = './data/games.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    tracker = StatTracker.from_csv(locations)
    @game_stats = tracker.game_stats
  end

  it 'exists & has attributes' do
    expect(@game_stats).to be_an_instance_of(GameStats)
  end
 
  describe '#highest_total_score' do 
    it 'can determine highest sum of the winning and losing teams scores' do
      expect(@game_stats.highest_total_score).to be_a(Integer)
      expect(@game_stats.highest_total_score).to eq(11)
    end
  end

  describe '#lowest_total_score' do 
     it 'can determine lowest sum of the winning and losing teams scores' do
      expect(@game_stats.lowest_total_score).to be_a(Integer)
      expect(@game_stats.lowest_total_score).to eq(0)
    end
  end

  describe '#percentage_home_wins' do
     it 'can determine percentage of games that a home team has won (rounded to the nearest 100th)' do
      expect(@game_stats.percentage_home_wins).to be_a(Float)
      expect(@game_stats.percentage_home_wins).to eq(0.44)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'can determine percentage of games that a visitor has won (rounded to the nearest 100th)' do
      expect(@game_stats.percentage_visitor_wins).to be_a(Float)
      expect(@game_stats.percentage_visitor_wins).to eq(0.36)
    end
  end
  
  describe '#percentage_ties' do 
     it 'it can determine percentage of games that has resulted in a tie (rounded to the nearest 100th)' do 
      expect(@game_stats.percentage_ties).to be_a(Float)
      expect(@game_stats.percentage_ties).to eq(0.2)
    end
  end

  describe '#count_of_games_by_season' do 
    it 'brings back a hash with season names (e.g. 20122013) as keys and counts of games as values' do
      expect(@game_stats.count_of_games_by_season).to be_a(Hash)
      expect(@game_stats.count_of_games_by_season).to eq({"20122013"=>806, "20132014"=>1323, "20142015"=>1319, "20152016"=>1321, "20162017"=>1317, "20172018"=>1355})
   
    end
  end

  describe '#average_goals_per_game' do
    it 'returns avg number of goals scored in a game for all seasons for both home and away goals (rounded to the nearest 100th)' do 
      expect(@game_stats.average_goals_per_game).to be_a(Float)
      expect(@game_stats.average_goals_per_game).to eq(4.22)
    end
  end

  describe '#average_goals_by_season' do
    it 'returns avg number of goals scored in a game in a hash w/season names as keys and a float for avg # of goals rounded to the nearest 100th' do
      expect(@game_stats.average_goals_by_season).to be_a(Hash)
      expect(@game_stats.average_goals_by_season).to eq({"20122013"=>4.12, "20132014"=>4.19, "20142015"=>4.14, "20152016"=>4.16, "20162017"=>4.23, "20172018"=>4.44})
    end
  end
end