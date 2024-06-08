require 'spec_helper'
require 'rspec'

RSpec.configure do |config|
  config.formatter = :documentation
  end
  
RSpec.describe StatTracker do
  before(:each) do
    game_path       = './data/games.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @league_stats = @stat_tracker.league_stats
  end

    it 'exists & has attributes' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end
 
  describe '#highest_total_score' do 
      it 'can determine highest sum of the winning and losing teams scores' do
      expect(@stat_tracker.highest_total_score).to be_a(Integer)
      expect(@stat_tracker.highest_total_score).to eq(11)
    end
  end

  describe '#lowest_total_score' do 
  it 'can determine lowest sum of the winning and losing teams scores' do
      expect(@stat_tracker.lowest_total_score).to be_a(Integer)
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end
  end

  describe '#percentage_home_wins' do
    it 'can determine percentage of games that a home team has won (rounded to the nearest 100th)' do
      expect(@stat_tracker.percentage_home_wins).to be_a(Float)
      expect(@stat_tracker.percentage_home_wins).to eq(43.5)
    end
  end

  describe '#percentage_visitor_wins' do
     it 'can determine percentage of games that a visitor has won (rounded to the nearest 100th)' do
      expect(@stat_tracker.percentage_visitor_wins).to be_a(Float)
      expect(@stat_tracker.percentage_visitor_wins).to eq(36.11)
    end
  end
  
  describe '#percentage_ties' do 
  it 'can determine percentage of games that has resulted in a tie (rounded to the nearest 100th)' do 
      expect(@stat_tracker.percentage_ties).to be_a(Float)
      expect(@stat_tracker.percentage_ties).to eq(20.39)
    end
  end

  describe '#count_of_games_by_season' do 
    it 'brings back a hash with season names (e.g. 20122013) as keys and counts of games as values' do
      expect(@stat_tracker.count_games_in_seasons).to be_a(Hash)
      expect(@stat_tracker.count_games_in_seasons).to eq({"20122013"=>806, "20132014"=>1323, "20142015"=>1319})
    end
  end

  describe '#average_goals_per_game' do
    it 'returns avg number of goals scored in a game for all seasons for both home and away goals (rounded to the nearest 100th)' do 
      expect(@stat_tracker.average_goals_per_game).to be_a(Float)
      expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end
end

describe '#average_goals_by_season' do
  it 'returns avg number of goals scored in a game in a hash w/season names as keys and a float for avg # of goals rounded to the nearest 100th' do
    expect(@stat_tracker.average_goals_per_season).to be_a(Hash)
    expect(@stat_tracker.average_goals_per_season).to eq({"20122013"=>4.12, "20132014"=>4.19, "20142015"=>4.14, "20152016"=>4.16, "20162017"=>4.23})
  end
end

  describe 'team_count' do
    it 'can count the number of teams in the data' do
        expect(@league_stats.count_of_teams).to be_an(Integer)
        expect(@league_stats.count_of_teams).to eq(32) 
    end
end

describe 'best_offense' do
    it 'can name the team with the highest average goals per game across all seasons' do
        expect(@league_stats.best_offense).to be_a(String) 
        expect(@league_stats.best_offense).to eq("Reign FC") 
    end
end

describe 'worst_offense' do
    it 'can name the team with the lowest avg number of goals scored per game across all seasons' do
        expect(@league_stats.worst_offense).to be_a(String)
        expect(@league_stats.worst_offense).to eq("Utah Royals FC")
    end
end

describe 'highest_scoring_visitor' do
    it 'can name the team with the highest avg score per game when they are away' do
        expect(@league_stats.highest_scoring_visitor).to be_a(String) 
        expect(@league_stats.highest_scoring_visitor).to eq("FC Dallas") 
    end
end

describe 'highest_scoring_home_team' do
    it 'can name the team with the highest avg score per game when they are home' do
        expect(@league_stats.highest_scoring_home_team).to be_a(String)
        expect(@league_stats.highest_scoring_home_team).to eq("Reign FC") 
    end
end

describe 'lowest_scoring_visitor' do
    it 'can name the team with the lowest avg score per game when they are a vistor' do
        expect(@league_stats.lowest_scoring_visitor).to be_a(String)
        expect(@league_stats.lowest_scoring_visitor).to eq("San Jose Earthquakes") 
    end
end

describe 'lowest_scoring_home_team' do
    it 'can name the team with the lowest avg score per game when they are at home' do
        expect(@league_stats.lowest_scoring_home_team).to be_a(String)
        expect(@league_stats.lowest_scoring_home_team).to eq("Utah Royals FC") 
    end
  end
end